
: (?string-copy) ( sd1 -- sd1 | sd2 )
  over source over + within 0= if exit then
  dup allocate throw over 2swap 3 pick move
;

: tt-x    ( comp: true ; x1 --  ; | comp: false ;  x1 -- x1   )   compilation if lit,     then ;
: tt-xd   ( comp: true ; xd1 -- ; | comp: false ; xd1 -- xd1  )   compilation if 2lit,    then ;
[defined] flit, [if]
: tt-r    ( comp: true ; F: r1 -- ; | comp: false ; F: r1 -- r1 ) compilation if flit,    then ;
[then]
: tt-sd   ( comp: true ; sd -- ; | comp: false ; sd -- sd  )      compilation if slit,    else (?string-copy) then ;

: tt-xt   ( comp: true ; xt -- ; | comp: false ; any xt -- any )  compilation if compile, else execute then ;

: tt-nt   ( any nt -- any )  compilation if name>compile else name> then execute ;


: tt-word-imm ( any xt -- any ) execute ;

: tt-word-dual ( any xt.compil xt.interp -- any )
  compilation if drop else nip then execute
;
: tt-word-dual-odd ( any xt.run-time xt.interp -- any )
  compilation if drop compile, else nip execute then
;
