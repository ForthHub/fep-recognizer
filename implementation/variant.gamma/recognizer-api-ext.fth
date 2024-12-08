\ Common helper words

: apply-perceptor ( any xt xt.recognizer -- any )
  \ Save the perceptor, assign xt.recognizer to the perceptor,
  \ execute xt, restore the perceptor.
  perceptor >r set-perceptor  catch  r> set-perceptor  throw
;
: execute-in-perceptor ( any xt.recognizer xt -- any )
  \ Save the perceptor, assign xt.recognizer to the perceptor,
  \ execute xt, restore the perceptor.
  swap apply-perceptor
;

