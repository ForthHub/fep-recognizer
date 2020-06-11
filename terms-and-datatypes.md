## XY.2 Additional terms and notations

(NB: perhaps some terms are unnecessary)

**lexeme**: a syntactic unit of a _program_ (a Forth source code); (unless otherwise noted, it is a sequence of non-blank characters delimited by a blank).

to **recognize** a _lexeme_: to determine the _interpretation semantics_ and the _compilation semantics_ for the _lexeme_ in the current dynamic context.

to **interpret** a _lexeme_: to perform the _interpretation semantics_ for the _lexeme_ in the current dynamic context.

to **compile** a _lexeme_: to perform the _compilation semantics_ for the _lexeme_ in the current dynamic context.

to **translate** a _lexeme_: to _interpret_ the _lexeme_ if interpreting, or to _compile_ the _lexeme_ if compiling.

**dynamic context** of a _lexeme_: information that is available at the time the _lexeme_ is _translated_.

**token**: a tuple of _data objects_ that determines the _interpretation semantics_ and the _compilation semantics_ for a _lexeme_ in its _dynamic context_.

to **interpret** a _token_: to perform the _interpretation semantics_ that are determined by the token.

to **compile** a _token_: to perform the _compilation semantics_ that are determined by the token.

to **translate** a _token_: to _interpret_ the _token_ if interpreting, or to _compile_ the _token_ if compiling.

**token translator**: a _Forth definition_ that translates a _token_.

**resolver**: a _Forth definition_ that recognizes a _lexeme_ producing a _token_ and its _token translator_.

**token descriptor object**: an _implementation dependent_ _data object_ (a set of information) that describes how to interpret and how to compile a _token_.

**token descriptor**: a value that identifies a _token descriptor object_;
also, less formally and depending on context,
a Forth definition that just returns this value,
or a _token descriptor object_ itself.

**fully qualified token**: a _token_ with its _token descriptor_.

**recognizer**: a _Forth definition_ that recognizes a _lexeme_ producing a _fully qualified token_.

**simple recognizer**: a _recognizer_ that may produce _tokens_ with some the same _token descriptor_ only.

**compound recognizer**: a _recognizer_ that can produce _tokens_ with the different _token descriptors_.

**current recognizer**: a _recognizer_ that is currently used by the text interpreter to translate a _lexeme_.



## XY.3 Additional usage requirements

### XY.3.1 Data types

**Token descriptors** are implementation-dependent single-cell values that identify _token descriptor objects_.

Append table XY.1 to table 3.1

#### Table XY.1
Symbol | Data type | Size on stack
-- | -- | --
td | token descriptor | 1 cell



### XY.3.2 The Forth text interpreter

If the Recognizer word set is present, the following specification should be used instead the specification in the section 3.4 begining with "a. Skip leading spaces" and up to the sub-section "3.4.1".

- a. Skip leading spaces and parse a _lexeme_ (see 3.4.1);
- b. Recognize the _lexeme_ using the current recognizer and producing a _fully qualified token_;
  -  1\. if interpreting, according to the _token descriptor_, perform the _interpretation semantics_ that are determined by the _token_ and continue at a).
  -  2\. if compiling, according to the _token descriptor_, perform the _complication semantics_ that are determined by the _token_ and continue at a).
- c. If unsuccessful, an ambiguous condition exists (see 3.4.4).



### XY.3.3 Contiguous regions

The regions of data space produced by the operations described in 3.3.3.2 Contiguous regions may be non-contiguous if the following words are executed between allocations. 

 - `PERCEPTOR`
 - `SET-PERCEPTOR`
 - `SET-PERCEPTOR-BEFORE`
 - `SET-PERCEPTOR-AFTER`
 - `REVERT-PERCEPTOR`

(the words are *under constraction*, see also [Issue #3](https://github.com/ForthHub/fep-recognizer/issues/3))
