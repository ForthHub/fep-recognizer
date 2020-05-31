### XY.2 Additional terms and notations

**lexeme**: a syntactic unit of a _program_ (a Forth source code); (unless otherwise noted, it is a sequence of non-blank characters delimited by a blank).

to **translate** a _lexeme_: to perform the _compilation semantics_ or the _interpretation semantics_ for the _lexeme_.

**dynamic context** of a _lexeme_: information that is available at the time the _lexeme_ is _translated_.

**token**:  a tuple of _data objects_ that represents a _lexeme_ in its _dynamic context_ (see also _data type_ and [3.1 Data types](https://forth-standard.org/standard/usage#table:datatypes)).

to **translate** a _token_:  to produce an effect of _translating_ the _lexeme_ which this _token_ represents, in some mix of the _dynamic context_ of this _lexeme_ and the current _dynamic context_.

**token descriptor**: an _implementation dependent_ _data object_  (a set of information) that describes _translating_ a _token_; also a value that identifies this _data object_.

to **recognize** a _lexeme_: to produce a _token_ and its _token descriptor_ for given _lexeme_ in the current _dynamic context_.

**recognizer**: a _Forth definition_ that recognizes a _lexeme_.

**simple recognizer**: a recognizer that may produce _tokens_ with some the same _token descriptor_ only.

**compound recognizer**: a recognizer that can produce _tokens_ with the different _token descriptors_ .


### XY.3.1 Data types

**Token descriptor identifiers** are implementation-dependent single-cell values that identify _token descriptors_.

Extension to the table 3.1

Symbol | Data type | Size on stack
-- | -- | --
tdi | token descriptor identifier | 1 cell

