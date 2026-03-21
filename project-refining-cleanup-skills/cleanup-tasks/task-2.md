---
task: 2
description: Supprimer les tempos parasites et les blocs \change Staff
status: DONE
---

### Task 2 — Tempos parasites et blocs `\change Staff`

**Resolved questions:** None.

Apply edits in order (haut → bas du fichier) :

#### 2.1 VoiceFive mesures 7–8 — retirer le cluster de tempos en cascade

**Navigation hint:** lignes 91–92 ; ancre unique : `\tempo 4=149 \tempo 4=148 ... | % 8`
**Action:** Replace

**Replace:**
```lily
    g8 \change Staff="1" \tempo 4=149 \tempo 4=148 \tempo 4=147 \tempo
    4=146 \tempo 4=145 \tempo 4=144 \change Staff="2" | % 8
```
**With:**
```lily
    g8 | % 8
```

#### 2.2 VoiceFive mesure 8 — retirer `\change Staff + \tempo 4=150`

**Navigation hint:** ligne 94 ; ancre unique : `\tempo 4=150 \change Staff="2" | % 9`
**Action:** Replace

**Replace:**
```lily
    [ \stemDown g8 ] \change Staff="1" \tempo 4=150 \change Staff="2" | % 9
```
**With:**
```lily
    [ \stemDown g8 ] | % 9
```

#### 2.3 VoiceFive mesures 15–16 — retirer le cluster de tempos en cascade

**Navigation hint:** lignes 108–109 ; ancre unique : `\tempo 4=149 \tempo 4=148 ... | % 16`
**Action:** Replace

**Replace:**
```lily
    g8 \change Staff="1" \tempo 4=149 \tempo 4=148 \tempo 4=147 \tempo
    4=146 \tempo 4=145 \tempo 4=144 \change Staff="2" | % 16
```
**With:**
```lily
    g8 | % 16
```

#### 2.4 VoiceFive mesure 16 — retirer `\change Staff + \tempo 4=150`

**Navigation hint:** ligne 111 ; ancre unique : `\tempo 4=150 \change Staff="2" | % 17`
**Action:** Replace

**Replace:**
```lily
    [ \stemDown g8 ] \change Staff="1" \tempo 4=150 \change Staff="2" | % 17
```
**With:**
```lily
    [ \stemDown g8 ] | % 17
```

#### 2.5 VoiceTwo mesure 7 — retirer `\tempo 4=146` isolé

**Navigation hint:** ligne 149 ; ancre unique : `d,4 -. s4*7 ... | % 9`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \tempo 4=146 \stemDown d,4 -. s4*7 \clef "bass" s1*1/12 \clef
    "treble" | % 9
```
**With:**
```lily
    r2 r4 \stemDown d,4 -. s4*7 \clef "bass" s1*1/12 \clef
    "treble" | % 9
```

#### 2.6 VoiceTwo mesure 15 — retirer `\tempo 4=146` isolé

**Navigation hint:** ligne 155 ; ancre unique : `d,4 -. s4*7 ... | % 17`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \tempo 4=146 \stemDown d,4 -. s4*7 \clef "bass" s1*1/12 \clef
    "treble" | % 17
```
**With:**
```lily
    r2 r4 \stemDown d,4 -. s4*7 \clef "bass" s1*1/12 \clef
    "treble" | % 17
```
