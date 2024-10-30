
t{ 0 0 recognize-number-ud -> 0 }t
t{ s" 0" recognize-number-ud -> 0 0  ' tt-xd  }t
t{ s" 1" recognize-number-ud -> 1 0 ' tt-xd  }t
t{ s" -1" recognize-number-ud -> 0  }t
t{ s" 1." recognize-number-ud -> 0  }t
t{ 0 0 recognize-number-d -> 0 }t
t{ s" -1" recognize-number-d -> -1 -1 ' tt-xd  }t
t{ s" -1." recognize-number-d -> 0  }t
t{ 0 0 recognize-number-dot -> 0 }t
t{ s" 1." recognize-number-dot -> 1 0 ' tt-xd  }t
t{ s" -1." recognize-number-dot -> -1 -1 ' tt-xd  }t
t{ s" 1" recognize-number-dot -> 1 ' tt-x  }t
t{ s" -1" recognize-number-dot -> -1 ' tt-x  }t
t{ 0 0 recognize-number-n-prefixed -> 0 }t
t{ s" #1" recognize-number-n-prefixed -> 1 ' tt-x  }t
t{ s" #-1" recognize-number-n-prefixed -> -1 ' tt-x  }t
t{ s" $10" recognize-number-n-prefixed -> 16 ' tt-x  }t
t{ s" $-10" recognize-number-n-prefixed -> -16 ' tt-x  }t
t{ s" %11" recognize-number-n-prefixed -> 3 ' tt-x  }t
t{ 0 0 recognize-number-d-prefixed -> 0 }t
t{ s" #1" recognize-number-d-prefixed -> 1 0 ' tt-xd  }t
t{ s" #-1" recognize-number-d-prefixed -> -1 -1 ' tt-xd  }t
t{ 0 0 recognize-number-character -> 0  }t
t{ s" ''" recognize-number-character -> 0  }t
t{ s" 'A'" recognize-number-character -> 65 ' tt-x  }t
t{ 0 0 recognize-number-integer -> 0  }t
t{ s" 1" recognize-number-integer -> 1 ' tt-x  }t
t{ s" -1" recognize-number-integer -> -1 ' tt-x  }t
t{ s" 1." recognize-number-integer -> 1 0 ' tt-xd  }t
t{ s" -1." recognize-number-integer -> -1 -1 ' tt-xd  }t
t{ s" $10" recognize-number-integer -> 16 ' tt-x  }t
t{ s" $-10" recognize-number-integer -> -16 ' tt-x  }t
t{ s" $10." recognize-number-integer -> 16 0 ' tt-xd  }t
t{ s" $-10." recognize-number-integer -> -16 -1 ' tt-xd  }t
t{ s" 'A'" recognize-number-integer -> 65 ' tt-x  }t


[defined] recognize-number-float [if]
t{ 0 0 recognize-number-float -> 0  }t
\ t{ s" 0" recognize-number-float -> 0 }t
t{ s" 0e" recognize-number-float 0e f= -> ' tt-r true }t
t{ s" -1e" recognize-number-float -1e f= -> ' tt-r true }t
t{ s" -1E" recognize-number-float -1e f= -> ' tt-r true }t
[then]
