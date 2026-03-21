# POC 03 - MIDI to LilyPond

## Question

**Can we convert a MIDI file to a LilyPond score that is compact and structured enough to be usable as LLM input?**

## Context

MIDI encodes music as raw timestamps and note events — it has no notion of bars, beats, or musical structure. Importing MIDI into a score editor produces a messy result that requires heavy manual cleanup. LilyPond is the target format because it is dramatically more compact than MusicXML (~15 lines vs ~200 for the same passage), making it viable as LLM context.

This POC focuses on the mechanical conversion only — cleanup is handled in POC 04.

## Tools explored

- [midi2ly](https://lilypond.org/doc/v2.24/Documentation/usage/invoking-midi2ly) — bundled with LilyPond, basic conversion

## How to reproduce

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

### What still needs cleanup (→ POC 04)

- **Tempo spam** — conductor track emits a new `\tempo` every 16th note during ritardandos (15+ directives for a 150→144 BPM slowdown). A single `\tempo` at the start is enough.
- **Sparse ghost voice** — `trackBchannelBvoiceC` is mostly multi-bar rests with two notes: `r2*11 f'4. g,8 r2*15 f'4. g,8`. At q16 it is clean enough to read, but the voice contributes nothing musically — drop it.
- **Duplicate key/time signatures** — `\key c \major` appears twice. This comes from two events in the MIDI header; no flag suppresses it.
- **One remaining bar check failure** at measure 4 in voice B — a small timing offset that no quantization level resolves. Likely a genuine MIDI glitch in the source file.

## Success criteria

| Criterion | Result |
|---|---|
| Compiles without errors (`lilypond file.ly`) | ✅ Warnings only |
| Output renders a recognizable score | ✅ Theme is recognizable |
| File size significantly smaller than MusicXML | ✅ 4 KB / 213 lines vs ~200 lines *per passage* in MusicXML |
