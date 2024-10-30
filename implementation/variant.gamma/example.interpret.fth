
\ Example of implementation `interpret`

[undefined] ?stack [if]
: ?stack ( -- ) depth 0 <   -4 and throw ; \ "stack underflow"
[then]

[undefined] parse-lexeme [if]
: parse-lexeme ( -- sd.lexeme ) parse-name ;
[then]


: example.interpret ( i*x -- j*x )
  begin ?stack
    parse-lexeme  dup while translate-lexeme
  repeat 2drop
;

[defined] execute-parsing [if]
: example.evaluate ( i*x sd -- j*x ) ['] example.interpret execute-parsing ;
[then]
