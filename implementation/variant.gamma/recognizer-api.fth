
variable (perceptor-slot)

: perceptor       ( -- recognizer )  (perceptor-slot) @ ;
: set-perceptor   ( recognizer -- )  (perceptor-slot) ! ;
: perceive ( sd.lexeme -- qt|0 ) perceptor execute ;

: recognize-nothing ( sd.lexeme -- 0 ) 2drop 0 ;

' recognize-nothing set-perceptor


: ?found ( 0 -- never | x.some\0 -- x.some )
  dup if exit then  -13 throw
;

: translate-lexeme ( i*x sd.lexeme -- j*x )
  perceive ?found execute
;
