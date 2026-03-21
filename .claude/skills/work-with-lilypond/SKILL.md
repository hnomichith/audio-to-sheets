---
name: work-with-lilypond
description: LilyPond working constraints for LLM-assisted editing. Invoke before any LilyPond cleanup or editing work — alerts on \relative notation and establishes the safe working mode.
---

# Work with LilyPond

**TRIGGER when:** user opens or mentions a `.ly` file, or any LilyPond skill is invoked.

- If the file contains `\relative`: **stop and notify the user** — pitch analysis is unreliable in relative mode. Ask whether to proceed with micro-edits only or convert to absolute first.
- When writing or rewriting any LilyPond pitch content: **always use absolute notation** (`c'`, `d''`, etc.), never `\relative`.
