
\ Recognizer API
include ./recognizer-api.fth


\ Token compilers
include ./token-compiler.mmode.fth

\ Token translators
include ./token-translator.fth


\ Recognizers
include ./recognizer/index.fth


\ An example of the Forth text interpreter
include ./example.text-translator.fth
\ NB: this file provides some standard words
\ and they may shadow the corresponding system's words in `forth-wordlist`.
\ Namely, it provides implementations for the following standard words:
\   `'` (Tick)
\   `[']` (BracketTick)
\   `[defined]`
\   `[undefined]`
\   `postpone`
\   `is`
\   `action-of`
\
\ Cannot redefine:
\   `synonym`
\   `to`

0 [if] \ example

translate-source-following  2 3 + . cr

[then]
