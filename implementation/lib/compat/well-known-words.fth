
[undefined] noop [if] : noop ; immediate [then]

[undefined] 1+  [if]  : 1+  1 + ; [then]
[undefined] 1-  [if]  : 1-  1 - ; [then]

[undefined] 0!  [if]  : 0!  ( a-addr -- )  0 swap  ! ; [then]
[undefined] 1+! [if]  : 1+! ( a-addr -- )  1 swap +! ;  [then]
[undefined] 1-! [if]  : 1-! ( a-addr -- ) -1 swap +! ;  [then]
[undefined] char+ [if]  : char+ ( c-addr -- c-addr ) 1 chars + ;  [then]
[undefined] char- [if]  : char- ( c-addr -- c-addr ) 1 chars - ;  [then]



[undefined] d= [if]  [defined] d- [if]
  : d= ( xd xd -- flag.equal ) d- 0= ;
[else]
  : d= ( xd xd -- flag.equal ) rot = rot rot = and ;
[then] [then]
[undefined] d<> [if]
  : d<> ( xd xd -- flag.not-equal ) d= 0= ;
[then]
[undefined] 2, [if]
  : 2, ( x x -- ) , , ;
[then]

[undefined] rdrop [if]
  : rdrop ( R.runtime: x -- ) postpone r> postpone drop ; immediate
[then]
[undefined] 2rdrop [if]
  : 2rdrop ( R.runtime: x x -- ) postpone rdrop postpone rdrop ; immediate
[then]

[undefined] ndrop [if]
  : ndrop ( +n.cnt*x +n.cnt -- ) 0 ?do drop loop ;
[then]

[undefined] nfdrop [if]  [defined] fdrop [if]
  : nfdrop ( +n.cnt -- ; F: +n.cnt*r -- ) 0 ?do fdrop loop ;
[then] [then]


[undefined] name> [if]
[defined] name>xt [if]
: name> ( nt -- xt ) name>xt ;
[else] [defined] name>interpret [if]
: name> ( nt -- xt ) name>interpret dup if exit then drop [: -14 throw ;] ;
[then] [then]
[then]
