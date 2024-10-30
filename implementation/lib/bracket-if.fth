\ This implementation follows the system's case sensitivity mode.

wordlist dup constant bracket-flow-wl get-current swap set-current

: [if]   ( n.level1 -- n.level2 ) 1+ ;
: [else] ( n.level1 -- n.level2 ) dup 1 = if 1- then ;
: [then] ( n.level1 -- n.level2 ) 1- ;

set-current

: [else] ( "ccc" -- )
  1 begin begin parse-name dup while
    bracket-flow-wl search-wordlist if
      execute dup 0= if drop exit then
    then
  repeat 2drop refill 0= until ( n.level )
  -39 throw \ "unexpected end of file"
; immediate

: [then] ( -- ) ; immediate

: [if] ( 0 "ccc" -- | x\0 -- ) 0= if ['] [else] execute then ; immediate
