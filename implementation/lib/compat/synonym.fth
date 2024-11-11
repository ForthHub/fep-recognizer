[undefined] synonym [if]
\ Define a simple version of `synonym` (on a single-xt system only).
\ The words `to`, `is`, `action-of` cannot be applied to a word created with this `synonym`,
\ and `>body`, `defer@`, `defer!` cannot be applied to the xt of the word created with this `synonym`
\ (all that is checked).

[undefined] find-word  [undefined] flag.system.seems-single-xt  or [if]
  .( [error "find-word.fth" shall be included earlier. Abort.] ) cr abort
[then]
[defined] true.system.dual-xt [if]
  .( [error `synonym` is missed and won't be defined on a dual-xt system. Abort.] ) cr abort
[then]

.( [warning `synonym` is missed, a simplified version is loaded] ) cr

\ An additional boolean attribute to an xt - whether it's for a synonym
variable _list-of-synonyms 0 _list-of-synonyms !
: of-synonym ( xt -- flag ) _list-of-synonyms swap begin ( addr xt ) swap @ dup while ( xt addr ) tuck cell+ @ over = until true then nip ;
: settle-of-synonym ( xt -- ) align here _list-of-synonyms @ , _list-of-synonyms ! , ;


: (?notsynonym) ( "<name>" -- "<name>" )
  >in @ >r  '  r> >in ! ( xt )
  of-synonym abort" cannot be applied to a synonym"
;
: [compile-immed] ( "<name>" -- xt )
  \ NB: this word is intended for single-xt systems only.
  parse-name find-word dup 0= if -13 throw then
  -1 = abort" The word must be immediate"
  compile,
; immediate

[defined] to [if]
: to ( any "<name>" -- any )
  (?notsynonym) [compile-immed] to
; immediate
[then]
[defined] is [if]
: is ( any "<name>" -- any )
  (?notsynonym) [compile-immed] is
; immediate
[then]
[defined] action-of [if]
: action-of ( any "<name>" -- any )
  (?notsynonym) [compile-immed] action-of
; immediate
[then]

\ NB: the words `to`, `is`, `action-of` cannot be ordinary words in a single-xt system.
\ They shall be immediate words. Otherwise they incorrectly apply to a word that is immediate.


: ?notsynonym ( xt -- xt ) dup of-synonym abort" cannot be used for a synonym xt" ;
: >body ( xt -- a-addr.body ) ?notsynonym >body ;
: defer@ ( xt1 -- xt2 ) ?notsynonym defer@ ;
: defer! ( x2 xt1 -- ) ?notsynonym defer! ;

: synonym ( "<name.new>" "<name.old>" -- )
  >in @ parse-lexeme 2>r >in !
  : \ "<name.new>"
  parse-lexeme find-word dup 0= if -13 throw then ( xt -1|1 )
  >r compile,
  postpone ;
  r> 1 = if immediate then
  [defined] latest-name [if]
    2rdrop latest-name name> ( xt )
  [else]
    2r> get-current search-wordlist 0= abort" broken search-wordlist" ( xt )
  [then] ( xt )
  settle-of-synonym
;


[then]
