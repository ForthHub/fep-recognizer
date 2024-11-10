t{ s" " over swap path-directory 0= rot rot = and -> true }t
t{ s" abc" path-directory nip -> 0 }t
t{ s" abc/" 2dup path-directory d= -> true }t
t{ s" abc/def" 2dup path-directory 2swap drop 4 d= -> true }t
t{ s" /def" 2dup path-directory 2swap drop 1 d= -> true }t

t{ base-uri -> 0 0 }t
t{ base-uri-directory -> 0 0 }t

s" foobar" s,copy 2constant fn1
t{ fn1 push-base-uri -> }t
t{ base-uri -> fn1 }t
t{ base-uri-directory -> fn1 drop 0 }t
t{ pop-base-uri -> fn1 }t

s" foo/bar" s,copy 2constant fn2
t{ fn2 push-base-uri -> }t
t{ base-uri -> fn2 }t
t{ base-uri-directory s" foo/" equals -> true }t
t{ s" baz" expand-uri s" foo/baz" equals -> true }t
t{ s" baz" expand-uri-maybe s" baz" equals -> true }t
t{ s" ./baz" expand-uri-maybe s" foo/baz" equals -> true }t
t{ s" ./baz" :noname s" foo/baz" equals ; execute-with-expanded-uri -> true }t
t{ pop-base-uri -> fn2 }t

t{ base-uri -> 0 0 }t
t{ base-uri-directory -> 0 0 }t
