---
task: 9
description: Supprimer les changements de clé parasites dans VoiceSix (portée de fa)
status: DONE
---

### Task 9 — Changements de clé parasites dans VoiceSix

**Resolved questions:** VoiceSix sera supprimée en totalité par la tâche 5. En attendant, ses `\clef` non-initiaux polluent le PDF. On retire tous les `\clef` sauf celui d'ouverture (`\clef "bass"` à la mesure 1). Les notes et spacers restent en place.

Apply edits in order:

#### 9.1 Remplacer PartPOneVoiceSix en supprimant tous les `\clef` non-initiaux

**Navigation hint:** unique anchor: `PartPOneVoiceSix =  \relative f {`
**Action:** Replace

**Replace:**
```lily
PartPOneVoiceSix =  \relative f {
    \clef "bass" \numericTimeSignature\time 4/4 \key c \major s1*8 | % 9
    r2 r4 r8 \stemDown f8 s1*23/3 \clef "treble" s1*5/24 \clef "bass" | % 17
    r2 r4 r8 \stemDown f8 s1 \clef "treble" s8*7 \clef "bass" |
    \barNumberCheck #20
    r4 \stemDown bes4 r2 s4 | % 22
    \clef "treble" r4 \stemDown c4 r2 s1 | % 24
    \clef "bass" s8. \clef "treble" s16 \clef "bass" s8. \clef "treble"
    s16 \clef "bass" s8. \clef "treble" s16 \clef "bass" s8. \clef
    "treble" r8 \stemDown d,8 r8 \stemDown d8 r8 \stemDown d8 r8
    \stemDown d8 | % 25
    \clef "bass" \clef "treble" \clef "bass" \clef "treble" \clef "bass"
    \clef "treble" \clef "bass" r8 \stemDown d8 r8 \stemDown d8 r8
    \stemDown c8 r8 \stemDown cis8 \clef "treble" \clef "bass" \clef
    "treble" \clef "bass" \clef "treble" \clef "bass" \clef "treble" | % 26
    r8 \stemDown d8 r8 \stemDown d8 r8 \stemDown d8 r8 \stemDown d8 | % 27
    \clef "bass" \clef "treble" \clef "bass" \clef "treble" r8 \stemDown
    d8 r8 \stemDown d8 r2 | % 28
    \clef "bass" s16 \bar "|."
    }
```

**With:**
```lily
PartPOneVoiceSix =  \relative f {
    \clef "bass" \numericTimeSignature\time 4/4 \key c \major s1*8 | % 9
    r2 r4 r8 \stemDown f8 s1*23/3 s1*5/24 | % 17
    r2 r4 r8 \stemDown f8 s1 s8*7 |
    \barNumberCheck #20
    r4 \stemDown bes4 r2 s4 | % 22
    r4 \stemDown c4 r2 s1 | % 24
    s8. s16 s8. s16
    s8. s16 s8. s16
    r8 \stemDown d,8 r8 \stemDown d8 r8 \stemDown d8 r8
    \stemDown d8 | % 25
    r8 \stemDown d8 r8 \stemDown d8 r8
    \stemDown c8 r8 \stemDown cis8 | % 26
    r8 \stemDown d8 r8 \stemDown d8 r8 \stemDown d8 r8 \stemDown d8 | % 27
    r8 \stemDown d8 r8 \stemDown d8 r2 | % 28
    s16 \bar "|."
    }
```

**Notes:** Les barcheck warnings préexistants dans VoiceSix (mesures 9, 17, 25) sont liés aux spacers fractionnaires, pas aux clefs — ils ne sont pas affectés par cette tâche.
