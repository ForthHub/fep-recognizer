
\ Example of implementation `interpret`

[undefined] ?stack [if]
: ?stack ( -- ) depth 0 <   -4 and throw ; \ "stack underflow"
[then]


: (?return-recognized) \ Run-Time: ( qt -- never ; R: sd -- never  |  0 -- )
  postpone dup postpone if
    postpone 2rdrop postpone exit
  postpone then postpone drop
; immediate


[defined] recognize-name [if]
  synonym recognize-definition recognize-name
[else]
  synonym recognize-definition recognize-word
[then]


\ Default recognizer for the Forth text interpreter
\ A polyglot version (i.e., it varies depending on the available recognizers)
: recognize-forth-default ( sd.lexeme -- qt|0 )
  2>r
  [defined] recognize-local [if]
    2r@ recognize-local (?return-recognized)
  [then]
  2r@ recognize-definition (?return-recognized)
  2r@ recognize-number-integer (?return-recognized)
  [defined] recognize-number-float [if]
    2r@ recognize-number-float (?return-recognized)
  [then]
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

0 [if] \ example
example.interpret 2 3 + . cr
s" 2 3 + . cr" example.evaluate
[then]
