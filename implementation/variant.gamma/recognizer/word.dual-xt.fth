\ A `find`-based recognizer of Forth words
\ for a dual-xt system (so, `find` is `state`-dependent).
\ This makes sense when `find-name` cannot be provided
\ because the dual-nt approach is used, as in the cmForth system.

\ DataType ( xt tt-xt ) => qt
\ DataType ( xt tt-word-imm ) => qt

\ DataType ( xt.compil xt.interp tt-word-dual ) => qt
\ DataType ( xt.run-time xt.interp tt-word-dual-odd ) => qt
\ DataType ( xt tt-wrong-find ) => qt

\ The word `find-word ( sd.lexeme -- xt -1 | xt 1 | 0 )`
\ is defined in "../../lib/find-word.fth".
\ This word is `state`-dependent in a dual-xt system.

: recognize-word ( sd.lexeme -- 0
    | xt tt-xt
    | xt tt-word-imm
    | xt.compil xt.interp tt-word-dual
    | xt.run-time xt.interp tt-word-dual-odd
    | xt tt-wrong-find
  )
  2dup 2>r ['] find-word execute-interpreting
  dup if  -1 = if 2rdrop ( xt ) ['] tt-xt exit then \ ordinary word
  else drop [: -14 throw ;] then ( xt.interp )
  2r> ['] find-word execute-compiling
  dup 0= if ( xt.interp 0 ) nip exit then \ not found
  ( xt.interp xt.compil -1|1 )
  >r 2dup = if drop ( xt.seems-immed )
    r> 1 = if
      ['] tt-word-imm exit \ immediate word
    then ( xt ) \ incorrect `find`
    [: true abort" bug in `find` ( xt.1 1 ) ( xt.1 -1 )" ;] exit \ tt-wrong-find
  then swap r> 1 = if ( xt.compil xt.interp ) ['] tt-word-dual exit then
  ( xt.run-time xt.interp ) ['] tt-word-dual-odd
;

: recognize-word-xt-ordinary ( sd.lexeme -- xt tt-xt | 0 )
  recognize-word dup ['] tt-xt = if exit then dup 0= if exit then
  dup ['] tt-word-dual = if drop 2drop 0 exit then
  dup ['] tt-word-dual-odd = if drop 2drop 0 exit then
  ( xt tt )
  2drop 0
;
