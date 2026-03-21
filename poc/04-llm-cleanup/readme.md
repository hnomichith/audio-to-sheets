# POC 04 - LLM Cleanup and Iteration

## Question

**Can an LLM take a raw, messy LilyPond score and produce a clean, musically correct version — and then iterate on it based on natural language instructions?**

## Context

MIDI-to-score conversion produces structurally valid but musically nonsensical output: notes are quantized to timestamps rather than musical values, voices are not separated, and the result is unreadable. This is the core problem this project aims to solve. The hypothesis is that LLMs, given a compact LilyPond representation, can both clean up the score and respond to arrangement instructions (e.g. "split this into two voices", "extract the melody", "transpose to C major").

The target interaction model is **one-shot cleanup**: given a messy LilyPond file and a prompt, the LLM produces a clean, usable score in a single pass. An iterative loop (user reviews and refines via follow-up instructions) is an acceptable intermediate step while the one-shot approach is being validated.

## What to explore

- Can the LLM correctly identify and fix quantization artifacts?
- Can it infer time signature and bar structure from context?
- Can it separate voices in a polyphonic passage?
- Can it apply arrangement changes described in natural language?

## Success criteria

- Output LilyPond compiles and renders a score that a musician would recognize as correct
- The LLM can apply at least one non-trivial arrangement change on request
- The round-trip (messy MIDI → LilyPond → LLM → clean score) produces something a musician could use as a starting point
