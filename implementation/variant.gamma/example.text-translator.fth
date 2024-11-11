
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


: translate-source-following ( i*x -- j*x )
  \ Also known as `interpret`
  begin ?stack
    parse-lexeme  dup while translate-lexeme
  repeat 2drop
;

[defined] execute-parsing [if]
: example.evaluate ( i*x sd -- j*x ) ['] translate-source-following execute-parsing ;
[then]

0 [if] \ example
translate-source-following  2 3 + . cr
s" 2 3 + . cr" example.evaluate
[then]



\ Implement the words `'` and `[']` using Recognizer API
\ These words shall perceive the lexeme instead of simply trying to find it in the search order.

: ' ( "<name>"-- xt )
  parse-lexeme-sure perceive qtoken>xt
;
: ['] ( "<name>"-- xt | )
  parse-lexeme-sure perceive qtoken>xt tt-x
; immediate
