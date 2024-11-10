
[undefined] lit,    [if] : lit,   postpone literal  ; [then]
[undefined] slit,   [if] : slit,  postpone sliteral ; [then]

[undefined] 2lit,   [if]
  [defined] 2literal [if]
    : 2lit,  postpone 2literal ;
  [else]
    : 2lit,  swap lit, lit, ;
  [then]
[then]

[undefined] flit, [defined] flitetral   and [if] : flit, postpone fliteral ; [then]

:noname [ s" ' false compile," ' evaluate catch dup [if] lit, drop [then] drop ] ; execute [if]
  \ define interpretation semantics for `compile,`
  : compile, compile, ;
[then]
