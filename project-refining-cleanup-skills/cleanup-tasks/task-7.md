---
task: 7
description: Corriger le tempo — fixer à 144 bpm fixe
status: DONE
---

### Task 7 — Tempo : fixer à 144 bpm fixe

**Resolved questions:** L'utilisateur confirme tempo 144 bpm fixe sur toute la pièce.

Apply edits in order (haut → bas du fichier) :

#### 7.1 Mesure 1 — remplacer `\tempo 4=120` par `\tempo 4=144`

**Navigation hint:** ligne 18 ; ancre unique : `\tempo 4=120 r2 r4 \stemUp g16`
**Action:** Replace

**Replace:**
```lily
    \tempo 4=120 r2 r4 \stemUp g16 [ \stemUp b16 \stemUp d16 \stemUp fis16
```
**With:**
```lily
    \tempo 4=144 r2 r4 \stemUp g16 [ \stemUp b16 \stemUp d16 \stemUp fis16
```

#### 7.2 Mesure 8 — supprimer `\tempo 4=150` parasite dans le triolet

**Navigation hint:** ligne 33 ; ancre unique : `\stemUp d,2 \tempo 4=150 \times 2/3`
**Action:** Replace

**Replace:**
```lily
    \stemUp d,2 \tempo 4=150 \times 2/3 {
```
**With:**
```lily
    \stemUp d,2 \times 2/3 {
```
