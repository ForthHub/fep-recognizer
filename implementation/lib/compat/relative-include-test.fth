\ This file is used to test whether the system supports "include" by a relative file name
( -- flag )

\ test the path relative to the working directory (just for possible warning)
\ (assuming the working directory is ".../fep-recognizer/implementation/")
s" lib/compat/relative-include-true.fth" 2dup r/o open-file [if] drop 2drop ( skip the test ) [else] close-file throw ' included catch [if] 2drop
  .( [warning `included` cannot load a file by its path relative to the working directory] ) cr
[else] ( S: true ) drop [then] [then]

\ test the path relative to the base-uri
s" ./relative-include-true.fth" ' included catch [if] 2drop
  false \ it does not work
[else] \ it works
  ( S: true )
[then]
