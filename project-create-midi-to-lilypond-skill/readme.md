# POC 03 - MIDI to LilyPond

## Question

**Can we convert a MIDI file to a LilyPond score that is compact and structured enough to be usable as LLM input?**

## Context

MIDI encodes music as raw timestamps and note events — it has no notion of bars, beats, or musical structure. Importing MIDI into a score editor produces a messy result that requires heavy manual cleanup. LilyPond is the target format because it is dramatically more compact than MusicXML (~15 lines vs ~200 for the same passage), making it viable as LLM context.

This POC focuses on the mechanical conversion only — cleanup is handled in POC 04.

## Success criteria

The output must be **at least as clean as a direct MIDI import in MuseScore** — the baseline a musician would start from without any tooling. Concretely: the rendered PDF should be visually comparable to the MuseScore import with no obviously worse bar structure, voice layout, or enharmonic spelling. This can be verified by visual comparison of the two PDFs.

## Tools explored

- [midi2ly](https://lilypond.org/doc/v2.24/Documentation/usage/invoking-midi2ly) — bundled with LilyPond, basic conversion ❌ **Failed** (see below)
- [musicxml2ly](https://lilypond.org/doc/v2.24/Documentation/usage/invoking-musicxml2ly) + MuseScore CLI export — route through MusicXML 🔲 To explore
- [music21](https://web.mit.edu/music21/) — Python library with proper quantization and voice separation 🔲 To explore

## Approach 1 — midi2ly ❌ Failed

### Verdict

The `midi2ly` output, even after the best quantization settings and a full LLM cleanup pass (see `project-pokemon-piano/`), produces a score that is **worse than a direct MuseScore import**. The core problem is that `midi2ly` has no musical intelligence: it translates raw MIDI timestamps into LilyPond durations mechanically, with no understanding of bar structure, voice intent, or harmonic context. The issues it leaves — timing glitches, ghost voices, enharmonic misspellings, overlapping rests — cannot be fully resolved by downstream LLM cleanup because some are genuinely ambiguous without listening to the music.

### How to reproduce

```bash
# Raw conversion (no quantization)
midi2ly assets/"Pokemon RedBlueYellow - Intro 2.mid" -o output/pokemon_intro.ly

# Quantized conversion (recommended — 16th note grid)
midi2ly assets/"Pokemon RedBlueYellow - Intro 2.mid" \
  -o output/pokemon_intro_quantized.ly \
  -d 16 -s 16 \
  --allow-tuplet=4*2/3 --allow-tuplet=2*4/3

# Compile to PDF
lilypond output/pokemon_intro_quantized.ly
```

## Findings

### Quantization makes a decisive difference

Running `midi2ly` without quantization produces unreadable fractional durations (`g'4*241/1024`, `r4*16/1024`) — every note and rest is expressed as a raw timestamp ratio. Adding `-d 16 -s 16` (quantize to 16th notes) produces standard notation: `r2. g'16 b d fis`.

| | Raw | `-d 32 -s 32` | `-d 16 -s 16` (best) |
|---|---|---|---|
| Lines | 265 | 213 | 213 |
| File size | 12 KB | 4 KB | 3.5 KB |
| Fractional `x*y` patterns | ~200 | 29 | **10** |
| Bar check failures | 5 | 1 | 1 |
| Pages rendered | 2 | 1 | 1 |

The 29 fractional patterns at `-d 32 -s 32` come from ornamental 32nd-note passages that don't quantize cleanly: `c''32*5 b r32 c32*5`. At `-d 16 -s 16` these collapse into readable dotted figures: `c''8. b8 c8.`. The ghost voice cleans up dramatically too: `r32*149 f4. g,8 r32*85` → `r2*15 f4. g,8`.

### Parameter sweep

All `midi2ly` flags were tested on the same MIDI to understand their effect:

| Flag | Effect | Verdict |
|---|---|---|
| `-d 16 -s 16` | 16th-note grid: preserves 16th runs, collapses 32nd ornaments into dotted figures | ✅ Best |
| `-d 32 -s 32` | 32nd-note grid: preserves more detail but leaves `x32*5` artifacts | ⚠️ More noise |
| `-d 8 -s 8` | 8th-note grid: only 11 fractional patterns but merges fast 16th runs into chords — musically inaccurate | ❌ Too coarse |
| `-d 64 -s 64` | 64th-note grid: 57 fractional patterns — worse than raw on this MIDI | ❌ Worse |
| `-d 16 -s 32` | Asymmetric (fine starts, coarser durations): 14 fractional patterns, introduces `r32` fragments | ❌ Worse than symmetric |
| `-k 0` | Force C major key: no effect — duplicate `\key` events come from MIDI data, not midi2ly inference | ✗ No help |
| `-e` | Explicit durations on every note: more verbose, 36 fractional patterns at q32 | ❌ Worse |
| `-S` | Spacer rests (`s` instead of `r`): rests become invisible in the score — wrong semantics | ❌ Wrong |
| `-a` | Absolute pitches: crashes with `TypeError` on this MIDI (Python bug in midi2ly) | ❌ Broken |
| `--allow-tuplet=4*2/3 --allow-tuplet=2*4/3` | Allow triplets: needed to avoid treating swung notes as fractional durations | ✅ Keep |
| Additional tuplet flags (`8*2/3`, `4*4/3`, `16*2/3`) | No measurable effect on fractional count for this MIDI | ✗ No effect |

### Remaining issues after cleanup (from `project-pokemon-piano/`)

After a full `plan-cleanup` + `execute-cleanup` LLM pass, the following could not be fully resolved:

- **Barcheck failure at bar 20** — `<d g>1` (whole note) in a bar that already has 2 beats of content. Likely a held note transcription artefact; requires musical judgement to fix.
- **Overlapping rests** — multi-voice layout forces colliding rests throughout; suppressing them is cosmetic, not a real fix.
- **Enharmonic misspellings** — `ais` (A#) used instead of `bes` (Bb) in the F-major passage. Comes from raw MIDI pitch values with no key context.
- **Structural bar errors unfixable without listening** — some timing offsets cannot be corrected by pattern-matching alone.

### What worked

- Quantization at `-d 16 -s 16` is the best `midi2ly` setting for this kind of MIDI
- Mechanical cleanup (remove conductor track, fix `x*y` rest notation) is automatable
- The LilyPond file compiles and the theme is recognizable — it is just not up to the quality bar

### Results table

| Criterion | Result |
|---|---|
| Compiles without errors | ✅ Warnings only (3 remaining after cleanup) |
| Theme recognizable | ✅ |
| At least as clean as MuseScore import | ❌ Worse |
| File size smaller than MusicXML | ✅ 4 KB / 213 lines |
