
[undefined] noop [if] : noop ; immediate [then]

[undefined] 1+  [if]  : 1+  1 + ; [then]
[undefined] 1-  [if]  : 1-  1 - ; [then]

[undefined] char+ [if]  : char+ 1 chars + ; [then]
[undefined] char- [if]  : char- 1 chars - ; [then]

[undefined] 0!  [if]  : 0!  ( a-addr -- )  0 swap  ! ; [then]
[undefined] 1+! [if]  : 1+! ( a-addr -- )  1 swap +! ;  [then]
[undefined] 1-! [if]  : 1-! ( a-addr -- ) -1 swap +! ;  [then]


[undefined] rdrop [if]
  : rdrop ( R.runtime: x -- ) postpone r> postpone drop ; immediate
[then]
[undefined] 2rdrop [if]
  : 2rdrop ( R.runtime: x x -- ) postpone rdrop postpone rdrop ; immediate
[then]

[undefined] ndrop [if]
  : ndrop ( i*x u.i -- ) 0 ?do drop loop ;
[then]
