#!/usr/bin/env bash

set -euo pipefail

target="codex"
subject="biology"
destination_root=""
force=0

usage() {
  cat <<'EOF'
Usage: install.sh [--target codex|claude-code] [--subject biology|business-studies] [--destination-root PATH] [--force]

Installs one HSC marker and its source library for Codex or Claude Code.
EOF
}

while (($#)); do
  case "$1" in
    --target)
      [[ $# -ge 2 ]] || { echo "Missing value for --target" >&2; exit 2; }
      target="$2"
      shift 2
      ;;
    --subject)
      [[ $# -ge 2 ]] || { echo "Missing value for --subject" >&2; exit 2; }
      subject="$2"
      shift 2
      ;;
    --destination-root)
      [[ $# -ge 2 ]] || { echo "Missing value for --destination-root" >&2; exit 2; }
      destination_root="$2"
      shift 2
      ;;
    --force)
      force=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$subject" in
  biology)
    skill_name="mark-hsc-biology"
    source_name="biology"
    ;;
  business-studies)
    skill_name="mark-hsc-business-studies"
    source_name="business-studies"
    ;;
  *)
    echo "Subject must be biology or business-studies." >&2
    exit 2
    ;;
esac

case "$target" in
  codex)
    destination_root="${destination_root:-${CODEX_HOME:-$HOME/.codex}}"
    invocation="\$$skill_name"
    ;;
  claude-code)
    destination_root="${destination_root:-$HOME/.claude}"
    invocation="/$skill_name"
    ;;
  *)
    echo "Target must be codex or claude-code." >&2
    exit 2
    ;;
esac

for command_name in curl unzip; do
  command -v "$command_name" >/dev/null 2>&1 || {
    echo "Required command not found: $command_name" >&2
    exit 1
  }
done

skill_destination="$destination_root/skills/$skill_name"
source_destination="$destination_root/sources/$source_name"

if ((force == 0)) && { [[ -e "$skill_destination" ]] || [[ -e "$source_destination" ]]; }; then
  echo "Already installed under $destination_root. Re-run with --force to update it." >&2
  exit 1
fi

archive_url="https://github.com/mlongnguyen2021-ship-it/hsc-markers/archive/refs/heads/main.zip"
temp_parent="${TMPDIR:-/tmp}"
temp_parent="${temp_parent%/}"
temp_dir="$(mktemp -d "$temp_parent/hsc-markers.XXXXXX")"

cleanup() {
  case "$temp_dir" in
    "$temp_parent"/hsc-markers.*) rm -rf -- "$temp_dir" ;;
  esac
}
trap cleanup EXIT

echo "Downloading the latest HSC Markers release..."
curl --fail --location --silent --show-error "$archive_url" --output "$temp_dir/hsc-markers.zip"
mkdir -p "$temp_dir/expanded"
unzip -q "$temp_dir/hsc-markers.zip" -d "$temp_dir/expanded"

repository_root="$temp_dir/expanded/hsc-markers-main"
[[ -d "$repository_root" ]] || { echo "The downloaded repository archive was invalid." >&2; exit 1; }

mkdir -p "$skill_destination" "$source_destination"
cp -R "$repository_root/skills/$skill_name/." "$skill_destination/"
cp -R "$repository_root/sources/$source_name/." "$source_destination/"

echo "Installed $skill_name for $target at $skill_destination"
echo "Restart the host if needed, then invoke $invocation."
