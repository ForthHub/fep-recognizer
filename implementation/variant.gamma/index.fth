
\ Recognizer API
include ./recognizer-api.fth


\ Token translators
include ./translator.fth


\ Recognizers

\ Recognize numbers in different formats
include ./recognizer/number.fth

\ Recognize a word name using `find`
[defined] true.system.dual-xt [if]
  cr .( \ variant.gamma, double-xt ) cr
  include ./recognizer/word.dual-xt.fth
[else]
  cr .( \ variant.gamma, assuming single-xt ) cr
  include ./recognizer/word.single-xt.fth
[then]

\ Recognize a word name using `find-name`
[defined] find-name [if]
  include ./recognizer/name.fth
[then]


\ An example of the Forth text interpreter
include ./example.interpret.fth

0 [if] \ example

translate-source-following  2 3 + . cr

[then]