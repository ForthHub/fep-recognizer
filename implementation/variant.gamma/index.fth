
\ Recognizer API
include ./recognizer-api.fth


\ Token translators
include ./token-translator.fth


\ Recognizers
include ./recognizer/index.fth


\ An example of the Forth text interpreter
include ./example.text-translator.fth
\ NB: this file provides some standard words
\ (like `'`, `[']`, `[defined]`, `[undefined]`, etc)
\ and they may shadow the corresponding system's words in forth-wordlist

0 [if] \ example

translate-source-following  2 3 + . cr

[then]
