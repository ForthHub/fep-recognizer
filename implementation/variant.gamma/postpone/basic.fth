\ An implementation for the Forth-2012 word `postpone`,
\ which applies to Forth words only.

: qtoken>compile? ( qt -- xt|nt xt.compiler true  |  qt -- qt false  |  0 -- 0 false )
  case
    ['] tt-nt             of  [: name>compile execute-compiling ;] endof
    ['] tt-xt             of  ['] compile, endof
    ['] tt-word-imm       of  ['] execute-compiling endof
    ['] tt-word-dual      of  drop ['] execute-compiling endof
    ['] tt-word-dual-odd  of  drop ['] compile, endof
    false exit
  endcase true
;

: compile-postpone-qtoken ( qt -- )
  qtoken>compile? if swap lit, compile, exit then -32 throw \ "invalid name argument"
;

: translate-postpone-qtoken ( qt -- )
  compilation if compile-postpone-qtoken exit then
  qtoken>compile? if execute exit then
  -32 throw \ "invalid name argument"
;

