# Beginner installation guide

You do not need to know how to code. This guide walks you through every step and gives you commands that you can copy and paste.

The installer adds two things to your computer for the subject you choose:

- the HSC marking skill;
- its source library containing the syllabus, past papers, marking material, and notes.

Nothing in your existing school files is changed or removed.

## Contents

- [Before you start](#before-you-start)
- [Choose your subject](#choose-your-subject)
- [Choose Codex or Claude Code](#choose-codex-or-claude-code)
- [Install on Windows](#install-on-windows)
- [Install on macOS](#install-on-macos)
- [Install on Linux](#install-on-linux)
- [Check that it works](#check-that-it-works)
- [Update an existing installation](#update-an-existing-installation)
- [Common problems](#common-problems)

## Before you start

You will need:

- Codex or Claude Code already installed;
- an internet connection;
- about 400 MB of free space during installation;
- five to ten minutes.

Biology contains 38 PDFs and Business Studies contains 24 PDFs. Every PDF has a searchable Markdown version, so the download can take a few minutes. It may look as though the installer has paused while the files are downloading.

## Choose your subject

Choose the marker you want to install:

| Subject | Marker command in Codex | Marker command in Claude Code |
| --- | --- | --- |
| Biology | `$mark-hsc-biology` | `/mark-hsc-biology` |
| Business Studies | `$mark-hsc-business-studies` | `/mark-hsc-business-studies` |

You can install both subjects. Run the installer once for Biology and once for Business Studies.

## Choose Codex or Claude Code

Choose the program in which you want to use the marker:

| Program | Choose this if… | How you start the marker |
| --- | --- | --- |
| Codex | You normally chat with Codex or use the Codex desktop app. | Type the `$` command shown above in your request. |
| Claude Code | You normally run Claude Code from a Terminal window. | Type the `/` command shown above. |

You only need to install the marker for the program you use. If you use both programs, you may run both installation commands.

## Install on Windows

### Step 1: open PowerShell

1. Click the Windows **Start** button.
2. Type `PowerShell`.
3. Click **Windows PowerShell** or **PowerShell**.

You do not need to select **Run as administrator**. A blue or black text window will open.

### Step 2: download the installer

1. Move your mouse over the box below.
2. Click the copy button in the top-right corner of the box, or highlight all three lines and press **Ctrl+C**.
3. Click inside PowerShell and press **Ctrl+V**.
4. Press **Enter**.

```powershell
$installer = Join-Path $env:TEMP 'install-hsc-marker.ps1'
Invoke-WebRequest 'https://raw.githubusercontent.com/mlongnguyen2021-ship-it/hsc-markers/main/install.ps1' -OutFile $installer
Unblock-File $installer
```

PowerShell may show a download progress bar. When it finishes, you will see the normal prompt again. If you see red text, go to [Common problems](#common-problems).

### Step 3: install for your program

Choose the command that matches both your program and subject.

For Biology in Codex:

```powershell
& $installer -Target Codex
```

For Business Studies in Codex:

```powershell
& $installer -Target Codex -Subject BusinessStudies
```

For Biology in Claude Code:

```powershell
& $installer -Target ClaudeCode
```

For Business Studies in Claude Code:

```powershell
& $installer -Target ClaudeCode -Subject BusinessStudies
```

The installer will say that it is downloading the latest HSC Markers release. Leave PowerShell open until you see a message beginning with:

```text
Installed mark-hsc-biology
```

or:

```text
Installed mark-hsc-business-studies
```

### Step 4: restart your program

Fully close Codex or Claude Code, then open it again. You can now continue to [Check that it works](#check-that-it-works).

## Install on macOS

### Step 1: open Terminal

1. Press **Command+Space** to open Spotlight Search.
2. Type `Terminal`.
3. Press **Return**.

A text window will open. You do not need to understand the text already shown there.

### Step 2: download the installer

Copy the command below, click inside Terminal, press **Command+V**, then press **Return**:

```bash
curl -fsSL 'https://raw.githubusercontent.com/mlongnguyen2021-ship-it/hsc-markers/main/install.sh' -o /tmp/install-hsc-marker.sh
```

It is normal for this command to finish without displaying a message.

### Step 3: install for your program

Choose the command that matches both your program and subject.

For Biology in Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex
```

For Business Studies in Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex --subject business-studies
```

For Biology in Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code
```

For Business Studies in Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code --subject business-studies
```

Press **Return** and wait until you see a message beginning with:

```text
Installed mark-hsc-biology
```

or:

```text
Installed mark-hsc-business-studies
```

### Step 4: restart your program

Fully close Codex or Claude Code, then open it again. Continue to [Check that it works](#check-that-it-works).

## Install on Linux

### Step 1: open Terminal

On many Linux computers, press **Ctrl+Alt+T**. You can also open the applications menu, search for `Terminal`, and click it.

### Step 2: check the two required tools

Copy and run this command:

```bash
command -v curl && command -v unzip
```

If two file locations appear, continue to Step 3. If nothing appears, or you see a “not found” message, use the instructions under [Linux says curl or unzip is missing](#linux-says-curl-or-unzip-is-missing).

### Step 3: download the installer

Copy the command below, paste it into Terminal and press **Enter**:

```bash
curl -fsSL 'https://raw.githubusercontent.com/mlongnguyen2021-ship-it/hsc-markers/main/install.sh' -o /tmp/install-hsc-marker.sh
```

It is normal for this command to finish without displaying a message.

### Step 4: install for your program

Choose the command that matches both your program and subject.

For Biology in Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex
```

For Business Studies in Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex --subject business-studies
```

For Biology in Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code
```

For Business Studies in Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code --subject business-studies
```

Wait until you see a message beginning with:

```text
Installed mark-hsc-biology
```

or:

```text
Installed mark-hsc-business-studies
```

### Step 5: restart your program

Fully close Codex or Claude Code, then open it again.

## Check that it works

### Biology in Codex

Start a new Codex task and paste this example:

```text
Use $mark-hsc-biology to mark this response.

Question: Explain why genetic variation is important for a population. (3 marks)
Student response: Genetic variation means individuals have different alleles. If the environment changes, some individuals may have an advantageous characteristic and survive to reproduce, passing the allele to their offspring.
```

The response should include a mark, a judgement, what earned marks and a minimum full-mark answer.

### Business Studies in Codex

Start a new Codex task and paste this example:

```text
Use $mark-hsc-business-studies to mark this response.

Question: Explain one benefit of market segmentation for a business. (2 marks)
Student response: Market segmentation means dividing a total market into groups with similar characteristics. It lets a business target its product and promotion more closely to a group's needs, which can improve sales.
```

The response should include a mark, a judgement, what earned marks, and a minimum full-mark answer.

### In Claude Code

Type the command for the subject you installed and press **Enter**.

For Biology:

```text
/mark-hsc-biology
```

For Business Studies:

```text
/mark-hsc-business-studies
```

Then ask Claude to mark a response, including the subject question, total marks, and student answer. Claude Code should use the chosen HSC marker automatically.

## Update an existing installation

Download the installer again using the earlier download step, then use the update command for your program.

### Windows

Update Biology in Codex:

```powershell
& $installer -Target Codex -Force
```

Update Business Studies in Codex:

```powershell
& $installer -Target Codex -Subject BusinessStudies -Force
```

Update Biology in Claude Code:

```powershell
& $installer -Target ClaudeCode -Force
```

Update Business Studies in Claude Code:

```powershell
& $installer -Target ClaudeCode -Subject BusinessStudies -Force
```

### macOS or Linux

Update Biology in Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex --force
```

Update Business Studies in Codex:

```bash
bash /tmp/install-hsc-marker.sh --target codex --subject business-studies --force
```

Update Biology in Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code --force
```

Update Business Studies in Claude Code:

```bash
bash /tmp/install-hsc-marker.sh --target claude-code --subject business-studies --force
```

Restart the program after updating.

## Common problems

### The installer says it is already installed

This is a safety check. Use the update command from [Update an existing installation](#update-an-existing-installation).

### PowerShell says running scripts is disabled

Run one of these commands instead. This changes the policy only for this installation process.

For Codex:

```powershell
powershell -ExecutionPolicy Bypass -File $installer -Target Codex
```

For Business Studies in Codex:

```powershell
powershell -ExecutionPolicy Bypass -File $installer -Target Codex -Subject BusinessStudies
```

For Claude Code:

```powershell
powershell -ExecutionPolicy Bypass -File $installer -Target ClaudeCode
```

For Business Studies in Claude Code:

```powershell
powershell -ExecutionPolicy Bypass -File $installer -Target ClaudeCode -Subject BusinessStudies
```

### Linux says curl or unzip is missing

Choose the command matching your Linux version.

Ubuntu, Debian or Linux Mint:

```bash
sudo apt update
sudo apt install -y curl unzip
```

Fedora:

```bash
sudo dnf install -y curl unzip
```

Arch Linux:

```bash
sudo pacman -S curl unzip
```

Your computer may ask for your password. The password will not appear while you type; this is normal. Press **Enter** when finished, then repeat the Linux installation steps.

### The download appears to be stuck

The source library is much larger than the marker itself. Wait at least five minutes. If there is still no progress, close the window, check your internet connection and begin again from the download step.

### The skill does not appear in Codex or Claude Code

1. Fully close the program instead of closing only the current chat.
2. Open it again and start a new task or session.
3. Try the command from [Check that it works](#check-that-it-works).

### I installed it for the wrong program

Nothing is damaged. Repeat the installation and choose the command for the program you actually use.

### I still need help

Open a [GitHub issue](https://github.com/mlongnguyen2021-ship-it/hsc-markers/issues) and include:

- whether you use Windows, macOS or Linux;
- whether you use Codex or Claude Code;
- the complete error message.

Do not include passwords, access tokens, student names or private school documents.
