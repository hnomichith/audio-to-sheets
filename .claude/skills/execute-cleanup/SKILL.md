---
name: execute-cleanup
description: Apply specific tasks from a plan-cleanup task table to a LilyPond file. The human explicitly names which tasks to execute. Edits are applied mechanically, the result is compiled with LilyPond, task statuses are updated to DONE, and a summary is reported. Use after plan-cleanup has written TO DO detail sections.
---

> Before starting: invoke `work-with-lilypond` to check notation mode and establish safe working constraints.

# Execute Cleanup

Apply a specific set of TO DO tasks from the cleanup plan to the current LilyPond file, compile the result, update task statuses, and report.

Do not re-analyse the score. Do not choose which tasks to run — the human specifies them.

## Inputs

- The companion `.md` file (ask the user if not provided in context)
- The task numbers or descriptions to execute (ask the user if not specified)

## Step 1 — Read the plan

Read the companion `.md` in full. Identify:
- The current `.ly` file to edit: use `clean_ly` if present in the frontmatter, otherwise `lily_file`.
- The task table (`## Cleanup tasks` section).

For each requested task, verify:
- It exists in the task table.
- Its status is **TO DO** (not TO SCOPE or DONE).

If any task is missing or not TO DO — stop and tell the user before doing anything.

### Locate the task detail sections

For each requested task N, look for its verbatim edit details in this order:

1. **Task file** (preferred): `cleanup-tasks/task-N.md` in the same folder as the companion `.md`. If it exists, read it.
2. **Inline fallback**: if no task file exists, look for `### Task N` in the companion `.md` itself.

If neither is found — stop and tell the user that the detail section is missing.

## Step 2 — Read the source file

Read the current `.ly` file in full.

## Step 3 — Prepare the output file

Determine the output path:
- If `clean_ly` exists in the frontmatter: use that file directly.
- If not: copy `lily_file` to `<stem>-clean.ly` in the same folder, then use that as the target:

```bash
cp "<lily_file_path>" "<stem>-clean.ly"
```

Do not overwrite the original `lily_file`.

## Step 4 — Apply edits

Work through the detail sections of the requested tasks, in task-number order.

Within each task, apply edits in the order listed in the detail section (edits are pre-ordered by `plan-cleanup` — deletions bottom-to-top, then replacements).

### For each edit:

**Locate the content** in the output file using the verbatim text shown (`Remove:`, `Replace:`, or the anchor for `Insert after:`). Line numbers are navigation hints only — search by content.

**Apply the action using the `Edit` tool** — one call per edit:

| Action | What to do |
|---|---|
| `Delete block` | Remove the entire verbatim block. Collapse any double-blank gap left behind to a single blank line. |
| `Replace` | Substitute the old content with the new content exactly as written. |
| `Insert after` | Insert the new content immediately after the located anchor line. |

Never reconstruct the file from memory. Never use `Write` to rewrite the whole file.

**If the content cannot be found:** stop, report which edit failed and show the current state of the relevant section. Do not proceed further.

After each edit, quick-check: balanced `{` `}` and `>>` blocks. If something looks structurally broken, stop and report.

## Step 5 — Compile

```bash
cd "<folder>" && lilypond "<clean_ly_filename>" 2>&1
```

Capture the full output. Categorise:
- **Clean** — no errors or warnings.
- **Warnings only** — list each with line number and one-line description.
- **Errors** — list each with the relevant line from the cleaned file.

## Step 6 — Update the companion `.md` and task files

Three updates:

**A — Task table:** change the status of each successfully applied task from `TO DO` to `DONE` in the companion `.md`.

**B — Task file:** if the task had a `cleanup-tasks/task-N.md` file, update its frontmatter `status` from `TO DO` to `DONE`.

**C — Frontmatter:** if `clean_ly` was not already set in the companion `.md`, add it now pointing to the output file.

## Step 7 — Report

Print a concise summary:

```
Tasks applied: #N <description>, #M <description>, ...
Output: <clean_ly path>
Compilation: Clean / N warning(s) / N error(s)

<If warnings or errors: paste the relevant lilypond output lines.>

Remaining TO DO tasks: #X, #Y, ...
Remaining TO SCOPE tasks: #Z, ...
```

If there were compilation errors: surface them clearly. Do not attempt to fix them — leave that for the next `plan-cleanup` run.
