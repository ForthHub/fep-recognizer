
[undefined] parse-lexeme [if]
[defined] synonym [if]
  synonym parse-lexeme parse-name
[else]
  : parse-lexeme parse-name ;
[then]
[then]

[undefined] parse-lexeme-sure [if]
: parse-lexeme-sure ( "<name>" -- sd.lexeme )
  parse-lexeme dup if exit then  -16 throw \ "attempt to use zero-length string as a name"
;
[then]

