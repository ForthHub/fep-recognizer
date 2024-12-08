.( \ testing "recognize-colorforth-bw.fth" ) cr

[defined] apply-recognizer-cf  [if]

t{ 0 0 ' abort apply-recognizer-cf -> 0 }t
t{ "x" ' abort apply-recognizer-cf -> 0 }t
t{ "[x" ' noop apply-recognizer-cf -rot "x" equals -> '[' true }t
t{ "[x" :noname 2drop false ; apply-recognizer-cf -> 0 }t


synonym rnsc recognize-number-singlecell-colored
t{ 0 0 rnsc -> 0 }t
t{ "[" rnsc -> 0 }t
t{ "[0" rnsc execute -> 0 }t


t{ 0 0 recognize-name-colored -> 0 }t
t{ "[" recognize-name-colored -> 0 }t
t{ 1 "[drop" recognize-name-colored execute -> }t

[then]


t{ 0 0 recognize-colorforth-bw -> 0 }t
t{ s" dup" recognize-colorforth-bw -> 0 }t


[defined] cf-prefix>tt? [if]

t{ s" [dup" recognize-colorforth-bw nip nip -> ' execute-interpreting }t

[then]


t{ : foo, cf( ]1 ]2 ) ;  : bar cf( [foo, _123  ) ; bar -> 1 2 123 }t
t{ :noname cf( _1. _drop _s" foo" ) ; execute s" foo" compare 0=  -> 1 true }t
