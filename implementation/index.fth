
include ./lib/search-order.fth \ the word "also-wordlist"

wordlist dup constant scratchpad also-wordlist definitions
\ in "scatchpad"

\ Include libraries

\ load "bracket-if.fth"  if `[if]` is absent or does not work in lower case
s" 0 0 [if] [else] drop -1 [then]" :noname ['] evaluate catch if 2drop 0 then if exit then s" ./lib/bracket-if.fth" included ; execute

include ./lib/compat/well-known-words.fth
include ./lib/string-match.fth
include ./lib/compat/compiler.fth
include ./lib/compat/translator.fth

\ The word `find-word` and a test whether the system is dual-xt
include ./lib/find-word.fth

\ Define a simple version of `synonym` if it is not provided by the system
include ./lib/compat/synonym.fth


\ Include Recognizer API and examples
wordlist dup constant variant.gamma  also-wordlist definitions
\ in "variant.gamma"

include ./variant.gamma.index.fth

\ The search order at this point:  forth scratchpad variant.gamma  \ <-- top
