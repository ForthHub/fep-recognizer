\ 2024-12-03 ruv

\ https://www.complang.tuwien.ac.at/forth/colorforth-bw
(
  [ -> execute
  _ -> compile
  ] -> postpone
)


: apply-recognizer-cf ( sd.lexeme recognizer -- char.color qt | 0 )
  over 2 < if drop 2drop 0 exit then
  >r over c@ -rot 1 /string ( char.color sd.sub-lexeme )
  r> execute dup 0= if nip then
;

: recognize-number-singlecell-colored ( sd.lexeme -- qt|0 )
  \ Reuse a recognizer for numbers
  ['] recognize-number-n-prefixed apply-recognizer-cf dup 0= if exit then
  ['] tt-x <> abort" assertion failed: unexpected qtoken" ( char.color n ) swap
  [: case
      '[' of endof
      '_' of lit, endof
      ']' of lit, postpone lit, endof
      true abort" unknown color symbol"
    endcase
  ;]
;

: recognize-name-colored ( sd.lexeme -- qt|0 )
  ['] find-name apply-recognizer-cf dup 0= if exit then ( char.color nt ) swap
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
