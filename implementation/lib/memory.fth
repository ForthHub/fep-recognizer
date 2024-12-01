
: string-copy ( sd1 -- sd2 )
  \ Make a copy of a character string in dynamic memory;
  \ the returned character string is null-terminated.
  dup >r char+ allocate throw tuck ( a-addr.2 c-addr.1 a-addr.2 )
  r@ move  dup r@ + 0 swap c!  r>
;

: string-copy-if-source ( sd1 -- sd1 | sd2 )
  \ If the character string sd1 is not empty and within the input buffer
  \ return its copy sd2.
  dup if over source over + within if string-copy then then
;
