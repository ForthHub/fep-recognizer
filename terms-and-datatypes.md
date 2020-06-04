### XY.2 Additional terms and notations

**lexeme**: a syntactic unit of a _program_ (a Forth source code); (unless otherwise noted, it is a sequence of non-blank characters delimited by a blank).

to **interpret** a _lexeme_: to determine the _interpretation semantics_ for the _lexeme_ in the current dynamic context and perform them.

to **compile** a _lexeme_: to determine the _compilation semantics_ for the _lexeme_ in the current dynamic context and perform them.

to **translate** a _lexeme_: to _compile_ or to _interpret_ the _lexeme_.

**dynamic context** of a _lexeme_: information that is available at the time the _lexeme_ is _translated_.

**token**: a tuple of _data objects_ that determines the _interpretation semantics_ and the _compilation semantics_ for a _lexeme_ in its _dynamic context_.

to **translate** a _token_: to perform the _interpretation semantics_ or the _complication semantics_ that are determined by the token.

**token descriptor**: an _implementation dependent_ _data object_ (a set of information) that describes _translating_ a _token_; also less formally and depending on context, a value that identifies this _data object_ or a Forth definition that just returns this value.

to **recognize** a _lexeme_: to produce a _token_ and its _token descriptor_ for given _lexeme_ in the current _dynamic context_.

**recognizer**: a _Forth definition_ that recognizes a _lexeme_.

**simple recognizer**: a _recognizer_ that may produce _tokens_ with some the same _token descriptor_ only.

**compound recognizer**: a _recognizer_ that can produce _tokens_ with the different _token descriptors_.

**current recognizer**: a _recognizer_ that is currently used by the text interpreter to translate a _lexeme_.


### XY.3.1 Data types

**Token descriptor identifiers** are implementation-dependent single-cell values that identify _token descriptors_.

Extension to the table 3.1

Symbol | Data type | Size on stack
-- | -- | --
tdi | token descriptor identifier | 1 cell

