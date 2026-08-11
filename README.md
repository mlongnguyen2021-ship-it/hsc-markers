# HSC Markers

Reusable Codex skills for marking NSW Higher School Certificate responses consistently and at the right level of depth.

The first marker in this repository is for Year 12 Biology. It is designed to:

- follow the question's command verb;
- reward accurate syllabus-level knowledge without demanding university-level detail;
- distinguish essential scientific terminology from optional extra detail;
- treat official sample answers as sufficient examples rather than mandatory wording;
- provide a mark, a clear judgement, actionable feedback, and a concise full-mark response.

## Included skills

| Skill | Purpose |
| --- | --- |
| [`mark-hsc-biology`](skills/mark-hsc-biology/) | Mark and improve NSW HSC Biology responses for Modules 5–8. |

## Install the Biology marker

Copy `skills/mark-hsc-biology` into your Codex skills directory:

```text
~/.codex/skills/mark-hsc-biology
```

Then invoke it with a prompt such as:

```text
Use $mark-hsc-biology to mark this 4-mark response. Here is the question,
the student answer, and the relevant marking guideline.
```

## Biology source library

The repository includes the authorised Biology materials used to calibrate this marker:

- NSW HSC papers, marking guidelines, criteria and the Stage 6 syllabus;
- Year 12 Biology notes covering Modules 5–8;
- a Markdown companion for every PDF so the collection can be searched locally.

Open the original PDF whenever a question depends on a graph, diagram, table, pedigree or page layout. One image-only notes PDF required OCR, so its Markdown companion may contain recognition errors.

See the [source catalogue](sources/biology/CATALOG.md) for the full inventory and [DATA_POLICY.md](DATA_POLICY.md) before contributing more material.

See [DATA_POLICY.md](DATA_POLICY.md) before contributing.

## Adding another HSC marker

Create a new folder under `skills/` with its own `SKILL.md`, `agents/openai.yaml`, and the references or scripts needed for that subject. Only publish source material you are authorised to redistribute, and never commit student data.
