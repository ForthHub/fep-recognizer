
\ Testing associatation of postponers and token translators
.( \ Testing `obtain-postponer` and `bind-postponer` ) cr

t{ 0 obtain-postponer -> 0 }t
t{ 0 obtain-postponer? -> 0 false }t
t{ here obtain-postponer -> 0 }t
t{ here obtain-postponer? -> here false }t
t{ ' noop obtain-postponer -> 0 }t
t{ ' noop ' noop bind-postponer -> }t
t{ ' noop obtain-postponer -> ' noop }t
t{ ' noop obtain-postponer? -> ' noop true }t
