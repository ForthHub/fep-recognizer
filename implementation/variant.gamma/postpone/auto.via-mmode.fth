\ An implementation for the `postpone` word,
\ which applies to words, numbers, and any other single-lexeme literals.

[undefined] execute-in-mmode [if]
  cr .( \ No mmode support. Consider including "token-compiler.mmode.fth". Abort. ) cr abort
[then]

: compile-postpone-qtoken ( qt -- )
  qtoken>compile? if swap lit, compile, exit then
  0 0 rot ['] execute-parsing \ disallow parsing (if any)
  ['] execute-compiling execute-in-mmode
;

: translate-postpone-qtoken ( qt -- )
  compilation if compile-postpone-qtoken exit then execute-compiling
;
