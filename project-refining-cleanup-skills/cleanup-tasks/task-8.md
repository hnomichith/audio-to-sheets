---
task: 8
description: Supprimer les changements de clé parasites dans VoiceFive (portée de fa)
status: DONE
---

### Task 8 — Changements de clé parasites dans la portée de fa (VoiceFive)

**Resolved questions:** None. La cible est une seule voix par portée → toute directive `\clef` qui n'est pas la clé d'ouverture est parasite. Les notes restent en place ; celles en registre aigu seront traitées lors de la consolidation (tâche 5).

Apply edits in order:

#### 8.1 Remplacer PartPOneVoiceFive en supprimant tous les `\clef` non-initiaux

**Navigation hint:** lines 76–140; unique anchor: `PartPOneVoiceFive =  \relative g {`
**Action:** Replace

**Replace:**
```lily
 PartPOneVoiceFive =  \relative g {
    \clef "bass" \numericTimeSignature\time 4/4 \key c \major | % 1
    R1 | % 2
    \stemDown <g b>4 \stemDown <g b>4 r4 \stemDown <g b>4 | % 3
    \stemDown <g b>4 \stemDown <g b>4 \stemDown <f a>4 \stemDown <f a>4
    | % 4
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 5
    \stemDown f4 \stemDown f8 [ \stemDown c8 ] \stemDown f4 \stemDown c8
    [ \stemDown f8 ] | % 6
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 7
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r8 \stemDown
    g8 | % 8
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 9
    \stemUp f4 \stemUp f8 [ \stemUp c8 ] \times 2/3 {
        \stemUp f4 \stemUp d'4 \stemUp e4 }
    | \barNumberCheck #10
    \stemDown g,4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r4 | % 11
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r8 \stemDown
    g8 | % 12
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 13
    \stemDown f4 \stemDown f8 [ \stemDown c8 ] \stemDown f4 \stemDown c8
    [ \stemDown f8 ] | % 14
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 15
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r8 \stemDown
    g8 | % 16
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 17
    \stemUp f4 \stemUp f8 [ \stemUp c8 ] \times 2/3 {
        \stemUp f4 \clef "treble" \stemUp b'4 \stemUp c4 }
    \clef "bass" | % 18
    \stemDown g,4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 19
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemUp f8 [ \stemUp g8
    \stemUp a8 \clef "treble" \stemUp c8 ] | \barNumberCheck #20
    \stemUp <bes d>4 r8 \stemUp d'8 \stemUp <bes, d>4 \clef "bass"
    \stemUp bes4 | % 21
    \stemDown bes4 \stemDown bes4 \stemDown <bes d>4 \stemDown <b d>4 | % 22
    \clef "treble" \stemUp <c e>4 r8 \stemUp e'8 \stemUp <c, e>4 \stemUp
    c4 | % 23
    \stemUp c4 \stemUp c4 \stemUp <c e>4 \stemUp <cis e>4 | % 24
    \clef "bass" \stemUp d,8. -. [ \clef "treble" \stemUp d''16 ] \clef
    "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef
    "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef
    "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] | % 25
    \clef "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef
    "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef
    "bass" \times 2/3 {
        \stemUp c,,4 \clef "treble" \stemUp a'''4 \stemUp g4 }
    \clef "bass" | % 26
    \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef "bass"
    \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef "bass"
    \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef "bass"
    \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] | % 27
    \clef "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \clef
    "bass" \stemUp d,,8. -. [ \clef "treble" \stemUp d''16 ] \times 2/3
    {
        \stemUp c,,4 \stemUp g'''4 \stemUp g4 }
    | % 28
    \clef "bass" g,,,1 \bar "|."
    }
```

**With:**
```lily
 PartPOneVoiceFive =  \relative g {
    \clef "bass" \numericTimeSignature\time 4/4 \key c \major | % 1
    R1 | % 2
    \stemDown <g b>4 \stemDown <g b>4 r4 \stemDown <g b>4 | % 3
    \stemDown <g b>4 \stemDown <g b>4 \stemDown <f a>4 \stemDown <f a>4
    | % 4
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 5
    \stemDown f4 \stemDown f8 [ \stemDown c8 ] \stemDown f4 \stemDown c8
    [ \stemDown f8 ] | % 6
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 7
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r8 \stemDown
    g8 | % 8
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 9
    \stemUp f4 \stemUp f8 [ \stemUp c8 ] \times 2/3 {
        \stemUp f4 \stemUp d'4 \stemUp e4 }
    | \barNumberCheck #10
    \stemDown g,4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r4 | % 11
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r8 \stemDown
    g8 | % 12
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 13
    \stemDown f4 \stemDown f8 [ \stemDown c8 ] \stemDown f4 \stemDown c8
    [ \stemDown f8 ] | % 14
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 15
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 r8 \stemDown
    g8 | % 16
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 17
    \stemUp f4 \stemUp f8 [ \stemUp c8 ] \times 2/3 {
        \stemUp f4 \stemUp b'4 \stemUp c4 }
    | % 18
    \stemDown g,4 \stemDown g8 [ \stemDown d8 ] \stemDown g4 \stemDown d8
    [ \stemDown g8 ] | % 19
    \stemDown g4 \stemDown g8 [ \stemDown d8 ] \stemUp f8 [ \stemUp g8
    \stemUp a8 \stemUp c8 ] | \barNumberCheck #20
    \stemUp <bes d>4 r8 \stemUp d'8 \stemUp <bes, d>4
    \stemUp bes4 | % 21
    \stemDown bes4 \stemDown bes4 \stemDown <bes d>4 \stemDown <b d>4 | % 22
    \stemUp <c e>4 r8 \stemUp e'8 \stemUp <c, e>4 \stemUp
    c4 | % 23
    \stemUp c4 \stemUp c4 \stemUp <c e>4 \stemUp <cis e>4 | % 24
    \stemUp d,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ] | % 25
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ] \times 2/3 {
        \stemUp c,,4 \stemUp a'''4 \stemUp g4 }
    | % 26
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ] | % 27
    \stemUp d,,8. -. [ \stemUp d''16 ]
    \stemUp d,,8. -. [ \stemUp d''16 ] \times 2/3
    {
        \stemUp c,,4 \stemUp g'''4 \stemUp g4 }
    | % 28
    g,,,1 \bar "|."
    }
```

**Notes:** Les notes aiguës (ré'', si', do, etc.) restent en portée de fa et seront traitées lors de la consolidation (tâche 5). Les `\clef` de VoiceSix ne sont pas touchés ici : cette voix sera entièrement supprimée par la tâche 5.
