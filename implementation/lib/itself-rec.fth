\ Creating a named colon definition that can pass itself as a parameter.
\ Whether the definition being defined is findable depends on implementation.
\ Format (syntax):
\     rec: foo ... itself-rec ( xt ) ... ; rec

\ The name "rec" comes from "let rec" in OCaml,
\ see-also: https://stackoverflow.com/questions/9325888/why-does-ocaml-need-both-let-and-let-rec

variable germ-rec-slot  : germ-rec ( -- xt|0 ) germ-rec-slot @ ;  : set-germ-rec ( xt|0 -- ) germ-rec-slot ! ; 0 set-germ-rec
: itself-rec    ( -- ) ( Runtime: S: -- xt ) germ-rec dup if lit, exit then -14 throw ; immediate
: itself-rec,   ( -- ) ( Runtime: S: -- ) ['] itself-rec execute ['] compile, compile, ; immediate

: ;rec ( colon-sys -- ) 0 set-germ-rec [ s" ;" ' find-word execute-compiling drop compile, ] ; immediate

[defined] germ [if] :noname [ germ lit, ] ; dup execute = [else] 0 [then]   [if]
\ `germ` is provided and seems to be correct

: rec: ( "name" -- colon-sys )  :   germ set-germ-rec ;


[else] \ The system does not provide `germ`, so we need to go in a longer way

[defined] latest-name [if]

: rec: ( "name" -- colon-sys )
  defer   ['] :noname execute-balance 1- roll ( xt.new ) dup set-germ-rec  latest-name name>  defer!
;


[else] \ The system does provide neither `germ` nor `latest-name`

include ./defined-with.fth \ this module provides `xt-defined-with`

: rec: ( "name" -- colon-sys )
  ['] defer xt-defined-with >r
  ['] :noname execute-balance 1- roll ( xt.new ) dup set-germ-rec  r> defer!
;

[then] [then]


\ include ./itself-rec.test.fth
