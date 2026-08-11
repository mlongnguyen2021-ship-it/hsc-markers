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

## Bring your own sources

This public repository intentionally contains no exam papers, marking guidelines, syllabuses, commercial notes, converted documents, or student responses. Provide the question, mark value, stimulus, and any authorised reference material when using a marker.

See [DATA_POLICY.md](DATA_POLICY.md) before contributing.

## Adding another HSC marker

Create a new folder under `skills/` with its own `SKILL.md`, `agents/openai.yaml`, and only the generic references or scripts needed for that subject. Keep copyrighted source material and student data outside the repository.
