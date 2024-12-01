\ The word `xt-defined-with` returns xt of the named definition
\ that is created with a specified defining word (a definer).
\ This word expects that the definer parses a single lexeme from the input buffer
\ and uses it as a name for the new definition.
\ This word can be used in a portable program when `latest-name` is not provided.

\ need( execute-parsing )
\ missing( execute-parsing ) throw

\ missing( latest-name-in ) 0= [if]
[defined] latest-name-in [if] \ a simpler implementation for illustration purposes

: xt-defined-with ( any xt.definer "lexeme.name" -- any xt.new )
  get-current latest-name-in >r ( R: nt.old|0 )
  parse-lexeme-sure rot execute-parsing \ this ensures that the definer parses not more than one lexeme
  get-current latest-name-in dup r> = abort" xt-defined-with: a definer has not created a definition"
  name>
;

[else] \ a more complex implementation in absence of `latest-name-in`

: xt-defined-with ( any xt.definer "lexeme.name" -- any xt.new )
  parse-lexeme-sure
  2dup get-current search-wordlist 0= if 0 then >r ( R: xt.old|0 )
  2dup 2>r rot execute-parsing \ this ensures that the definer parses not more than one lexeme
  2r> get-current search-wordlist 0= if 0 then ( xt.new|0 )
  dup r> = abort" xt-defined-with: a definer has not created a definition"
;

[then]
