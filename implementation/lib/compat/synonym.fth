[undefined] synonym [if]
\ Define a simple version of `synonym` (on a single-xt system only).
\ The words `to`, `is`, `action-of` cannot be applied to a word created with this `synonym`
\ and `>body` cannot be applied to the xt of the word created with this `synonym`  (this is checked).

[undefined] find-word  [undefined] flag.system.seems-single-xt  or [if]
  .( [error "find-word.fth" shall be included earlier. Abort.] ) cr abort
[then]
[defined] true.system.dual-xt [if]
  .( [error `synonym` is missed and won't be defined on a dual-xt system. Abort.] ) cr abort
[then]

.( [warning `synonym` is missed, a simplified version is defined] ) cr

\ An additional boolean attribute to an xt - whether it's for a synonym
variable _list-of-synonyms 0 _list-of-synonyms !
: of-synonym ( xt -- flag ) _list-of-synonyms swap begin ( addr xt ) swap @ dup while ( xt addr ) tuck cell+ @ over = until true then nip ;
: settle-of-synonym ( xt -- ) align here _list-of-synonyms @ , _list-of-synonyms ! , ;


: (?notsynonym) ( "<name>" -- "<name>" )
  >in @ >r  '  r> >in ! ( xt )
  of-synonym abort" cannot be applied to a synonym"
;
[defined] to [if]
: to ( any "<name>" -- any )
  (?notsynonym) [ ' to compile, ]
; immediate
[then]
[defined] is [if]
: is ( any "<name>" -- any )
  (?notsynonym) [ ' is compile, ]
; immediate
[then]
[defined] action-of [if]
: action-of ( any "<name>" -- any )
  (?notsynonym) [ ' action-of compile, ]
; immediate
[then]

: >body ( xt -- a-addr.body ) dup of-synonym abort" `>body` cannot be used for a synonym" >body ;

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
