
\ Some testcases for `postpone`

[defined] obtain-postponer  [defined] obtain-postponer?  [defined] bind-postponer  and and [if]

\ Associatation of postponers and token translators
t{ 0 obtain-postponer -> 0 }t
t{ 0 obtain-postponer? -> 0 false }t
t{ here obtain-postponer -> 0 }t
t{ here obtain-postponer? -> here false }t
t{ ' noop obtain-postponer -> 0 }t
t{ ' noop ' noop bind-postponer -> }t
t{ ' noop obtain-postponer -> ' noop }t
t{ ' noop obtain-postponer? -> ' noop true }t


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
