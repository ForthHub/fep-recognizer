\ 2024-10-21 ruv

: (string-counted-tmp) ( sd -- c-addr )
  dup here c!  here char+ swap  move  here
;
: find-word ( sd.lexeme -- xt -1 | xt 1 | 0 )
  \ this word is state-dependent in the general case
  (string-counted-tmp) find dup if exit then nip
;


\ ### Assumptions about `find`
\ 1. The first output parameter shall be the same in interpretation state
\    and in compilation state.
\ 2. If `find` on some string (some word) returns `( xt -1 )` in interpretation state,
\    then it shall return on this word the same `( xt -1 )` in compilation state.

\ ### Rationale
\
\ — An implementation is not plausible if `find` for some word returns:
\ ( xt1 -1 ) in interpretation state
\   (which means that "xt1 compile," performs the compilation semantics for the word),
\ and ( xt2 -1 ) in compilation state
\   (which means that "xt2 compile," performs the compilation semantics for the word),
\ where xt2 differs from xt1.
\
\ — An implementation is not plausible if `find` for some word returns:
\ ( xt1 -1 ) in interpretation state
\   (which means that "xt1 compile," performs the compilation semantics for the word),
\ and ( xt2 1 ) in compilation state
\   (which means that "xt2 execute" in compilation state performs the compilation semantics for the word),
\ regardless of whether xt2 differs from xt1 or not.
\
\ — An implementation is not plausible if `find` for some word returns:
\ ( xt1 1 ) in interpretation state
\   (which means that the compilation semantics cannot be inferred from these parameters),
\ and ( xt2 -1 ) in compilation state
\   (which means that "xt2 compile," performs the compilation semantics for the word),
\ regardless of whether xt2 differs from xt1 or not.



\ The dual-xt property of a Forth system can be proven by one example.
\ But to prove the single-xt property, it is necessary to test `find`
\ on all available words (or at least on all standard available words).


\ In this test we test `find` on a few words, which are typically dual-xt in a dual-xt system.
\ If all these words are single-xt, we assume the system is single-xt,
\ otherwise we are confident the system is dual-xt.

: (test-find-dual) ( c-addr -- flag.dual true | false false )
  dup >r ['] find execute-compiling ( xd1 )
  r> over >r ['] find execute-interpreting ( xd1 xd2 )
  dup >r d<>  r> r> or 0<>
;

:noname ( -- flag.dual-xt )
  true
  [ char | parse S"| ] sliteral (string-counted-tmp) (test-find-dual) and if exit then
  c" TO"            (test-find-dual) and if exit then
  c" ACTION-OF"     (test-find-dual) and if exit then
  c" IF"            (test-find-dual) and if exit then
  c" >R"            (test-find-dual) and if exit then
  c" [CHAR]"        (test-find-dual) and if exit then
  drop false
; execute

dup [if] true constant true.system.dual-xt [then]
0= constant flag.system.seems-single-xt