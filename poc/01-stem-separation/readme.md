# POC 01 - Stem Separation

## Question

**Can we separate a full audio mix into clean, isolated per-instrument stems with sufficient quality to be usable as input for MIDI conversion?**

## Context

Before converting audio to MIDI, each instrument needs to be isolated — a MIDI converter fed a full mix will produce noise. This POC explores whether current stem separation models produce stems that are clean enough to be the foundation of the rest of the pipeline.

## Tools to explore

- [Demucs](https://github.com/facebookresearch/demucs) (Meta) — current state of the art, separates into up to 6 stems
- [Spleeter](https://github.com/deezer/spleeter) (Deezer) — older (2019), separates into up to 5 stems, lower quality but fast
- [UltimateVocalRemover](https://github.com/Anjok07/ultimatevocalremovergui) — GUI-based, harder to run headless

## Success criteria

- Each stem is recognizable as a single instrument
- Artifacts (bleed from other instruments) are low enough that a MIDI converter can produce a usable result
