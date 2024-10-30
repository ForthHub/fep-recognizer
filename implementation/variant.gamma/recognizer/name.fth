\ Recognize a word name using `find-name`

\ DataType ( xt tt-xt ) => qt
\ DataType ( nt tt-nt ) => qt


: recognize-name ( sd.lexeme -- nt tt-nt | 0 )
  find-name  dup if ['] tt-nt then
;

: recognize-name-xt-ordinary ( sd.lexeme -- xt tt-xt | 0 )
  recognize-name dup 0= if exit then drop ( nt )
  dup name>compile ['] compile, <> if 2drop 0 exit then
  swap name>interpret over = if ['] tt-xt exit then
  drop 0
;
