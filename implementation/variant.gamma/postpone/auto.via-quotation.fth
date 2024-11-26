\ An implementation for `postpone`,
\ which applies to words, numbers, and other lexemes
\ whose compilation semantics are to append their interpretation semantics.
\ No need to define new postponers at all.

[undefined] qtoken>compile? [if]
  include ./basic.fth
[then]


\ Avoid using `postpone`, and use the internal word `[c]` instead.
: [c] ( "lexeme" -- )
  \ Parse "lexeme", find "lexeme", append the compilation semantics
  \ of the found definition to the current definition.
  parse-lexeme-sure ['] find-word execute-compiling ?found ( xt -1|1 )
  swap lit, 1 = if ['] execute-compiling else ['] compile, then compile,
; immediate

: compile-quotation-with ( colon-sys any xt -- colon-sys any )
  [:  [: [c] [: ;] execute-balance n>r  execute  nr> drop [c] ;] ;] execute-compiling
;

: compile-postpone-qtoken ( qt -- )
  qtoken>compile? if ( x xt )
    swap lit, compile, exit
  then ( ut tt )
  0 0 rot ['] execute-parsing ['] compile-quotation-with catch dup 0= if drop
    ['] compile, compile,  exit
  then ( any ior )
  \ remap some throw codes to the code of `-32` "invalid expression"
  >r 0  -16 r@ = or  -39 r@ = or  -22 r@ = or  -29 r@ = or  -32 and throw  r> throw
;

: translate-postpone-qtoken ( qt -- )
  compilation if compile-postpone-qtoken exit then  execute-compiling
;
