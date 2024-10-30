
\ DataType (  n|u  tt-x  ) => qt
\ DataType (  d|ud tt-xd ) => qt
\ DataType ( F: r ; S: tt-r ) => qt

\ -- todo:
\ DataType (  n|u  tt-x-overflow  ) => qt
\ DataType (  d|ud tt-xd-overflow ) => qt
\ DataType ( F: r ; S: tt-r-overflow ) => qt


: recognize-number-ud ( sd.lexeme -- ud tt-xd | 0 )
  \ double-cell integer number unsigned plain
  dup 0= if nip exit then
  0 0 2swap >number nip if 2drop 0 exit then  ['] tt-xd
;
: recognize-number-u ( sd.lexeme -- u tt-x | 0 )
  \ single-cell integer number unsigned plain
  recognize-number-ud dup if drop ( x.lo x.hi )
    if ['] tt-x exit then
    drop 0 \ overflow
  then \ unrecognized
;
: recognize-number-d ( sd.lexeme -- d|ud tt-xd | 0 )
  \ double-cell integer number with optional sign
  [char] - match-char-head >r recognize-number-ud
  dup if r> if >r dnegate r> then exit then rdrop
;
: recognize-number-n ( sd.lexeme -- n|u tt-x | 0 )
  \ single-cell integer number with optional sign
  recognize-number-d 0= if 0 exit then ( x.lo x.hi )
  dup 0= swap -1 = or if ['] tt-x exit then
  drop 0 \ overflow
;
: recognize-number-dot ( sd.lexeme -- n|u tt-x | d|ud tt-xd | 0 )
  \ single-cell integer number with optional sign
  \ or double-cell integer number with optional sign and trailing dot
  [char] . match-char-tail if recognize-number-d exit then recognize-number-n
;

: draw-radix ( sd.lexeme -- sd.lexeme 0 | sd.lexeme.tail +n.radix\0 )
  dup 1 u> 0= if 0 exit then
  case over c@
    [char] $ of 16 endof
    [char] # of 10 endof
    [char] % of 2  endof
    drop s" 0x" match-head 16 and exit
  endcase >r 1 /string r>
;
: execute-in-base ( i*x base xt -- j*x )
  base @ >r swap base ! execute r> base !
;
: recognize-number-n-prefixed ( sd -- n|u tt-x | 0 )
  \ single-cell number with a possible prefix and sign
  draw-radix dup if ['] recognize-number-n execute-in-base exit then
  drop recognize-number-n
;
: recognize-number-d-prefixed ( sd -- d|ud tt-xd | 0 )
  \ double-cell number with a possible prefix and sign
  draw-radix dup if ['] recognize-number-d execute-in-base exit then
  drop recognize-number-d
;
: recognize-number-character ( sd -- char tt-x | 0 )
  \ a character in the form 'x'
  dup 3 <> if 2drop 0 exit then \ this does not support Unicode yet
  [char] ' match-char-tail if
  [char] ' match-char-head if
    drop c@ ['] tt-x exit
  then then 2drop 0
;
: recognize-number-integer ( sd -- d|ud tt-xd | n|u|char tt-x | 0 )
  \ single-cell number or double-cell (with a trailing dot) number
  [char] . match-char-tail if recognize-number-d-prefixed exit then
  2dup recognize-number-character dup if 2swap 2drop exit then drop
  recognize-number-n-prefixed
;


[defined] >float [defined] tt-r  and [if]

: recognize-number-float ( sd -- tt-r ; F: -- r  | sd -- 0 )
  \ todo: it should return tt-r-wrong if the base is not 10
  dup 0= if nip exit then  >float if ['] tt-r exit then 0
;

[then]
