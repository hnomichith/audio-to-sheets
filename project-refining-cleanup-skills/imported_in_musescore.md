---
title: Pokémon Red/Blue/Yellow — Intro 2
source_midi: Pokemon RedBlueYellow - Intro 2.mid
lily_file: imported_in_musescore.ly
compiled_pdf: imported_in_musescore.pdf
clean_ly: imported_in_musescore-clean.ly
key: c major
time: 4/4
tempo_first: 120
voices: [PartPOneVoiceOne, PartPOneVoiceTwo, PartPOneVoiceThree, PartPOneVoiceFive, PartPOneVoiceSix]
conversion_tool: musicxml2ly
conversion_chain: MIDI → MuseScore Studio 4.6.5 → MusicXML → musicxml2ly
quantization: N/A (musicxml2ly; no -d/-s grid)
---

## MIDI file description

A 44 seconds piano transcription of the Pokémon Red/Blue/Yellow Intro. The piece is in 4/4, predominantly C major, with a brief F-major passage, and uses quarter triplets.

The users describes the tempo as being between 140 and 150, not moving during the whole piece.

## Midi to Lilypond conversion

The Lilypond sheet has not been obtained using the `midi-to-lilypond` skill. It has been obtained by manually importing the MIDI file in Musescore, then exporting to MusicXML, then converting to Lilypond using a naked `musicxml2ly` command.

## Quantitative analysis

### File

| Metric | Value |
|---|---|
| Lines | 226 |
| File size | 9,679 bytes |
| Measures | 28 |
| Voices | 5 |

### Per-voice breakdown

| Voice | Notes | Rests | Spacers | Tempo events | Clef switches | Tuplets |
|---|---|---|---|---|---|---|
| PartPOneVoiceOne | 56 | 11 | 0 | 2 | 11 | 10 |
| PartPOneVoiceFive | 67 | 7 | 0 | 14 | 33 | 4 |
| PartPOneVoiceTwo | 17 | 24 | 12 | 2 | 11 | 0 |
| PartPOneVoiceSix | 3 | 25 | 15 | 0 | 33 | 0 |
| PartPOneVoiceThree | 2 | 4 | 13 | 1 | 11 | 0 |

### Noise metrics

| Metric | Value |
|---|---|
| Total `\tempo` events | 18 |
| Unique tempo values | 8 (120, 144–150) |
| Total `\clef` switches | 88 |
| Spacer rest tokens | 40 |
| Spacer rests with fractional multipliers | 20 |
| Cross-staff `\change Staff` events | 6 |
| `\barNumberCheck` assertions | 8 |
| Explicit stem direction directives | 109 |
| `\omit` directives | 2 |

### Ghost voice signals (notes ÷ measures)

| Voice | Notes | Measures | Ratio |
|---|---|---|---|
| PartPOneVoiceSix | 3 | 28 | 11% |
| PartPOneVoiceThree | 2 | 28 | 7% |

## Cleanup tasks

**Structure cible :** Piano solo — portée de sol (1 voix) + portée de fa (1 voix)

| # | Prio | Description musicale | Résumé technique | Statut | Fichier |
|---|---|---|---|---|---|
| 8 | P1 | Supprimer les changements de clé parasites dans VoiceFive (portée de fa) | Retirer tous les `\clef "treble"` / `\clef "bass"` non-initiaux dans VoiceFive (mesures 17–28) | DONE | [task-8.md](cleanup-tasks/task-8.md) |
| 9 | P1 | Supprimer les changements de clé parasites dans VoiceSix (portée de fa) | Retirer tous les `\clef "treble"` / `\clef "bass"` non-initiaux dans VoiceSix (mesures 17–28) — voix temporaire en attente de la tâche 5 | DONE | [task-9.md](cleanup-tasks/task-9.md) |
| 4 | P2 | Consolider la portée de sol : fusionner VoiceTwo dans VoiceOne | VoiceTwo a du contenu réel en mesures 6–7, 9–11, 14–15, 17, 20–27 — fusion mesure par mesure | TO SCOPE | — |
| 5 | P2 | Consolider la portée de fa : résoudre VoiceSix | VoiceSix a des notes réelles ; déterminer overlaps avec VoiceFive avant suppression | TO SCOPE | — |
| 1 | P1 | Supprimer la voix fantôme (portée de sol, voix 3) | Supprimer `PartPOneVoiceThree` + retirer du bloc `\score` | DONE | [task-1.md](cleanup-tasks/task-1.md) |
| 2 | P1 | Supprimer les tempos parasites et les blocs `\change Staff` | Retirer 2 clusters `\tempo` en cascade dans VoiceFive (mesures 7–8, 15–16) ; retirer 2 `\tempo 4=146` isolés dans VoiceTwo (mesures 7, 15) | DONE | [task-2.md](cleanup-tasks/task-2.md) |
| 3 | P1 | Supprimer les changements de clé consécutifs dans les triolets (portée de sol) | Retirer `\clef "bass" \clef "treble"` parasites dans VoiceOne aux mesures 9–11, 17, 25, 27 | DONE | [task-3.md](cleanup-tasks/task-3.md) |
| 6 | P1 | Supprimer les changements de clé parasites dans VoiceTwo (portée de sol) | Retirer 6 paires `\clef "bass"` / `\clef "treble"` autour de spacers `s` | DONE | [task-6.md](cleanup-tasks/task-6.md) |
| 7 | P1 | Corriger le tempo : fixer à 144 bpm fixe | Remplacer `\tempo 4=120` par `\tempo 4=144` ; supprimer `\tempo 4=150` parasite | DONE | [task-7.md](cleanup-tasks/task-7.md) |

## Task details

### Task 4 — Consolidation portée de sol — TO SCOPE

**Target:** Une seule voix sur la portée de sol (VoiceOne conservée, VoiceTwo fusionnée dedans puis supprimée)

**Diagnosis:** VoiceTwo a du contenu réel dans ~15 mesures : fragment mélodique fa4./mi16/mib16 aux mesures 6 et 14, notes internes aux mesures 7, 9–11, 15, 17, et accords complexes aux mesures 20–27. La fusion nécessite de décider mesure par mesure quelles notes de VoiceTwo entrent dans VoiceOne (accord, voix secondaire, ou suppression si doublon).

**Re-planning note:** Planifier la fusion mesure par mesure : mesures 6–17 (structure répétée, plus simple) d'abord, puis mesures 20–27 (accords plus denses).

---

### Task 5 — Consolidation portée de fa — TO SCOPE

**Target:** Une seule voix sur la portée de fa (VoiceFive conservée, VoiceSix résolue)

**Diagnosis:** VoiceSix a des notes réelles : fa8 mesures 9 et 17, sib4 mesure 20, do4 mesure 22, puis série de ré graves mesures 24–28. Les mesures 9 et 17 pourraient être des doublons de VoiceFive (même registre fa). Les mesures 24–28 semblent distinctes de la figure d'octave cross-staff de VoiceFive.

**Re-planning note:** Commencer par les mesures 9 et 17 (1 note chacune, overlap à vérifier) ; traiter mesures 24–28 séparément (pattern ré grave vs octave VoiceFive).
