\ An implementation for the Forth-2012 word `postpone`,
\ which applies to Forth words only.

: compile-postpone-qtoken ( qt -- )
  qtoken>compile? if swap lit, compile, exit then -32 throw \ "invalid name argument"
;

: translate-postpone-qtoken ( qt -- )
  compilation if compile-postpone-qtoken exit then
  qtoken>compile? if execute exit then
  -32 throw \ "invalid name argument"
;

