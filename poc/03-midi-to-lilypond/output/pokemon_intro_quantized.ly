% Lily was here -- automatically converted by midi2ly from assets/Pokemon RedBlueYellow - Intro 2.mid
\version "2.14.0"

\layout {
  \context {
    \Voice
    \remove Note_heads_engraver
    \consists Completion_heads_engraver
    \remove Rest_engraver
    \consists Completion_rest_engraver
  }
}

trackAchannelA = {


  \key c \major
    
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 120 
  
  \tempo 4 = 150 
  
  \tempo 4 = 150 
  \skip 2*13 
  \tempo 4 = 150 
  \skip 16 
  \tempo 4 = 148 
  \skip 16 
  \tempo 4 = 147 
  \skip 16 
  \tempo 4 = 147 
  \skip 16 
  \tempo 4 = 146 
  \skip 16 
  \tempo 4 = 145 
  \skip 16 
  \tempo 4 = 144 
  \skip 16 
  \tempo 4 = 144 
  \skip 8 
  \tempo 4 = 150 
  \skip 16*119 
  \tempo 4 = 150 
  \skip 16 
  \tempo 4 = 148 
  \skip 16 
  \tempo 4 = 147 
  \skip 16 
  \tempo 4 = 147 
  \skip 16 
  \tempo 4 = 146 
  \skip 16 
  \tempo 4 = 145 
  \skip 16 
  \tempo 4 = 144 
  \skip 16 
  \tempo 4 = 144 
  \skip 8 
  \tempo 4 = 150 
  \skip 16*63 

  \key f \major
  \skip 1*2 

  \key c \major
  \skip 1*7 
}

trackA = <<
  \context Voice = voiceA \trackAchannelA
>>


trackBchannelA = {
  
  \set Staff.instrumentName = "Piano"
  \skip 1*28 
}

trackBchannelB = \relative c {
  \voiceFour
  r2. g'16 b d fis 
  | % 2
  <g g, b >4 <g, b > r8 g'16 g <g g, b >4 
  | % 3
  <g g, b > <g g, b > f16 f8 f16 f f8 fis16 
  | % 4
  g,4 g8 <b' d,, > g,4 d8 g 
  | % 5
  f4 f8 <f' c, > f,4 c8 e''16 dis 
  | % 6
  g,,4 g8 d g4 d8 e'16 dis 
  | % 7
  g,4 g8 d c''8. b8 c8. 
  | % 8
  g,4 g8 <b' d,, > g,4 d8 g 
  | % 9
  f4 f8 c <e' c' >8. <d b' >8 <e c' >8. 
  | % 10
  g,4 g8 d f'8. e8 c8. 
  | % 11
  g4 g8 d c'8. b8 c8. 
  | % 12
  g4 g8 <b' d,, > g,4 d8 g 
  | % 13
  f4 f8 <f' c, > f,4 c8 e''16 dis 
  | % 14
  g,,4 g8 d g4 d8 e'16 dis 
  | % 15
  g,4 g8 d c''8. b8 c8. 
  | % 16
  g,4 g8 <b' d,, > g,4 d8 g 
  | % 17
  f4 f8 c <c'' f >8. <b e >8 <c f >8. 
  | % 18
  g,4 g8 <f'' d,, ais''' > g,,4 d8 g 
  | % 19
  g4 g8 d f g a c 
  | % 20
  <ais d >4 <ais d > <ais d > <ais d > 
  | % 21
  <ais d > <ais d > <g'' ais ais,, d > <f b b,, d > 
  | % 22
  <c, e > <c e > <c e > <c e > 
  | % 23
  <c e > <c e > <a'' c c,, e > <g cis cis,, e > 
  | % 24
  d,,8 d d d d d d d 
  | % 25
  d d d d c c c cis 
  | % 26
  d d d d d d d d 
  | % 27
  d d d d <g'' c >8. <g c >8 <g b >8. 
  | % 28
  <b, d g g,,, >1 
  | % 29
  
}

trackBchannelBvoiceB = \relative c {
  \voiceOne
  r4*5 g''4. r8*7 <f, a >4 <f a > g'4. r8 
  | % 4
  d'2 c,4. r8 
  | % 5
  f'4. f,,8 d''1 d,2 g,4 d8 g 
  | % 8
  <d' g >4. r8 d'2 
  | % 9
  c, f,4 c8 f 
  | % 10
  <b' d >2 g,4 d8 g 
  | % 11
  d'2 g,4 d8 g 
  | % 12
  <d' g >4. r8 d'2 
  | % 13
  c,4. r8 f'4. f,,8 
  | % 14
  d''1 
  | % 15
  d,2 g,4 d8 g 
  | % 16
  <d' g >4. r8 d'2 
  | % 17
  r2 f,,4 c8 f 
  | % 18
  <d'' g >4. r8 <d g >1 <dis a' >2 <f ais >4. <d f >8 
  | % 20
  <d f >1 
  | % 21
  r2 <g c >4. <e g >8 
  | % 22
  <e g >1 
  | % 23
  r2 d'8. d,16 r8. d16 
  | % 24
  r8. d16 r8. d16 r8. d16 r8. d16 
  | % 25
  <a' c >8. <a c >8 <g cis >8. d' d,16 r8. d16 
  | % 26
  r8. d16 r8. d16 r8. d16 r8. d16 
  | % 27
  c,,4 g 
}

trackBchannelBvoiceC = \relative c {
  \voiceThree
  r2*11 f'4. g,8 r2*15 f'4. g,8 
}

trackB = <<
  \context Voice = voiceA \trackBchannelA
  \context Voice = voiceB \trackBchannelB
  \context Voice = voiceC \trackBchannelBvoiceB
  \context Voice = voiceD \trackBchannelBvoiceC
>>


\score {
  <<
    \context Staff=trackB \trackA
    \context Staff=trackB \trackB
  >>
  \layout {}
  \midi {}
}
