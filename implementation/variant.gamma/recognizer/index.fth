\ Recognize numbers in different formats
include ./number.fth

\ Recognize a word name using `find`
[defined] true.system.dual-xt [if]
  cr .( \ variant.gamma, double-xt ) cr
  include ./word.dual-xt.fth
[else]
  cr .( \ variant.gamma, assuming single-xt ) cr
  include ./word.single-xt.fth
[then]

\ Recognize a word name using `find-name`
[defined] find-name [if]
  include ./name.fth
[then]

include ./filter.fth

\ for testing all recognizers at once:
\ include ./index.test.fth
