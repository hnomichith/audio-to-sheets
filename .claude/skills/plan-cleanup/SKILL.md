---
name: plan-cleanup
description: Analyse a LilyPond file and its companion metadata, maintain a prioritised cleanup task table, and write verbatim edit details for every task that is ready to execute. Can be run multiple times as the cleanup progresses — skips DONE tasks, runs global passes first (whole-sheet mechanical fixes), then section passes (bar-by-bar musical judgment). Use when the user wants to plan or refine a cleanup of a LilyPond file.
---

# Plan Cleanup

Maintain a prioritised cleanup task table in the companion `.md` file. The goal is a **fast iteration loop that goes all the way to full cleanup**: run global passes first (whole-sheet mechanical fixes that need no musical judgment), then section passes (bar-by-bar work requiring musical reasoning). Every `plan-cleanup` run should produce at least one new TO DO task ready for `execute-cleanup`.

> Before starting: invoke `work-with-lilypond` to check notation mode and establish safe working constraints.

## Inputs

- The companion `.md` file (ask the user if not provided in context)
- The `.ly` file referenced in the `.md` frontmatter (`clean_ly` if present, otherwise `lily_file`)

## Step 1 — Read the files

Read the companion `.md` and the current `.ly` file **in a single parallel tool call**.

Check whether a `## Cleanup tasks` section already exists:

- **If no:** you will create the section from scratch. The full `.ly` read you just did is the basis for analysis — proceed directly to Step 2.
- **If yes:** the task table and target structure are already known. **Do not re-read the `.ly` in full.** Instead, run targeted greps for each global-pass issue type (one grep per type, in parallel where possible):
  - Spurious clef changes → grep `\\clef` in the `.ly`
  - Tempo noise → grep `\\tempo` in the `.ly`
  - Duplicated notes → (skip if already resolved or not applicable)

  Read only the line ranges returned by grep hits. Skip voices that are already fully DONE. Then proceed to Step 3 — skip Step 2 (target structure already recorded).

For any TO SCOPE task already in the table, the inline diagnosis in the `.md` is sufficient — do not re-read those voice blocks unless you need to plan a new batch.

## Step 2 — Determine the target structure

If not written in the companion metadata, ask the human (in a single short question):
- What is the instrument or ensemble? (e.g. "piano solo", "string quartet", "piano + violin")
- What is the expected staff layout? (e.g. piano = treble staff + bass staff, one voice per staff)

Use the answer as the reference point for identifying structural problems throughout the analysis.

If a `## Cleanup tasks` section already exists with a recorded target structure, skip this step.

Record the target structure at the top of the `## Cleanup tasks` section.

## Step 3 — Identify and plan issues

The cleanup consists mainly of bringing the sheet to the desired structure.

### Phase A — Global passes (plan fully now → TO DO)

Scan the `.ly` for issues not already in the task table. Issues that apply uniformly across the whole sheet and can be fixed mechanically without musical judgment:

| Type | Rule |
|---|---|
| Tempo noise | The user must be aware of the tempo. Any discrepancy can be eliminated. It can include cascading `\tempo` events, duplicate or mismatched tempo values, `\change Staff` artifacts flanking tempo events. |
| Duplicated notes | Exact same notes, with same rythmic, on the same staff, need to be eliminated. |
| Spurious clef changes | When the target structure specifies one voice per staff: **every `\clef` directive that is not the opening clef of a voice definition is spurious** and must be removed. |

For each global pass task: write full verbatim edit details to a task file (see Step 4).

If any global pass requires musical confirmation (e.g. confirming a ghost voice is safe to drop), ask **all such questions in a single message** before writing anything. Wait for answers.

**Language rule:** questions in musical terms only — pitch name, bar number, beat, voice role. No raw LilyPond tokens.

### Phase B — Section passes (micro-iteration mode)

**Enter Phase B only when no new global pass tasks remain** (i.e. all remaining issues are existing TO SCOPE tasks).

Section passes require musical judgment that cannot be planned upfront without exploding context. **Do not write task files for section passes.** Instead, switch to a direct micro-iteration loop with the user:

1. Pick the next TO SCOPE task. Read only its diagnosis from the companion `.md`.
2. Identify the **single next bar** to address (smallest possible unit).
3. Ask the one musical question needed for that bar (bar number, beat, register — no LilyPond tokens). Wait for the answer.
4. Apply the edit directly to the `.ly`. Compile immediately (`lilypond`). Report success or error.
5. Ask the user to verify the PDF, then move to the next bar.

**No batch planning, no task files, no multi-bar analysis.** The edit itself is the plan.

Update the TO SCOPE diagnosis after each bar to track remaining work. When all bars are done, mark the task DONE.

Section-level issue types that require Phase B treatment:

| Type | Signal |
|---|---|
| Too many voices per staff | More voices on a staff than the target structure allows |
| Cross-staff voice mixing | Notes in a voice that use the other staff's clef for actual notes (not spacers) |
| Ambiguous ghost voice | Sparse voice whose notes do not appear in any other voice (cannot auto-drop) |
| Voice consolidation | Two voices on the same staff need merging — one bar at a time |

## Step 4 — Write task files and update the companion `.md`

### Task files

Verbatim edit details for each new TO DO task go in a **separate file**:

```
<companion-md-folder>/cleanup-tasks/task-N.md
```

Create the `cleanup-tasks/` folder if it does not exist.

#### Task file format

```markdown
---
task: N
description: <one-line description>
status: TO DO
---

### Task N — <Musical description>

**Resolved questions:** <question and human answer, or "None.">

Apply edits in order:

#### N.1 <Edit name>

**Navigation hint:** lines X–Y; unique anchor: `<short verbatim snippet>`
**Action:** Delete block / Replace / Insert after

**Remove:** (for Delete block)
\```lily
<exact verbatim content>
\```

**Replace:** / **With:** (for Replace)
\```lily
<old content>
\```
\```lily
<new content>
\```

**Notes:** <dependency or sequencing note>
```

#### Edit ordering within a task file

1. Deletions **bottom-to-top** in the file.
2. In-place replacements after all deletions.

Use `Delete block` for whole variable definitions or multi-line sections.
Use `Replace` for in-place rewrites.
Use `Insert after` for adding content.

### Part A — Task table in the companion `.md`

```markdown
## Cleanup tasks

**Target structure:** <e.g. "Piano solo — portée de sol (1 voix) + portée de fa (1 voix)">

| # | Prio | Description musicale | Résumé technique | Statut | Fichier |
|---|---|---|---|---|---|
| 1 | P1 | <musical description> | <one-line summary> | TO DO | [task-1.md](cleanup-tasks/task-1.md) |
| 2 | P2 | <musical description> | <diagnosis summary> | TO SCOPE | — |
| 3 | P1 | <musical description> | <one-line summary> | DONE | [task-3.md](cleanup-tasks/task-3.md) |
```

**Row ordering:** sort the table on every run — TO DO first, then TO SCOPE, then DONE. Preserve existing row numbers (do not renumber); reorder rows only.

**Statuses:**
- **TO DO** — verbatim edit details written in `cleanup-tasks/task-N.md`; ready for `execute-cleanup`.
- **TO SCOPE** — issue identified; diagnosis inline in the main `.md`; no task file yet.
- **DONE** — applied and compiled; task file kept for reference but never re-read.

### Part B — TO SCOPE diagnosis blocks (stay inline in the companion `.md`)

These are short and do not warrant a separate file:

```markdown
### Task N — <description> — TO SCOPE

**Target:** <what this should look like after fixing>
**Diagnosis:** <which bars/voices are affected, what the problem looks like>
**Re-planning note:** <e.g. "Plan bar by bar — bars 7–11 first, then 18–24">
```
