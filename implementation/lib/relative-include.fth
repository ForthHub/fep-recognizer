\ Loading a file with its path relative to the file being loaded

\ The path "./" references the directory of the file being loaded.
\ The path "./../" references the parent directory of the directory of the file being loaded.
\ This is handled in `included` (as well as `include`, `required`, `require`)
\ NB: the path "../" is not treated specially; it normally refers to the parent directory
\ of the working directory of the process.

\ TODO: make path normalization by eliminating multiple "../" #maybe

wordlist dup constant module-base-uri
dup also-wordlist exch-current ( wid.compilation.previous )

: path-directory ( sd.path -- sd.directory )
  \ sd.directory either ends with "/", or has zero length
  over + begin 2dup u< while
    char- dup c@ '/' =
  until char+ then
  over -
;

: s, ( sd -- ) here swap dup allot move ;
: s,copy ( sd -- sd ) here >r dup >r s, 2r> ;

0 value v_base \ the address of two slots, each of xd

: base-uri-directory ( -- sd.uri | 0 0 )
  v_base dup if 2@ exit then 0
;
: base-uri ( -- sd.uri | 0 0 )
  v_base dup if cell+ cell+ 2@ exit then 0
;
: push-base-uri ( sd.uri -- )
  s" ./" match-head drop \ the base uri cannot be relative to the file being loaded
  align v_base , here to v_base
  2dup path-directory 2, 2,
;
: pop-base-uri ( -- sd.uri )
  v_base if base-uri v_base cell- @ to v_base exit then
  true abort" pop-base-uri: nothing to pop"
;
: drop-base-uri ( -- )
  pop-base-uri 2drop
;

: concat-rev ( sd.right sd.left -- sd.result )
  here >r s, s, r> here over -  0 c,
;
: expand-uri ( sd.uri -- sd.uri-expanded )
  base-uri-directory concat-rev
  \ 2dup ." (filename-expanded "  type ." )" cr
;
: expand-uri-maybe ( sd.uri -- sd.uri-expanded )
  base-uri-directory nip 0= if exit then
  s" ./" match-head if expand-uri exit then
;

: execute-with-expanded-uri ( i*x sd.uri xt -- j*x )
  \ xt ( i*x sd.uri-expanded -- j*x )
  >r expand-uri-maybe
  2dup push-base-uri
  r>  catch
  drop-base-uri
  throw
;

\ - testing
\ include ./relative-include.test.fth


( wid.compilation.previous ) exch-current ( wid.module-base-uri )
\ Export

synonym source-base-uri base-uri
synonym source-base-uri-directory base-uri-directory

: included ( any sd.uri -- any ) ['] included execute-with-expanded-uri ;
: include  parse-lexeme included ;

[defined] required [if]
: required ( any sd.uri -- any ) ['] required execute-with-expanded-uri ;
: require  parse-lexeme required ;
[then]

[defined] required-word [if]
: required-word ( i*x sd.word sd.filename -- j*x )  execute-with-expanded-uri ;
: require-word  parse-lexeme parse-lexeme required-word ;
[then]


( wid.module-base-uri ) drop previous \ end of "module-base-uri" scope
