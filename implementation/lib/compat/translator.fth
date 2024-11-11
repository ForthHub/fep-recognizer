\ Translation in specific state,
\ or compilation and interpretation regardless of the initial state.

[undefined] enter-compilation  [undefined] leave-compilation  [undefined] compilation  or or  [if]

: compilation ( comp: true ; S: -- true ; | comp: false ; S: -- false ; )  state @ 0<> ;
: enter-compilation ( comp: false -- true ; -- ; | comp: true  ; -- ; )  ] ;
: leave-compilation ( comp: true -- false ; -- ; | comp: false ; -- ; )  postpone [ ;

[then]


[undefined] execute-interpreting [if]

: execute-interpreting ( i*x xt -- j*x )
  compilation 0= if execute exit then
  leave-compilation execute enter-compilation
;
[then]

[undefined] execute-compiling [if]

: execute-compiling ( i*x xt -- j*x )
  compilation if execute exit then
  enter-compilation execute leave-compilation
;
[then]
