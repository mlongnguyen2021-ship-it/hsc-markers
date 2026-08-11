#!/usr/bin/env python3
"""Search the HSC Biology skill references and source library with context."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Search HSC Biology references and source Markdown for terms."
    )
    parser.add_argument("terms", nargs="+", help="Terms or phrases to search for")
    parser.add_argument(
        "--file",
        default="",
        help="Case-insensitive filename substring filter, such as guide-2024 or notes",
    )
    parser.add_argument(
        "--context", type=int, default=3, help="Lines of context before and after a hit"
    )
    parser.add_argument(
        "--max", type=int, default=20, dest="max_results", help="Maximum result blocks"
    )
    parser.add_argument(
        "--all", action="store_true", help="Require every term on the same line"
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    skill_root = Path(__file__).resolve().parent.parent
    repo_root = skill_root.parent.parent
    roots = [skill_root / "references", repo_root / "sources" / "biology"]
    file_filter = args.file.casefold()
    patterns = [re.compile(re.escape(term), re.IGNORECASE) for term in args.terms]
    shown = 0

    paths = sorted(path for root in roots if root.is_dir() for path in root.rglob("*.md"))
    for path in paths:
        label = path.relative_to(repo_root)
        if file_filter and file_filter not in str(label).casefold():
            continue
        try:
            lines = path.read_text(encoding="utf-8-sig", errors="replace").splitlines()
        except OSError as exc:
            print(f"WARN {path.name}: {exc}")
            continue

        hit_lines: list[int] = []
        for index, line in enumerate(lines):
            matches = [pattern.search(line) is not None for pattern in patterns]
            if (all(matches) if args.all else any(matches)):
                hit_lines.append(index)

        previous_end = -1
        for index in hit_lines:
            start = max(0, index - max(0, args.context))
            end = min(len(lines), index + max(0, args.context) + 1)
            if start <= previous_end:
                continue
            print(f"\n=== {label}:{index + 1} ===")
            for line_no in range(start, end):
                marker = ">" if line_no == index else " "
                print(f"{marker}{line_no + 1:5d} | {lines[line_no]}")
            previous_end = end - 1
            shown += 1
            if shown >= args.max_results:
                return 0

    if shown == 0:
        print("No matches found.")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
