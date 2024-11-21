
t{ 0 0 ' drop ' false apply-recognizer-filter -> 0 }t
t{ 0 0 ' drop ' true  apply-recognizer-filter -> 0 }t
t{ 0 0 ' true ' false apply-recognizer-filter -> 0 }t
t{ 0 0 ' true ' true  apply-recognizer-filter -> 0 0 true }t
t{ 1 2 :noname 3 ; ' true  apply-recognizer-filter -> 1 2 3 }t
t{ 1 2 :noname 3 4 5 ; ' false  apply-recognizer-filter -> 0 }t
t{ 1 2 :noname 3 4 ; :noname 2nip true ;  apply-recognizer-filter -> 3 4 }t

t{ s" 123"  ' recognize-number-integer ' false                  apply-recognizer-filter -> 0 }t
t{ s" 123"  ' recognize-number-integer [: dup ['] tt-x = ;]     apply-recognizer-filter -> 123 ' tt-x }t
t{ s" 123." ' recognize-number-integer [: dup ['] tt-x = ;]     apply-recognizer-filter -> 0 }t

