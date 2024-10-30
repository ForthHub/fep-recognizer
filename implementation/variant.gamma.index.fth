
\ The word `find-word` and a test whether the system is dual-xt
include ./variant.gamma/find-word.fth

\ Token translators
include ./variant.gamma/translator.fth


\ Recognizers

\ Recognize a word name using `find`
[defined] true.system.dual-xt [if]
  cr .( \ variant.gamma, double-xt ) cr
  include ./variant.gamma/recognizer/word.dual-xt.fth
[else]
  cr .( \ variant.gamma, assuming single-xt ) cr
  include ./variant.gamma/recognizer/word.single-xt.fth
[then]

\ Recognize a word name using `find-name`
[defined] find-name [if]
  include ./variant.gamma/recognizer/name.fth
[then]

\ Recognize numbers in different formats
include ./variant.gamma/recognizer/number.fth

\ Recognizer API
include ./variant.gamma/recognizer-api.fth


\ Default recognizer for the Forth text interpreter
: recognize-forth-default ( sd.lexeme -- qt|0 )
  2dup 2>r
  [defined] recognize-name [if] recognize-name [else] recognize-word [then]  dup if 2rdrop exit then drop
  2r@ recognize-number-integer  dup if 2rdrop exit then drop
  [defined] recognize-number-float [if] 2r@ recognize-number-float  dup if 2rdrop exit then drop  [then]
  2rdrop 0
;

' recognize-forth-default set-perceptor


\ An example of the Forth text interpreter
include ./variant.gamma/example.interpret.fth

0 [if] \ example

example.interpret 2 3 + . cr

[then]
