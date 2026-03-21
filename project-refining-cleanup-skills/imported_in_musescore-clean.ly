\version "2.24.3"
% automatically converted by musicxml2ly from poc/03-midi-to-lilypond/imported_in_musescore.musicxml
\pointAndClickOff

\header {
    encodingsoftware =  "MuseScore Studio 4.6.5"
    encodingdate =  "2026-03-21"
    }

\layout {
    \context { \Score
        skipBars = ##t
        autoBeaming = ##f
        }
    }
 PartPOneVoiceOne =  \relative g {
    \clef "treble" \numericTimeSignature\time 4/4 \key c \major | % 1
    \tempo 4=144 r2 r4 \stemUp g16 [ \stemUp b16 \stemUp d16 \stemUp fis16
    ] | % 2
    \stemUp g4 \stemUp g4 ~ \stemUp g8 [ \stemUp g16 \stemUp g16 ]
    \stemUp g4 | % 3
    \stemUp g4 \stemUp g4 \once \omit TupletBracket
    \times 2/3  {
        \stemUp f8 [ \stemUp f8 \stemUp f8 ] }
    \once \omit TupletBracket
    \times 2/3  {
        \stemUp f8 [ \stemUp f8 \stemUp fis8 ] }
    | % 4
    \stemUp g4. \stemDown b8 \stemDown d2 | % 5
    \stemUp c,4. \stemUp f8 \stemDown f'4. \stemDown e16 [ \stemDown es16
    ] | % 6
    d1 | % 7
    \stemUp d,2 \times 2/3 {
        \stemUp c'4 \stemUp b4 \stemUp c4 }
    | % 8
    \stemUp <d, g>4. \stemDown b'8 \stemDown d2 | % 9
    \stemUp c,2 \times 2/3 {
        \stemUp <e c'>4 \stemUp b'4 \stemUp c4 }
    | \barNumberCheck #10
    \stemUp <b d>2 \times 2/3 {
        \stemUp f4 \stemUp e4 \stemUp c4 }
    | % 11
    \stemUp d2 \times 2/3 {
        \stemUp c4 \stemUp b4 \stemUp c4 }
    | % 12
    \stemUp <d g>4. \stemDown b'8 \stemDown d2 | % 13
    \stemUp c,4. \stemUp f8 \stemDown f'4. \stemDown e16 [ \stemDown es16
    ] | % 14
    d1 | % 15
    \stemUp d,2 \times 2/3 {
        \stemUp c'4 \stemUp b4 \stemUp c4 }
    | % 16
    \stemUp <d, g>4. \stemDown b'8 \stemDown d2 | % 17
    r2 \times 2/3 {
        \stemUp <c f>4 \stemUp e4 \stemUp f4
        }
    | % 18
    \stemDown <d g>4. \stemDown <f bes>8 \stemDown <d g>2 ~ ~ | % 19
    \stemDown <d g>2 \stemDown <es a>2 | \barNumberCheck #20
    \stemUp <f bes>2 \stemUp <d f>2 ~ ~ | % 21
    \stemUp <d f>2 r2 | % 22
    \stemUp <g c>2 \stemUp <e g>2 ~ ~ | % 23
    \stemUp <e g>2 r2 | % 24
    \stemDown d'4 r4 r2 | % 25
    r2 \times 2/3 {
        \stemUp <a c>4 \stemUp c4 \stemUp cis4 }
    | % 26
    \stemDown d4 r4 r2 | % 27
    r2 \times 2/3 {
        \stemUp <g, c>4 \stemUp c4 \stemUp b4
        }
    | % 28
    <b, d g>1 \bar "|."
    }

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
        \stemUp f4 \change Staff = "1" \stemUp d'4 \stemUp e4 \change Staff = "2" }
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

PartPOneVoiceTwo =  \relative f' {
    \clef "treble" \numericTimeSignature\time 4/4 \key c \major s1*5 | % 6
    r2 \stemDown f4. \stemDown e16 [ \stemDown es16 ] | % 7
    r2 r4 \stemDown d,4 -. s4*7 s1*1/12 | % 9
    r2 r4 \stemDown c4 -. | \barNumberCheck #10
    r2 r4 \stemDown d8 [ \stemDown g8 ] | % 11
    r2 r4 \stemDown d4 -. s1*7/6 | % 14
    r2 \stemDown f'4. \stemDown e16 [ \stemDown es16 ] | % 15
    r2 r4 \stemDown d,4 -. s4*7 s1*1/12 | % 17
    r2 r4 \stemDown c4 -. s1*7/6 | \barNumberCheck #20
    r4 r8 \stemDown f''8 r4 \stemDown d,4 | % 21
    \stemDown d4 \stemDown d4 \stemDown <g' bes>4 \stemDown <f b>4 | % 22
    r4 r8 \stemDown g8 r4 \stemDown e,4 | % 23
    \stemDown e4 \stemDown e4 \stemDown <a' c>4 \stemDown <g cis>4 s4*7
    s1*1/12 | % 25
    r2 r4 \stemDown c,,,4 -. s1*11/12 s1*1/12 | % 27
    r2 r4 \stemDown g4 s1*1/6 \bar "|."
    }

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
    \bar "|."
    }

% The score definition
\score {
    <<

        \new PianoStaff
        <<
            \set PianoStaff.instrumentName = "Piano, Piano"
            \set PianoStaff.shortInstrumentName = "Pia."

            \context Staff = "1" <<
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceOne" {  \voiceOne \PartPOneVoiceOne }
                \context Voice = "PartPOneVoiceTwo" {  \voiceTwo \PartPOneVoiceTwo }
                >> \context Staff = "2" <<
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceFive" {  \voiceOne \PartPOneVoiceFive }
                \context Voice = "PartPOneVoiceSix" {  \voiceTwo \PartPOneVoiceSix }
                >>
            >>

        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
      \midi {\tempo 4 = 120 }
    }
