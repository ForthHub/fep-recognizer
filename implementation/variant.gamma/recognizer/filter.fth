\ Execute a recognizer and apply a filter to resulting qualified token qt,
\ discard qt if the filter returns 0.

[defined] execute-balance2 [if] \ take into account both the data stack and floating point stack
: apply-recognizer-filter ( sd.lexeme recognizer xt.filter -- any x\0  | 0 )
  \ xt.filter ( qt1 -- qt1 0 | any x\0 x\0 )
  >r execute-balance2 ( qt|0  n.data-stack.change n.float-stack.change )
  2 pick 0= if 2drop rdrop exit then ( R: xt.filter )
  r>  swap >r swap >r  execute if 2rdrop exit then
  r> 2 + ndrop  r> nfdrop  0
;
[else] \ no floating point stack, take into account only the data stack
: apply-recognizer-filter ( sd.lexeme recognizer xt.filter -- any x\0  | 0 )
  \ xt.filter ( qt1 -- qt1 0 | any x\0 x\0 )
  >r execute-balance ( qt|0  n.data-stack.change )
  over 0= if drop rdrop exit then ( R: xt.filter )
  r>  swap >r  execute if rdrop exit then
  r> 2 + ndrop  0
;
[then]
