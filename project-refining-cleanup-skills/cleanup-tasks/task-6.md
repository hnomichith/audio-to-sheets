---
task: 6
description: Supprimer les changements de clé parasites dans VoiceTwo (portée de sol)
status: DONE
---

### Task 6 — Changements de clé parasites dans VoiceTwo

**Resolved questions:** None. Toutes les paires `\clef` visées encadrent exclusivement des spacers `s` — aucune note entre elles.

Apply edits in order (haut → bas du fichier) :

#### 6.1 Mesures 7–9 — retirer `\clef "bass" … \clef "treble"` autour du spacer

**Navigation hint:** lignes 145–146 ; ancre unique : `d,4 -. s4*7 \clef "bass" s1*1/12`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \stemDown d,4 -. s4*7 \clef "bass" s1*1/12 \clef
    "treble" | % 9
```
**With:**
```lily
    r2 r4 \stemDown d,4 -. s4*7 s1*1/12 | % 9
```

#### 6.2 Mesure 9–10 — retirer `\clef "bass"` en fin de mesure

**Navigation hint:** ligne 147 ; ancre unique : `c4 -. \clef "bass" | \barNumberCheck`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \stemDown c4 -. \clef "bass" | \barNumberCheck #10
```
**With:**
```lily
    r2 r4 \stemDown c4 -. | \barNumberCheck #10
```

#### 6.3 Mesure 10–11 — retirer `\clef "treble"` en fin de mesure

**Navigation hint:** ligne 148 ; ancre unique : `\stemDown g8 ] \clef "treble" | % 11`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \stemDown d8 [ \stemDown g8 ] \clef "treble" | % 11
```
**With:**
```lily
    r2 r4 \stemDown d8 [ \stemDown g8 ] | % 11
```

#### 6.4 Mesures 15–17 — retirer `\clef "bass" … \clef "treble"` autour du spacer

**Navigation hint:** lignes 151–152 ; ancre unique : `d,4 -. s4*7 \clef "bass" s1*1/12 \clef`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \stemDown d,4 -. s4*7 \clef "bass" s1*1/12 \clef
    "treble" | % 17
```
**With:**
```lily
    r2 r4 \stemDown d,4 -. s4*7 s1*1/12 | % 17
```

#### 6.5 Mesures 23–25 — retirer `\clef "bass" … \clef "treble"` autour du spacer

**Navigation hint:** lignes 157–158 ; ancre unique : `<g cis>4 s4*7`
**Action:** Replace

**Replace:**
```lily
    \stemDown e4 \stemDown e4 \stemDown <a' c>4 \stemDown <g cis>4 s4*7
    \clef "bass" s1*1/12 \clef "treble" | % 25
```
**With:**
```lily
    \stemDown e4 \stemDown e4 \stemDown <a' c>4 \stemDown <g cis>4 s4*7
    s1*1/12 | % 25
```

#### 6.6 Mesures 26–27 — retirer `\clef "bass" … \clef "treble"` autour du spacer

**Navigation hint:** lignes 159–160 ; ancre unique : `c,,,4 -. s1*11/12 \clef "bass"`
**Action:** Replace

**Replace:**
```lily
    r2 r4 \stemDown c,,,4 -. s1*11/12 \clef "bass" s1*1/12 \clef
    "treble" | % 27
```
**With:**
```lily
    r2 r4 \stemDown c,,,4 -. s1*11/12 s1*1/12 | % 27
```
