# POC 04 — Session Briefing

This document gives a fresh session everything it needs to tackle POC 04 without prior context.

## What this POC is about

Take the raw `midi2ly` output from POC 03 and produce a clean, musically correct LilyPond score using LLM assistance. The goal is **one-shot cleanup**: a single LLM pass that strips artifacts, fixes structure, and yields something a musician could read and use.

See [readme.md](readme.md) for full success criteria and scope.

## Input file

```
poc/04-llm-cleanup/assets/Pokemon_Intro2.ly
```

This is the best quantized output from POC 03: `midi2ly -d 16 -s 16 --allow-tuplet=4*2/3 --allow-tuplet=2*4/3` applied to `Pokemon RedBlueYellow - Intro 2.mid`.

**Piece:** Pokémon Red/Blue/Yellow — Intro 2
**Instrumentation:** Piano only, two tracks (treble + bass)
**Time signature:** 4/4
**Key:** C major (modulates briefly to F major and back)
**Tempo:** 150 BPM
**Rhythm:** Straight 16ths; quarter-note triplets present in source but encoded as dotted figures by the Game Boy timer — no `\tuplet` blocks in the MIDI output

## Known cleanup targets

These were identified during POC 03 and must be addressed:

| # | Issue | Location | Action |
|---|---|---|---|
| 1 | **Conductor track** | `trackAchannelA` (lines 14–72) | Strip entirely — contains only `\tempo` and `\skip`, no notes |
| 2 | **Tempo spam** | Lines 24–65, ~20 `\tempo` events | Keep only `\tempo 4 = 150`; rest are ritardando artifacts |
| 3 | **Duplicate `\key`** | Lines 17 and 22, both `\key c \major` | Remove line 17 |
| 4 | **Ghost voice** | `trackBchannelBvoiceC` (line 195) | Drop entirely — `r2*11 f'4. g,8 r2*15 f'4. g,8`, almost all rests |
| 5 | **Bar check failure** | Line 148–149 | `r4*5 g''4. r8*7 <f, a>4 <f a> g'4. r8` — resolve the duration arithmetic (the `*5` and `*7` multipliers span measure boundaries) |
| 6 | **Mid-piece key changes** | Lines 67–70 | `\key f \major` then `\key c \major` in the conductor track — confirm these are artifacts once the conductor track is stripped |

## Quality bar

After cleanup, run:

```bash
lilypond poc/04-llm-cleanup/output/Pokemon_Intro2_clean.ly 2>&1 | grep -E "bar|error|warning"
```

Target: **zero bar check failures**, zero errors. Warnings about `\version` are acceptable.

Also verify:
```bash
grep -oE '[0-9]+\*[0-9]+(/[0-9]+)?' poc/04-llm-cleanup/output/Pokemon_Intro2_clean.ly | grep -v '\\skip' | wc -l
```
Target: **0 fractional `x*y` patterns** in note voices.

## Output location

Write cleaned output to:
```
poc/04-llm-cleanup/output/Pokemon_Intro2_clean.ly
```

## Reference: what the input looks like (key sections)

**Conductor track to strip (lines 14–72):**
```lilypond
trackAchannelA = {
  \key c \major
  \time 4/4
  \key c \major
  \tempo 4 = 120
  \tempo 4 = 150
  \tempo 4 = 150
  \skip 2*13
  \tempo 4 = 150
  \skip 16
  \tempo 4 = 148
  ... (20 more tempo events with \skip between them)
  \key f \major
  \skip 1*2
  \key c \major
  \skip 1*7
}
```

**Ghost voice to drop (line 195):**
```lilypond
trackBchannelBvoiceC = \relative c {
  \voiceThree
  r2*11 f'4. g,8 r2*15 f'4. g,8
}
```

**Bar check failure to fix (lines 146–150):**
```lilypond
trackBchannelBvoiceB = \relative c {
  \voiceOne
  r4*5 g''4. r8*7 <f, a >4 <f a > g'4. r8
  | % 4
  d'2 c,4. r8
  ...
```
The `r4*5` spans 5 quarter durations (starts mid-measure 1 and crosses into measure 2).
The `r8*7` spans 7 eighth durations (crosses another bar line).
These need to be split at the bar line with explicit rests per measure.
