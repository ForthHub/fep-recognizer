
0 [if] \ Some other implementations for `postpone`
include ./basic.fth
include ./wide.via-association.fth
include ./auto.via-quotation.fth
[then]

include ./auto.via-mmode.fth

: postpone ( "name" -- )
  parse-lexeme-sure perceive ?found translate-postpone-qtoken
; immediate


\ include ./test.fth
