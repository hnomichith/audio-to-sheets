# POC 02 - Audio to MIDI

## Question

**Can we convert a single-instrument audio stem to a MIDI file that accurately represents the notes played?**

## Context

Converting polyphonic audio to MIDI is a hard signal processing problem. Traditional non-ML approaches work poorly — the simpler the source audio, the better the result. This POC explores whether ML-based tools produce MIDI accurate enough to feed into the next stage.

## Open questions

- **How well does basic-pitch handle polyphonic audio?** The model claims polyphonic support, but accuracy on chords and overlapping notes (vs. clean monophonic melody) is unknown. This is a key thing to measure in this POC, since the target input is orchestral audio with multiple simultaneous voices.

## Tools to explore

- [basic-pitch](https://github.com/spotify/basic-pitch) (Spotify) — ML-based, open source, works on polyphonic audio, outputs MIDI

## Success criteria

- Notes and timing are recognizable compared to the source audio
- Output MIDI can be imported into a score editor (e.g. MuseScore) and produce something legible
- Works on the assets in this repo (e.g. `assets/Pokemon RedBlueYellow - Intro 2.mid` can be used as a reference target)
