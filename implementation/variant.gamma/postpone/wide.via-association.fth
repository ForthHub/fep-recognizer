\ An implementation for the `postpone` word
\ which applies to words, numbers, and possibly other lexemes.
\ This `postpone` is applicable to a kind of lexemes if and only if
\ a postponer is defined and associated with the token translator for this kind of lexemes.


\ We use a dynamic associative array of tt keys with xt.postponer values
variable _list-of-postponers 0 _list-of-postponers !
: latest-postponer-cell ( -- addr ) _list-of-postponers @ dup if cell+ cell+ exit then  true abort" no latest-postponer" ;
: bind-postponer ( xt.postponer tt -- ) align here _list-of-postponers @ , _list-of-postponers ! , , ;
: obtain-postponer ( tt -- xt.postponer|0 )
  >r _list-of-postponers begin ( addr ) @ dup while ( addr ) dup cell+ @ r@ = until cell+ cell+ @ then rdrop
;
: obtain-postponer? ( tt -- tt false | xt.postponer true )
  dup obtain-postponer ( tt 0 | tt xt )
  dup if nip true then
;
: obtain-postponer-sure ( tt -- xt.postponer ) obtain-postponer dup if exit then -21 throw ;


\ A helper for postponers of numberic literals: `[replicate] foo,` is equivalent to `foo, ['] foo, compile,`
: [replicate] ( "lexeme" -- ) '  dup compile, lit, ['] compile, compile, ; immediate

\ A definer for postponers (NB: `latest-name` would be useful to implement that as a decorator instead of a definer)
: postponer-for: ( "lexeme" -- colon-sys ) 0 '   bind-postponer ['] :noname execute-balance 1- roll latest-postponer-cell ! ;

postponer-for: tt-nt ( nt -- )    lit,  [: name>compile execute-compiling ;] compile, ;
postponer-for: tt-xt ( xt -- )    lit,  ['] compile,  compile, ;
postponer-for: tt-sd ( sd -- )    slit, ['] 2lit,     compile, ;
postponer-for: tt-x  ( x --  )    [replicate] lit,  ;
postponer-for: tt-xd ( xd -- )    [replicate] 2lit, ;
[defined] flit, [if]
postponer-for: tt-r  ( F: r -- )  [replicate] flit, ;
[then]
postponer-for: tt-word-imm           ( xt --     )   lit, ['] execute-compiling compile, ;
postponer-for: tt-word-dual          ( xt xt --  )   drop [ ' tt-word-imm   obtain-postponer-sure compile, ] ;
postponer-for: tt-word-dual-odd      ( xt xt --  )   drop [ ' tt-xt         obtain-postponer-sure compile, ] ;



: compile-postpone-qtoken ( qt -- )
  obtain-postponer? if execute exit then -32 throw \ "invalid expression"
;

: translate-postpone-qtoken ( qt -- )
  compilation if compile-postpone-qtoken exit then
  dup obtain-postponer if execute-compiling exit then
  -32 throw \ "invalid expression"
;

