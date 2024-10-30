
\ Example of implementation `interpret`

[undefined] ?stack [if]
: ?stack ( -- ) depth 0 <   -4 and throw ; \ "stack underflow"
[then]

[undefined] parse-lexeme [if]
: parse-lexeme ( -- sd.lexeme ) parse-name ;
[then]



\ Default recognizer for the Forth text interpreter
\ A polyglot version (i.e., it varies depending on the available recognizers)
: recognize-forth-default ( sd.lexeme -- qt|0 )
  2dup 2>r
  [defined] recognize-name [if] recognize-name [else] recognize-word [then]  dup if 2rdrop exit then drop
  2r@ recognize-number-integer  dup if 2rdrop exit then drop
  [defined] recognize-number-float [if] 2r@ recognize-number-float  dup if 2rdrop exit then drop  [then]
  2rdrop 0
;

' recognize-forth-default set-perceptor


: example.interpret ( i*x -- j*x )
  begin ?stack
    parse-lexeme  dup while translate-lexeme
  repeat 2drop
;

[defined] execute-parsing [if]
: example.evaluate ( i*x sd -- j*x ) ['] example.interpret execute-parsing ;
[then]
