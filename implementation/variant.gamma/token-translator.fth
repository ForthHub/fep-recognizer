
: tt-x    ( comp: true ; x1 --  ; | comp: false ;  x1 -- x1   )   compilation if lit,     then ;
: tt-xd   ( comp: true ; xd1 -- ; | comp: false ; xd1 -- xd1  )   compilation if 2lit,    then ;
[defined] flit, [if]
: tt-r    ( comp: true ; F: r1 -- ; | comp: false ; F: r1 -- r1 ) compilation if flit,    then ;
[then]
: tt-sd   ( comp: true ; sd -- ; | comp: false ; sd -- sd  )      compilation if slit,    else string-copy-if-source then ;

: tt-xt   ( comp: true ; xt -- ; | comp: false ; any xt -- any )  compilation if compile, else execute then ;

: tt-nt   ( any nt -- any )  compilation if name>compile else name> then execute ;


: tt-word-imm ( any xt -- any ) execute ;

: tt-word-dual ( any xt.compil xt.interp -- any )
  compilation if drop else nip then execute
;
: tt-word-dual-odd ( any xt.run-time xt.interp -- any )
  compilation if drop compile, else nip execute then
;


: qtoken>xt? ( qt -- xt true  |  qt -- qt false  |  0 -- 0 false )
  \ Obtain the execution token of the definition from a qualified token if possible.
  case
    ['] tt-nt             of  name> endof
    ['] tt-xt             of  endof
    ['] tt-word-imm       of  endof
    ['] tt-word-dual      of  nip endof
    ['] tt-word-dual-odd  of  nip endof
    false exit
  endcase true
;
: qtoken>xt ( 0|qt -- xt )
  \ Try to obtain the execution token of the definition from a qualified token,
  \ throw an exception if an execution token cannot be obtained.
  ?found qtoken>xt? if exit then  -32 throw \ "invalid name argument"
;

