---
task: 1
description: Supprimer la voix fantôme (portée de sol, voix 3)
status: DONE
---

### Task 1 — Voix fantôme portée de sol (VoiceThree)

**Resolved questions:** Les 2 notes (ré4 mesure 20 et mi4 mesure 22) sont des doublons de VoiceTwo — confirmé à supprimer.

Apply edits in order (bas → haut du fichier — les deux sont des suppressions) :

#### 1.1 Retirer VoiceThree du bloc `\score`

**Navigation hint:** ligne 213 ; ancre unique : `\voiceThree \PartPOneVoiceThree`
**Action:** Delete block

**Remove:**
```lily
                \context Voice = "PartPOneVoiceThree" {  \voiceThree \PartPOneVoiceThree }
```

#### 1.2 Supprimer la définition de `PartPOneVoiceThree`

**Navigation hint:** lignes 189–197 ; ancre unique : `PartPOneVoiceThree =  \relative d'`
**Action:** Delete block

**Remove:**
```lily
PartPOneVoiceThree =  \relative d' {
    \clef "treble" \numericTimeSignature\time 4/4 \key c \major s4*35
    \clef "bass" s1*1/12 \clef "treble" s1*11/12 \clef "bass" s1*13/12
    \clef "treble" s1*71/12 \clef "bass" s1*1/12 \clef "treble" s1*13/6
    | \barNumberCheck #20
    r4 \stemUp d4 r2 s1 | % 22
    r4 \stemUp e4 r2 s4*11 \clef "bass" s1*1/12 \clef "treble" s1*23/12
    \clef "bass" s1*1/12 \clef "treble" s1*7/6 \bar "|."
    }
```
