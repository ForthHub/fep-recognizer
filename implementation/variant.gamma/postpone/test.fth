
\ Some testcases for `postpone`

[defined] obtain-postponer  [defined] obtain-postponer?  [defined] bind-postponer  and and [if]
\ Testing "./wide.via-association.fth"
  include ./wide.via-association.test.fth
[then]



t{ : t1.ord 123 ;  : t2.imm 456 ; immediate -> }t

t{ : p.t1.imm postpone t1.ord ; immediate }t
t{ : p.t2.imm postpone t2.imm ; immediate }t

t{ :noname p.t1.imm             ; execute -> 123 }t
t{ :noname p.t2.imm  [ lit, ]   ; execute -> 456 }t

t{ : pp.t1.imm postpone p.t1.imm ; immediate  -> }t
t{ : pp.t1.ord postpone p.t1.imm ;            -> }t

t{ :noname   pp.t1.imm      ; execute -> 123 }t
t{ :noname [ pp.t1.ord ]    ; execute -> 123 }t

t{ :noname            t1.ord    ; execute -> 123 }t
t{ :noname [ postpone t1.ord ]  ; execute -> 123 }t

t{ :noname            t2.imm    [ lit, ] ; 0 swap execute -> 0 456 }t
t{ :noname [ postpone t2.imm ]  [ lit, ] ; 0 swap execute -> 0 456 }t


t{ :noname [ postpone if ]  1 else 2 then ; 0 swap execute -> 2 }t



[defined] tt-word-imm [if]
.( \ Testing `compile-postpone-qtoken` on a token of `tt-word-imm` ) cr
t{ : p.w1 [ ' leave-compilation ' tt-word-imm compile-postpone-qtoken ] ; -> }t
t{ :noname enter-compilation p.w1 compilation 0= leave-compilation ; execute -> true }t
[then]
[defined] tt-word-dual [if]
.( \ Testing `compile-postpone-qtoken` on a token of `tt-word-dual` ) cr
t{ : p.w2 [ ' leave-compilation ' noop  ' tt-word-dual compile-postpone-qtoken ] ; -> }t
t{ :noname enter-compilation p.w2 compilation 0= leave-compilation ; execute -> true }t
[then]
[defined] tt-word-dual-odd [if]
.( \ Testing `compile-postpone-qtoken` on a token of `tt-word-dual-odd` ) cr
t{ : p.w3 [ ' leave-compilation ' noop  ' tt-word-dual-odd compile-postpone-qtoken ] ; -> }t
t{ :noname enter-compilation [ p.w3 ] compilation 0= leave-compilation ; execute -> true }t
[then]



:noname ( -- ior | 0 ) s" :noname postpone 123 ; drop "
  ['] evaluate catch dup if postpone [ nip nip then
; execute [if] .( \ `postpone` does not apply to literals ) cr
[else] .( \ Testing `postpone` on numeric literals ) cr

\ Postponing numbers and strings using `compile-postpone-qtoken`
t{ : p.d1 [ 123 456 ' tt-xd compile-postpone-qtoken ] ; -> }t
t{ :noname [ p.d1 ] ; 0 swap execute -> 0 123 456 }t
t{ : p.s1 [ s" foobar" ' tt-sd compile-postpone-qtoken ] ; -> }t
t{ :noname [ p.s1 ] ; execute s" foobar" equals -> true }t

\ Postponing numeric literals
t{ : p.n1 postpone 123  ;  -> }t
t{ : p.n2.imm postpone 456 ; immediate -> }t
t{ :noname [ postpone 111 p.n1 ] ; 0 swap execute -> 0 111 123 }t
t{ :noname p.n2.imm ; 0 swap execute -> 0 456 }t

[then]
