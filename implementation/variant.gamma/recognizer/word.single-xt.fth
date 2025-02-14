\ A `find`-based recognizer of Forth words
\ for a single-xt system (so, `find` is `state`-independent).
\ This makes sense when `find-name` is not provided.
\ Otherwise, see `recognize-name` in "./name.fth".

\ DataType ( xt tt-xt ) => qt
\ DataType ( xt tt-word-imm ) => qt

\ The word `find-word ( sd.lexeme -- xt -1 | xt 1 | 0 )`
\ is defined in "../../lib/find-word.fth".
\ This word is `state`-independent in a single-xt system.

: recognize-word ( sd.lexeme -- xt tt-xt | xt tt-word-imm | 0 )
  find-word dup 0= if exit then
  -1 = if ['] tt-xt exit then  ['] tt-word-imm
;

: recognize-word-xt-ordinary ( sd.lexeme -- xt tt-xt | 0 )
  recognize-word dup ['] tt-xt = if exit then dup 0= if exit then
  2drop 0
;
