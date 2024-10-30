
[undefined] lit,    [if] : lit,   postpone literal  ; [then]
[undefined] slit,   [if] : slit,  postpone sliteral ; [then]

[undefined] 2lit,   [if]
  [defined] 2literal [if]
    : 2lit,  postpone 2literal ; [then]
  [else]
    : 2lit,  swap lit, lit, ;
  [then]
[then]

[undefined] flit, [defined] flitetral   and [if] : flit, postpone fliteral ; [then]
