---
name: midi-to-lilypond
description: Convert a MIDI file to a clean LilyPond score optimised for LLM input, and complete or produce a companion metadata file describe how the sheet was produced. Asks targeted questions about the MIDI source to choose the best midi2ly parameters, runs the conversion, and writes a `.md` metadata file alongside the `.ly`. Use when the user has a MIDI file and wants a LilyPond score, or when converting audio-pipeline output (from basic-pitch / piano transcription) to sheet music notation.
allowed-tools: Bash Read Write
---

# MIDI to LilyPond Conversion

Convert a MIDI file to a LilyPond `.ly` score with the cleanest possible output, and write a companion metadata file that records how the sheet was produced and objective metrics about the output.

## Step 1 — Check for an existing metadata file

Before asking any questions, check whether a `.md` companion file already exists next to the `.ly` or `.mid` file. If it does, read it to extract any answers already present (title, MIDI description, tempo, time signature, etc.).

Then ask only the questions that remain unanswered:

1. **Smallest note value** — Are there 32nd notes, or is 16ths the finest detail? (affects `-d`/`-s` grid)
2. **Swing / triplets** — Does the piece use triplets or swung 8ths? (determines `--allow-tuplet` flags)
3. **MIDI origin** — Is this a perfectly-quantized MIDI (game, DAW sequencer) or recorded/humanized playing?
4. **How many tracks** — Is this a single melody line or a multi-track arrangement?

Skip any question the user has already answered in context or that the existing metadata file already covers.

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

## Step 4 — Compute quantitative metrics

Run the following Python snippet against the `.ly` file. It produces the numbers needed for the metadata file. No qualitative judgement here — just counts.

```bash
python3 - <<'EOF'
import re, os, sys

path = "path/to/Song Name - midi2ly.ly"
with open(path) as f:
    content = f.read()

lines = content.count("\n")
size  = os.path.getsize(path)

# Measure count: highest % N comment
measures = max((int(m) for m in re.findall(r'% (\d+)', content)), default=0)

# Voice blocks
voice_blocks = list(re.finditer(r'^(\w+) =.*?(?=^\w+ =|\Z)', content, re.MULTILINE | re.DOTALL))

print(f"lines={lines}  size={size}B  measures={measures}  voices={len(voice_blocks)}")
print()

for m in voice_blocks:
    name  = m.group(0).split()[0]
    block = m.group(0)
    notes   = len(re.findall(r'\b[a-g](is|es)?\b', block))
    rests   = len(re.findall(r'\br[0-9]', block))
    spacers = len(re.findall(r'\bs[0-9]+', block))
    tempos  = len(re.findall(r'\\tempo', block))
    clefs   = len(re.findall(r'\\clef', block))
    tuplets = len(re.findall(r'\\times', block))
    ghost   = "GHOST?" if measures > 0 and notes / measures < 0.10 else ""
    print(f"  {name}: notes={notes} rests={rests} spacers={spacers} tempos={tempos} clefs={clefs} tuplets={tuplets} {ghost}")

print()
total_tempo   = len(re.findall(r'\\tempo', content))
unique_tempo  = len(set(re.findall(r'\\tempo\s+\d+=(\d+)', content)))
total_clef    = len(re.findall(r'\\clef', content))
spacer_total  = len(re.findall(r'\bs[0-9]+', content))
spacer_frac   = len(re.findall(r's[0-9]+\*[0-9]+/[0-9]+', content))
change_staff  = len(re.findall(r'\\change\s+Staff', content))
bar_checks    = len(re.findall(r'\\barNumberCheck', content))
stem_dirs     = len(re.findall(r'\\stem(Up|Down)', content))
omits         = len(re.findall(r'\\omit', content))

print(f"tempo_events={total_tempo}  unique_tempos={unique_tempo}")
print(f"clef_switches={total_clef}")
print(f"spacer_tokens={spacer_total}  spacer_fractional={spacer_frac}")
print(f"change_staff={change_staff}  bar_checks={bar_checks}  stem_dirs={stem_dirs}  omits={omits}")
EOF
```

Record all printed values — you will paste them into the metadata file in Step 5.

## Step 5 — Write or complete the metadata file

A companion `.md` file lives next to the `.ly` (same stem, `.md` extension).

- **If no file exists**: create it in full using the template below.
- **If a file already exists**: add or replace only the sections that are missing or incomplete. Preserve any existing prose (`## MIDI file description`, `## Midi to Lilypond conversion`, etc.) verbatim.

In both cases, ensure the front matter and the `## Quantitative analysis` section are present and up to date.

```markdown
---
title: <piece name inferred from source filename>
source_midi: <original .mid filename>
lily_file: <stem - midi2ly.ly>
compiled_pdf: <stem - midi2ly.pdf>
key: <value from first \key directive, e.g. "c major">
time: <value from \time directive, e.g. "4/4">
tempo_first: <first \tempo value in BPM>
voices: [<list of voice block names found in the .ly>]
conversion_tool: midi2ly
quantization: -d <GRID> -s <GRID>
tuplet_flags: <flags used, or "none">
---

## Score description

<One short paragraph: what the piece is, how many voices/tracks, general character. Infer from the filename and track structure — do not invent musical details you cannot see in the file.>

## Quantitative analysis

### File

| Metric | Value |
|---|---|
| Lines | N |
| File size | N bytes |
| Measures | N |
| Voices | N |

### Per-voice breakdown

| Voice | Notes | Rests | Spacers | Tempo events | Clef switches | Tuplets |
|---|---|---|---|---|---|---|
| <name> | N | N | N | N | N | N |

### Noise metrics

| Metric | Value |
|---|---|
| Total `\tempo` events | N |
| Unique tempo values | N |
| Total `\clef` switches | N |
| Spacer rest tokens | N |
| Spacer rests with fractional multipliers | N |
| Cross-staff `\change Staff` events | N |
| `\barNumberCheck` assertions | N |
| Explicit stem direction directives | N |
| `\omit` directives | N |

### Ghost voice signals (notes ÷ measures < 10%)

| Voice | Notes | Measures | Ratio |
|---|---|---|---|
| <name> | N | N | N% |
```

Leave the ghost voice table empty (header only) if no voices fall below the 10% threshold.
