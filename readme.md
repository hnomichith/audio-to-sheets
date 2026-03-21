# Audio to Sheets

This project offers a pipeline to convert an audio file into an editable musical score, with LLM-assisted cleanup and arrangement.

## Prerequisites

```
sudo apt-get install lilypond
```

## Vision

The end goal is a tool to produce a full orchestral piece — composed or arranged with LLM assistance — performable by a live orchestra.

The tool has two distinct roles:

- **Transcription** — handle the mechanical work (stem separation, transcription, score generation, cleanup) so the arranger starts from a clean, editable score rather than a blank page or a messy MIDI import.
- **Arrangement collaboration** — once a clean score exists, the arranger works with the LLM as a creative partner: assigning a theme as a solo to a single instrument or orchestrating it for a section, adding percussion, suggesting transitions between sections of a medley, or simply discussing ideas before committing to anything.

The shape of that tool — whether an LLM agent, a set of skills and commands, or something else — will depend on what the experiments across milestones reveal about each stage's reliability.

## Overall approach

From an audio file:
```
Audio file
  └─ 01. Stem separation      → one audio file per instrument
       └─ 02. Audio to MIDI   → one MIDI file per stem
            └─ 03. MIDI to LilyPond  → compact, LLM-readable score
                 └─ 04. LLM cleanup  → clean, editable score for each stem
                    └─ 05. Re-merge of separated stems  → clean, editable global score
```

Then, an editable score could be collaboratively arranged. Several editable scores could be merged to create medleys.

## Milestones

### 1. From a simple MIDI file, get a clean piano sheet

This would demonstrate a first solution for steps 3 and 4 of the overall approach. The solution chains three LLM skills:
1. midi-to-lilypond
2. plan-cleanup
3. execute-cleanup

Each skill transfers information using a metadata file next to the output.

**Status: in progress** — experimented with a Pokémon Red/Blue/Yellow intro transcription imported via MuseScore → MusicXML → musicxml2ly.

**Key finding:** skills 2 and 3 hit a hard limitation when the LilyPond file uses `\relative` notation. Pitch analysis is stateful — each note's pitch depends on all preceding notes — which is expensive and error-prone for an LLM to trace. Global mechanical fixes (spurious clef changes, tempo noise) work well as planned batch tasks. But voice consolidation and cross-staff edits require **bar-by-bar human intervention**: the LLM proposes one edit, compiles, and the human verifies the PDF before moving to the next bar.

**Mitigations introduced:**
- New `work-with-lilypond` skill: alerts when a file uses `\relative` and enforces absolute notation for any new content written by the LLM.
- `plan-cleanup` Phase B redesigned: no upfront batch planning for section passes — direct micro-iteration loop (one bar → edit → compile → human verify) instead.
- Recommendation: generate LilyPond in absolute notation from the start (`musicxml2ly --absolute-pitches` if available), which would make the full cleanup pipeline reliable without human intervention per bar.

**Conclusion:** In its current form, the pipeline is not faster than editing directly in MuseScore. The root cause is the entry point: the MIDI → MuseScore → MusicXML → musicxml2ly chain accumulates noise at every step, and the LLM inherits a file that is already hard for a human to clean. The bar-by-bar human intervention required for voice consolidation negates the automation benefit.

The real test for Milestone 1 would be to use MuseScore's direct LilyPond export instead of the MusicXML route — if that export is cleaner (absolute notation, voices already assigned), the global passes become fully automatic and the pipeline may become worthwhile. This has not been tested yet.

If direct LilyPond export does not close the gap, the value of this project likely lies further down the chain (arrangement, orchestration) rather than in transcription cleanup.

**Outlook — where LLM assistance does make sense:**

The transcription cleanup problem plays to the LLM's weaknesses: correcting malformed existing code, tracking stateful notation, verifying output visually. Arrangement is the opposite. Given a clean score, the LLM works from musical intent rather than syntactic correction — and that is where it is relatively strong.

Concretely, once a clean score exists, an LLM could usefully assist with:
- Redistributing voices across instruments (a high-level decision, not stateful code tracing)
- Suggesting harmonies or chord voicings over a given melody
- Generating a countermelody or inner accompaniment for a section
- Discussing orchestration options before committing to any notation

The short edit → compile → human verify loop remains necessary, but in arrangement the human is validating a *creative proposal* rather than correcting an *error* — a much more natural collaboration. This is likely where the project delivers real value.

### 2. Complexify the MIDI file, see how far we can get

This milestone goal would be to refine our skills, and see the limits of our approach.

### Future milestones

Order to be defined, we can explore:
- The arrangement capabilities
- Which tool to use to collaborate efficiently with the arranger
- The audio to MIDI conversion
- The stem separation
