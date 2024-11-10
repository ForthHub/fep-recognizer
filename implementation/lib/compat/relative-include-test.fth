\ This file is used to test whether the system supports "include" by a relative file name
( -- flag )

\ test the path relative to the current directory (just for possible warning)
s" lib/compat/relative-include-true.fth" ' included catch [if] 2drop
  .( [warning it seems `included` cannot load a file relative to the current directory] ) cr
[else] ( S: true ) drop [then]

\ test the path relative to the base-uri
s" ./relative-include-true.fth" ' included catch [if] 2drop
  false \ it does not work
[else] \ it works
  ( S: true )
[then]
