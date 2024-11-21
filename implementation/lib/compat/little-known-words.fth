\ Little-known words

[undefined] name> [if]  [defined] name>interpret [if]
: name> ( nt -- xt ) name>interpret ?dup if exit then [: -14 throw ;] ;
[then] [then]


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
