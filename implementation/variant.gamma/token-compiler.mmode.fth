\ NB: This file must be included (if any) before the file "token-translator.fth".

[undefined] itself-rec [undefined] rec: and [if]
  include ./../lib/itself-rec.fth
[then]

\ The macro-compilation mode
variable mmode-slot  mmode-slot 0!
: enter-mmode ( -- )  1 mmode-slot ! ;
: leave-mmode ( -- )  0 mmode-slot ! ;
: mmode ( -- 0 | 1 ) mmode-slot @ ;

: execute-in-mmode ( any xt -- any )
  mmode if execute exit then
  enter-mmode  catch  leave-mmode  throw
;


\ Token compilers that take into account the macro-compilation mode.
\ In their names, "ct" stands for "compile token" (a verb).

\ Alternative naming options (as an example, for "ct-xt"): "compile-xt", "compile-tt-xt", "c-tt-xt", "ctt-xt"
\ The choice is to use the shortest options.

rec: ct-xt ( xt -- )   mmode if lit, itself-rec, exit then compile, ;rec
rec: ct-x  ( x --  )   lit,   mmode if itself-rec, then ;rec
rec: ct-xd ( xd -- )   2lit,  mmode if itself-rec, then ;rec
rec: ct-sd ( sd -- )   slit,  mmode if ['] ct-xd compile, then ;rec
[defined] flit, [if]
rec: ct-r  ( F: r -- ) flit,  mmode if itself-rec, then ;rec
[then]

rec: ct-nt              ( any nt -- any )     mmode if lit, itself-rec, exit then name>compile execute-compiling   ;rec
rec: ct-word-imm        ( any xt -- any )     mmode if lit, itself-rec, exit then execute-compiling                ;rec
rec: ct-word-dual       ( any xt xt -- any )  drop ct-word-imm    ;rec
rec: ct-word-dual-odd   ( xt xt -- )          drop ct-xt          ;rec

\ See-also:
\   https://github.com/ruv/forth-on-forth/blob/master/c-state.core.fth


\ Synonyms for the token compilers
synonym compile, ct-xt
synonym lit,  ct-x
synonym 2lit, ct-xd
synonym slit, ct-sd
[defined] ct-r [if]
synonym flit, ct-r
[then]
