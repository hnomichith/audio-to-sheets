---
task: 3
description: Supprimer les changements de clé consécutifs dans les triolets (portée de sol)
status: DONE
---

### Task 3 — Changements de clé consécutifs dans les triolets de VoiceOne

**Resolved questions:** None.

Apply edits in order (haut → bas du fichier) :

#### 3.1 Mesure 9 — supprimer `\clef "bass" \clef "treble"` dans le triolet

**Navigation hint:** lignes 37–40 ; ancre unique : `\stemUp b'4 \clef "bass" \clef "treble" \stemUp`
**Action:** Replace

**Replace:**
```lily
    \stemUp c,2 \times 2/3 {
        \stemUp <e c'>4 \stemUp b'4 \clef "bass" \clef "treble" \stemUp
        c4 }
    | \barNumberCheck #10
```
**With:**
```lily
    \stemUp c,2 \times 2/3 {
        \stemUp <e c'>4 \stemUp b'4 \stemUp c4 }
    | \barNumberCheck #10
```

#### 3.2 Mesure 10 — supprimer `\clef "bass"` parasite dans le triolet

**Navigation hint:** lignes 41–43 ; ancre unique : `\stemUp e4 \clef "bass" \stemUp c4 }`
**Action:** Replace

**Replace:**
```lily
    \stemUp <b d>2 \times 2/3 {
        \stemUp f4 \stemUp e4 \clef "bass" \stemUp c4 }
    | % 11
```
**With:**
```lily
    \stemUp <b d>2 \times 2/3 {
        \stemUp f4 \stemUp e4 \stemUp c4 }
    | % 11
```

#### 3.3 Mesure 11 — supprimer `\clef "treble"` parasite dans le triolet

**Navigation hint:** lignes 44–46 ; ancre unique : `\stemUp b4 \clef "treble" \stemUp c4 }`
**Action:** Replace

**Replace:**
```lily
    \stemUp d2 \times 2/3 {
        \stemUp c4 \stemUp b4 \clef "treble" \stemUp c4 }
    | % 12
```
**With:**
```lily
    \stemUp d2 \times 2/3 {
        \stemUp c4 \stemUp b4 \stemUp c4 }
    | % 12
```

#### 3.4 Mesure 17 — supprimer `\clef "bass" \clef "treble"` dans le triolet

**Navigation hint:** lignes 55–58 ; ancre unique : `<c f>4 \stemUp e4 \clef "bass" \clef "treble"`
**Action:** Replace

**Replace:**
```lily
    r2 \times 2/3 {
        \stemUp <c f>4 \stemUp e4 \clef "bass" \clef "treble" \stemUp f4
        }
    | % 18
```
**With:**
```lily
    r2 \times 2/3 {
        \stemUp <c f>4 \stemUp e4 \stemUp f4
        }
    | % 18
```

#### 3.5 Mesure 25 — supprimer `\clef "bass" \clef "treble"` dans le triolet

**Navigation hint:** lignes 66–69 ; ancre unique : `<a c>4 \stemUp c4 \clef "bass" \clef "treble"`
**Action:** Replace

**Replace:**
```lily
    r2 \times 2/3 {
        \stemUp <a c>4 \stemUp c4 \clef "bass" \clef "treble" \stemUp
        cis4 }
    | % 26
```
**With:**
```lily
    r2 \times 2/3 {
        \stemUp <a c>4 \stemUp c4 \stemUp cis4 }
    | % 26
```

#### 3.6 Mesure 27 — supprimer `\clef "bass" \clef "treble"` dans le triolet

**Navigation hint:** lignes 71–74 ; ancre unique : `<g, c>4 \stemUp c4 \clef "bass" \clef "treble"`
**Action:** Replace

**Replace:**
```lily
    r2 \times 2/3 {
        \stemUp <g, c>4 \stemUp c4 \clef "bass" \clef "treble" \stemUp b4
        }
    | % 28
```
**With:**
```lily
    r2 \times 2/3 {
        \stemUp <g, c>4 \stemUp c4 \stemUp b4
        }
    | % 28
```
