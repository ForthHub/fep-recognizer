\ An implementation for the `postpone` word
\ which applies to words, numbers, and possibly other lexemes.


\ We use a dynamic associative array of tt keys with xt.postponer values
variable _list-of-postponers 0 _list-of-postponers !
: bind-postponer ( xt.postponer tt -- ) align here _list-of-postponers @ , _list-of-postponers ! , , ;
: obtain-postponer ( tt -- xt.postponer|0 )
  >r _list-of-postponers begin ( addr ) @ dup while ( addr ) dup cell+ @ r@ = until cell+ cell+ @ then rdrop
;
: obtain-postponer? ( tt -- tt false | xt.postponer true )
  dup obtain-postponer ( tt 0 | tt xt )
  dup if nip true then
;


\ The following definitions can be anonymous. In this implementation they are named.
: pt-nt ( nt -- ) lit,  [: name>compile execute-compiling ;] compile, ; ' pt-nt ' tt-nt bind-postponer
: pt-xt ( xt -- ) lit,  ['] compile,  compile, ; ' pt-xt  ' tt-xt bind-postponer
: pt-x  ( x --  ) lit,  ['] lit,      compile, ; ' pt-x   ' tt-x  bind-postponer
: pt-xd ( xd -- ) 2lit, ['] 2lit,     compile, ; ' pt-xd  ' tt-xd bind-postponer
: pt-sd ( sd -- ) slit, ['] 2lit,     compile, ; ' pt-sd  ' tt-sd bind-postponer
[defined] flit, [if]
: pt-r ( F: r -- ) flit, ['] flit,     compile, ; ' pt-r ' tt-r bind-postponer
[then]
: pt-word-imm           ( xt --     )   lit, ['] execute-compiling compile, ; ' pt-word-imm       ' tt-word-imm       bind-postponer
: pt-word-dual          ( xt xt --  )   drop pt-word-imm                    ; ' pt-word-dual      ' tt-word-dual      bind-postponer
: pt-word-dual-odd      ( xt xt --  )   drop pt-xt                          ; ' pt-word-dual-odd  ' tt-word-dual-odd  bind-postponer



: compile-postpone-qtoken ( qt -- )
  obtain-postponer? if execute exit then -32 throw \ "invalid name argument"
;

: translate-postpone-qtoken ( qt -- )
  compilation if compile-postpone-qtoken exit then
  dup obtain-postponer if execute-compiling exit then
  -32 throw \ "invalid name argument"
;

