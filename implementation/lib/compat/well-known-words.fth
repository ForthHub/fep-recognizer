
[undefined] noop [if] : noop ; immediate [then]

[undefined] 1+  [if]  : 1+  1 + ; [then]
[undefined] 1-  [if]  : 1-  1 - ; [then]

[undefined] char+ [if]  : char+ 1 chars + ; [then]
[undefined] char- [if]  : char- 1 chars - ; [then]

[undefined] 0!  [if]  : 0!  ( a-addr -- )  0 swap  ! ; [then]
[undefined] 1+! [if]  : 1+! ( a-addr -- )  1 swap +! ;  [then]
[undefined] 1-! [if]  : 1-! ( a-addr -- ) -1 swap +! ;  [then]


[undefined] d= [if]
  : d= ( xd xd -- flag.equal ) rot = rot rot = and ;
[then]
[undefined] d<> [if]
  : d<> ( xd xd -- flag.not-equal ) d= 0= ;
[then]

[undefined] rdrop [if]
  : rdrop ( R.runtime: x -- ) postpone r> postpone drop ; immediate
[then]
[undefined] 2rdrop [if]
  : 2rdrop ( R.runtime: x x -- ) postpone rdrop postpone rdrop ; immediate
[then]

[undefined] ndrop [if]
  : ndrop ( i*x u.i -- ) 0 ?do drop loop ;
[then]


[undefined] parse-lexeme [if]
[defined] synonym [if]
  synonym parse-lexeme parse-name
[else]
  : parse-lexeme parse-name ;
[then]
[then]
