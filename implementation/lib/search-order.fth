
: also-wordlist ( wid -- )
  >r get-order r> swap 1+ set-order
;

: exch-current ( wid -- wid )
  get-current swap set-current
;
