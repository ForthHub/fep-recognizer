cr .( testing "itself-rec.fth" ) cr

t{ rec: inc-Y ( n -- n xt.inc-Y ) 1+ itself-rec ;  1 inc-Y execute drop -> 3 }t

t{ rec: m-x ( x -- x | ) compilation if lit, itself-rec, then ; -> }t
t{ 123 m-x -> 123 }t
t{ : [m1] 123 m-x ; immediate   [m1] -> 123 }t
t{ : [m2] [m1] ; immediate      [m2] -> 123 }t
t{ : [m3] [m2] ; immediate      [m3] -> 123 }t


\ Note that the following might not work depending on the implementation:
\ t{ rec: fac ( u -- u.fac ) dup 0= if drop 1 exit then  dup 1- fac * ;  5 fac -> 120 }t
