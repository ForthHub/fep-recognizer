\ 2024-12-03 ruv

\ https://www.complang.tuwien.ac.at/forth/colorforth-bw
(
  [ -> execute
  _ -> compile
  ] -> postpone
)


: apply-recognizer-cf ( sd.lexeme recognizer -- qt char.color\0 | 0 )
  -rot dup 2 < if 2drop drop 0 exit then
  over c@ dup 0= if 2nip nip exit then ( recognizer sd.lexeme char.color\0 )
  >r 1 /string rot execute dup if r> exit then rdrop
;

: recognize-number-singlecell-colored ( sd.lexeme -- qt|0 )
  \ Reuse a recognizer for numbers
  ['] recognize-number-n-prefixed apply-recognizer-cf dup 0= if exit then
  swap ['] tt-x <> abort" assertion failed: unexpected qtoken" ( n char.color )
  [: case
      '[' of endof
      '_' of lit, endof
      ']' of lit, postpone lit, endof
      true abort" unknown color symbol"
    endcase
  ;]
;

: recognize-name-colored ( sd.lexeme -- qt|0 )
  ['] find-name apply-recognizer-cf dup 0= if exit then ( nt char.color )
  [: case
      '[' of name> execute endof
      '_' of name>compile execute endof
      ']' of name>compile swap lit, compile, endof
      true abort" unknown color symbol"
    endcase
  ;]
;

: recognize-colorforth-bw ( sd.lexeme -- qt|0 )
  2dup 2>r recognize-name-colored dup if 2rdrop exit then drop
  2r> recognize-number-singlecell-colored
;



\ A text translator for testing purposes

0 value cf.perceptor-orig

: begin-cf
  ['] recognize-colorforth-bw perceptor
  2dup = if 2drop exit then ( recognizer.cf recognizer.perceptor )
  to cf.perceptor-orig  set-perceptor
;
: end-cf
  cf.perceptor-orig set-perceptor
;
: cf\\ ( any "ccc" -- any )
  begin-cf  ['] translate-source-following catch  end-cf  throw
; immediate

: cf( ( any "ccc" "<rparen>" -- any )
  begin-cf
  [: begin s" )" extract-lexeme-before dup while translate-lexeme repeat 2drop ;]
  catch  end-cf  throw
; immediate

0 [if] \ Usage example
  \ NB: This example may not work in some dual-xt systems.
  cf\\ [: foo  [if _10 [else _-10 [then _. [;
  0 foo \ prints "-10"

  : fo, cf( ]1 ]foo ) ;
  : bar cf( [fo,    ) ;
  bar \ prints "10"
[then]
