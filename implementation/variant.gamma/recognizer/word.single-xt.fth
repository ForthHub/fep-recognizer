
\ DataType ( xt tt-xt ) => qt
\ DataType ( xt tt-word-imm ) => qt

\ for a single-xt system

: recognize-word ( sd.lexeme -- xt tt-xt | xt tt-word-imm | 0 )
  find-word dup 0= if exit then
  -1 = if ['] tt-xt exit then  ['] tt-word-imm
;

: recognize-word-xt-ordinary ( sd.lexeme -- xt tt-xt | 0 )
  recognize-word dup ['] tt-xt = if exit then dup 0= if exit then
  2drop 0
;
