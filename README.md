# HSC Markers

Reusable Codex and Claude Code skills for marking NSW Higher School Certificate responses consistently and at the right level of depth.

The markers are designed to:

- follow the question's command verb;
- reward accurate syllabus-level knowledge without demanding university-level detail;
- distinguish essential subject terminology from optional extra detail;
- treat official sample answers as sufficient examples rather than mandatory wording;
- provide a mark, a clear judgement, actionable feedback, and a concise full-mark response.

## Included skills

| Skill | Purpose |
| --- | --- |
| [`mark-hsc-biology`](skills/mark-hsc-biology/) | Mark and improve NSW HSC Biology responses for Modules 5–8. |
| [`mark-hsc-business-studies`](skills/mark-hsc-business-studies/) | Mark and improve NSW HSC Business Studies responses across Operations, Marketing, Finance, and Human Resources. |

## Quick install

Never used PowerShell or Terminal before? Follow the [beginner-friendly step-by-step installation guide](INSTALL.md).

### Windows

Download the installer once in Windows PowerShell 5.1 or later:

```powershell
$installer = Join-Path $env:TEMP 'install-hsc-marker.ps1'
Invoke-WebRequest 'https://raw.githubusercontent.com/mlongnguyen2021-ship-it/hsc-markers/main/install.ps1' -OutFile $installer
Unblock-File $installer
```

Install for Codex:

```powershell
& $installer -Target Codex
```

That command installs Biology. To install Business Studies for Codex:

```powershell
& $installer -Target Codex -Subject BusinessStudies
```

Or install for Claude Code:

```powershell
& $installer -Target ClaudeCode
```

To install Business Studies for Claude Code:

```powershell
& $installer -Target ClaudeCode -Subject BusinessStudies
```

The installer includes the full source library for the subject you choose. Run it once for each subject you want. Re-run a command with `-Force` to update that subject.

### macOS and Linux

Download the Bash installer:

```bash
curl -fsSL 'https://raw.githubusercontent.com/mlongnguyen2021-ship-it/hsc-markers/main/install.sh' -o /tmp/install-hsc-marker.sh
```

Install for Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex
```

That command installs Biology. To install Business Studies for Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex --subject business-studies
```

Or install for Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code
```

To install Business Studies for Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code --subject business-studies
```

Re-run the command with `--force` to update an existing installation.

| Target and subject | Skill location | Source-library location | Invocation |
| --- | --- | --- | --- |
| Codex — Biology | `~/.codex/skills/mark-hsc-biology` | `~/.codex/sources/biology` | `$mark-hsc-biology` |
| Codex — Business Studies | `~/.codex/skills/mark-hsc-business-studies` | `~/.codex/sources/business-studies` | `$mark-hsc-business-studies` |
| Claude Code — Biology | `~/.claude/skills/mark-hsc-biology` | `~/.claude/sources/biology` | `/mark-hsc-biology` |
| Claude Code — Business Studies | `~/.claude/skills/mark-hsc-business-studies` | `~/.claude/sources/business-studies` | `/mark-hsc-business-studies` |

Restart the host after the first install, then use a prompt such as:

```text
Use $mark-hsc-biology to mark this 4-mark response. Here is the question,
the student answer, and the relevant marking guideline.
```

For Business Studies, use `$mark-hsc-business-studies` in Codex or `/mark-hsc-business-studies` in Claude Code.

## Biology source library

The repository includes the authorised Biology materials used to calibrate this marker:

- NSW HSC papers, marking guidelines, criteria and the Stage 6 syllabus;
- Year 12 Biology notes covering Modules 5–8;
- a Markdown companion for every PDF so the collection can be searched locally.

Open the original PDF whenever a question depends on a graph, diagram, table, pedigree or page layout. One image-only notes PDF required OCR, so its Markdown companion may contain recognition errors.

See the [source catalogue](sources/biology/CATALOG.md) for the full inventory and [DATA_POLICY.md](DATA_POLICY.md) before contributing more material.

## Business Studies source library

The Business Studies library contains 2015–2024 HSC papers and marking guides, the Stage 6 syllabus, and three authorised Year 12 note sets. Each of the 24 unique PDFs has a searchable Markdown companion. Exact official criteria take priority over the notes.

See the [Business Studies source catalogue](sources/business-studies/CATALOG.md) for the full inventory.

## Adding another HSC marker

Create a new folder under `skills/` with its own `SKILL.md`, `agents/openai.yaml`, and the references or scripts needed for that subject. Only publish source material you are authorised to redistribute, and never commit student data.
