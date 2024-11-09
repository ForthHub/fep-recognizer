
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


\ An example of the Forth text interpreter
include ./variant.gamma/example.interpret.fth

0 [if] \ example

example.interpret 2 3 + . cr

[then]
