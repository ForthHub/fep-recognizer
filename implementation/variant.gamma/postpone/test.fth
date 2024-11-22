
\ Some testcases for `postpone`


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
