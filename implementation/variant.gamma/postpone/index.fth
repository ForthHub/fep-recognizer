
\ include ./basic.fth
\ include ./wide.via-association.fth
include ./auto.via-quotation.fth

: postpone ( "name" -- )
  parse-lexeme-sure perceive ?found translate-postpone-qtoken
; immediate


\ include ./test.fth
