\ ruv 2007, 2009, 2018, 2024

\ Functions Based on Substring Matching
\
\ Naming convention was taken from the similar XPath functions.
\ String length is calculated in the address units.


\ Check compatibility with regard to work with character units
1 chars 1 <> [if]
  pad 1 chars 1 /string drop pad - 1 <> [if]
    .( Sorry, chars handling in this program is incompatible with the host Forth system. Abort. ) cr
    -21 throw
  [then]
[then]



: equals ( sd sd -- flag )
  dup 3 pick <> if 2drop 2drop false exit then
  compare 0=
;
: contains ( sd sd.substring -- flag )
  search nip nip
;
: substring-after ( sd sd.substring -- sd.after | 0 0 )
  dup >r search if  swap r@ + swap r> - exit then  rdrop 2drop 0 0
;
: substring-before ( sd sd.substring -- sd.before | 0 0 )
  3 pick >r  search  if  drop r> tuck - exit then   rdrop 2drop 0 0
;
: starts-with ( sd sd.head -- flag )
  rot over u< if  2drop drop false exit then
  tuck compare 0=
;
: ends-with ( sd sd.tail -- flag )
  dup >r 2swap dup r@ u< if  2drop 2drop rdrop false exit then
  r@ - + r> compare 0=
;
: match-head ( sd.full sd.head -- sd.tail true | sd.full false )
  2 pick over u< if  2drop false exit then
  dup >r
  3 pick r@ compare if  rdrop false exit then
  swap r@ + swap r> - true
;
: match-tail ( sd.full sd.tail -- sd.head true | sd.full false )
  2 pick over u< if  2drop false exit then
  dup >r
  2over r@ - + r@ compare if  rdrop false exit then
  r> - true
;
: match-char-head ( sd.full char -- sd.tail true | sd.full false )
  over 0= if drop false exit then
  >r over c@  r> <> if false exit then  1 chars /string true
;
: match-char-tail ( sd.full char -- sd.head true | sd.full false )
  over 0= if drop false exit then
  >r 2dup + char- c@  r> <> if false exit then  char- true
;

: split-string ( sd.full sd.separator -- sd.left sd.right | sd.full 0 0 )
  dup >r  3 pick >r  ( R: u.[sd.separator][1] addr.[st.full][2] )
  search 0= if 2rdrop 0 0 exit then ( addr u )
  over r@ - r> swap  2swap r> /string
;
: split-string? ( sd.full sd.separator -- sd.left sd.right true | sd.full false )
  dup >r 3 pick >r      ( R: u.[sd.separator][1] addr.[st.full][2] )
  search 0= if 2rdrop false exit then ( addr u )
  over r@ - r> swap  2swap r> /string  true
;
: split-string-rev? ( sd.full sd.separator -- sd.right sd.left true | sd.full false )
  3 pick >r dup >r      ( R: addr.[st.full][2] u.[sd.separator][1] )
  search 0= if 2rdrop false exit then ( addr u )
  2dup r> /string  2swap drop r@ - r> swap  true
;

