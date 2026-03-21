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

### 2. Complexify the MIDI file, see how far we can get

This milestone goal would be to refine our skills, and see the limits of our approach.

### Future milestones

Order to be defined, we can explore:
- The arrangement capabilities
- Which tool to use to collaborate efficiently with the arranger
- The audio to MIDI conversion
- The stem separation
