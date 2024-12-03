\ Little-known words


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


[undefined] extract-lexeme [undefined] extract-lexeme-sure  or [if]
: extract-lexeme ( -- sd.lexeme | 0 0 )
  begin parse-lexeme dup if exit then 2drop refill 0= until 0 0
;
: extract-lexeme-sure ( -- sd.lexeme )
  extract-lexeme dup if exit then -39 throw \ "unexpected end of the input source"
;
[then]

[undefined] extract-lexeme-before [if]
: extract-lexeme-before ( sd.lexeme -- sd.lexeme | 0 0 )
  \ if the parsed lexeme is the same as the given lexeme, drop it and return ( 0 0 )
  2>r extract-lexeme-sure 2dup 2r> equals if 2drop 0 0 then
;
[then]


[undefined] execute-balance [if]
: execute-balance ( any xt -- any n.data-stack.change )
  depth 1- >r execute depth r> -
;
[then]

[undefined] execute-balance2 [if]  [defined] fdepth [if]
: execute-balance2 ( any xt -- any n.data-stack.change n.float-stack.change )
  fdepth >r depth 1- >r execute depth r> -  fdepth r> -
;
[then] [then]
