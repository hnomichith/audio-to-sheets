---
name: midi-to-lilypond
description: Convert a MIDI file to a clean LilyPond score optimised for LLM input, and produce a companion metadata file describing the sheet and the cleanup work remaining. Asks targeted questions about the MIDI source to choose the best midi2ly parameters, runs the conversion, and writes a `.md` metadata file alongside the `.ly`. Use when the user has a MIDI file and wants a LilyPond score, or when converting audio-pipeline output (from basic-pitch / piano transcription) to sheet music notation.
allowed-tools: Bash Read Write
---

# MIDI to LilyPond Conversion

Convert a MIDI file to a LilyPond `.ly` score with the cleanest possible output, and write a companion metadata file that describes the sheet and inventories the cleanup work remaining.

## Step 1 — Ask diagnostic questions

Before running anything, ask the user these questions (you can bundle them in one message):

1. **Smallest note value** — Are there 32nd notes, or is 16ths the finest detail? (affects `-d`/`-s` grid)
2. **Swing / triplets** — Does the piece use triplets or swung 8ths? (determines `--allow-tuplet` flags)
3. **MIDI origin** — Is this a perfectly-quantized MIDI (game, DAW sequencer) or recorded/humanized playing?
4. **How many tracks** — Is this a single melody line or a multi-track arrangement?

Skip any question the user has already answered in context.

## Step 2 — Choose parameters

Map the answers using this decision table:

### Quantization grid (`-d` / `-s`)

| Finest note in piece | MIDI origin | Recommended grid |
|---|---|---|
| 32nd notes | Perfectly quantized | `-d 32 -s 32` |
| 16th notes | Perfectly quantized | `-d 16 -s 16` ← default |
| 16th notes | Humanized / performed | `-d 16 -s 16` |
| 8th notes only | Any | `-d 8 -s 8` |
| Unknown | Any | `-d 16 -s 16` (safe default) |

**Why not 32nd by default?** Ornamental 32nd-note passages that don't land exactly on the 32nd grid produce `c''32*5` artifacts (non-standard duration ratios). A 16th grid collapses these into readable dotted figures: `c''8. b8 c8.`.

**Why not 8th?** 8th-note quantization merges fast 16th runs into chords — musically inaccurate for anything with 16th-note detail.

**Avoid** `-d 64 -s 64` — produces more fractional patterns than the 32nd grid on most MIDIs.

### Tuplet flags (`--allow-tuplet`)

| Source music | Add these flags |
|---|---|
| Has triplets or swing | `--allow-tuplet=4*2/3 --allow-tuplet=2*4/3` |
| Purely straight 16ths/8ths | Omit (saves noise) |
| Unknown | Include them (safe) |

### Flags to avoid

| Flag | Why to skip |
|---|---|
| `-a` (absolute pitches) | Crashes with `TypeError` on most MIDIs — known Python bug in midi2ly |
| `-e` (explicit durations) | More verbose, increases fractional patterns |
| `-S` (spacer rests) | Replaces `r` with `s` — makes rests invisible in the score, wrong semantics |
| `-k N` (force key) | Does not remove duplicate `\key` events; those come from MIDI data |
| Asymmetric `-d 16 -s 32` | Introduces `r32` fragments; symmetric grid is always cleaner |

## Step 3 — Run the conversion

Name the output file by appending ` - midi2ly` to the source stem, keeping it in the **same folder** as the source MIDI. For example, `Song Name.mid` → `Song Name - midi2ly.ly`.

```bash
midi2ly "path/to/Song Name.mid" \
  -o "path/to/Song Name - midi2ly.ly" \
  -d <GRID> -s <GRID> \
  --allow-tuplet=4*2/3 --allow-tuplet=2*4/3   # if applicable
```

Then compile to verify. **`cd` into the file's folder first** so that LilyPond drops the compiled PDF and MIDI alongside the `.ly` rather than in the current working directory:

```bash
cd "path/to/folder" && lilypond "Song Name - midi2ly.ly" 2>&1 | grep -E "bar|error|warning"
```

## Step 4 — Collect quality metrics

Run these commands to gather the numbers needed for the metadata file:

```bash
# Count remaining fractional duration artifacts (goal: < 15)
grep -oE '[0-9]+\*[0-9]+(/[0-9]+)?' output.ly | grep -v '\\skip' | wc -l

# Count lines and file size
wc -l output.ly
du -h output.ly

# Show remaining artifacts in musical voices (not \skip lines)
grep -n '\*' output.ly | grep -v '\\skip'

# Extract key, time signature, tempo
grep -n '\\key\|\\time\|\\tempo' output.ly | head -20

# List track names
grep -n '^trackA\|^trackB\|^trackC\|^trackD' output.ly | grep -v 'channel'
```

## Step 5 — Write metadata file

Write a companion `.md` file next to the `.ly` (same name, `.md` extension). It has two parts: a YAML front-matter block with facts about the sheet, and a markdown body with a conversion quality summary and a cleanup checklist.

Populate the fields by reading the `.ly` output. Infer `title` from the source filename. For `tracks`, list each `trackX` block name found in the file.

```markdown
---
title: <piece name inferred from source filename>
source_midi: <original .mid filename>
lily_file: <stem - midi2ly.ly>
compiled_pdf: <stem - midi2ly.pdf>
key: <value from first \key directive, e.g. "c major">
time: <value from \time directive, e.g. "4/4">
tempo: <first \tempo value in BPM>
tracks: [<list of track block names found in the .ly>]
quantization: -d <GRID> -s <GRID>
---

## Score description

<One short paragraph: what the piece is, how many voices/tracks, general character. Infer from the filename and track structure — do not invent musical details you cannot see in the file.>

## Conversion quality

| Metric | Value |
|---|---|
| Lines | N |
| File size | N KB |
| Fractional `x*y` patterns in voices | N |
| Bar check failures | N |

## Cleanup needed

<For each issue found, add a checklist item. Use the known patterns below as a guide. Leave the list empty if none are found. Items here are rough — a plan-cleanup pass will add precise line numbers.>

- [ ] <issue description>
```

### Known cleanup patterns to check for

Scan the `.ly` output for these and add a checklist item for each one found:

- **Tempo spam** — Multiple `\tempo` events within a few measures (ritardando artifact). Note how many were found. Fix: keep only the first `\tempo` directive.
- **Ghost voice** — A track block that is almost entirely rests with 1–2 stray notes. Fix: drop the entire block.
- **Duplicate key/time signatures** — `\key` or `\time` appearing more than once at the top of a voice. Fix: strip the duplicate.
- **Conductor track** — A track block containing only `\skip` and `\tempo` events, no notes. Fix: strip the whole block.
- **Remaining `x*y` patterns in voices** — Non-standard duration ratios left after quantization. List the count. Fix: resolve each to standard notation.
