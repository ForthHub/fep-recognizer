## XY.2 Additional terms and notations

(NB: perhaps some terms are unnecessary, see [#2](../../issues/2)/Rationale)

**tuple**: a logical union of several elements that keeps their order; when a tuple is placed into the data stack, the rightmost element in writing is the topmost on the stack, and floating-point numbers are placed into the floating-point stack.

**lexeme**: a syntactic unit of a _program_ (a Forth source code); (unless otherwise noted, it is a sequence of non-blank characters delimited by a blank).

to **recognize** a _lexeme_: to determine the _interpretation semantics_ and the _compilation semantics_ for the _lexeme_ in the current dynamic context.

to **interpret** a _lexeme_: to perform the _interpretation semantics_ for the _lexeme_ in the current dynamic context.

to **compile** a _lexeme_: to perform the _compilation semantics_ for the _lexeme_ in the current dynamic context.

to **translate** a _lexeme_: to _interpret_ the _lexeme_ if interpreting, or to _compile_ the _lexeme_ if compiling.

**dynamic context** of a _lexeme_: information that is available at the time the _lexeme_ is _translated_.

**unqualified token**: a tuple of arbitrary _data objects_ that determines the _interpretation semantics_ and the _compilation semantics_ for a _lexeme_ in its _dynamic context_.

**token**: _unqualified token_ (a synonym, when it is clear from context).

to **interpret** a _token_: to perform the _interpretation semantics_ that are determined by the token.

to **compile** a _token_: to perform the _compilation semantics_ that are determined by the token.

to **translate** a _token_: to _interpret_ the _token_ if interpreting, or to _compile_ the _token_ if compiling.

**token translator**: a _Forth definition_ that translates a _token_;
also, depending on context,
an _execution token_ for this Forth definition.

**resolver**: a _Forth definition_ that recognizes a _lexeme_ producing a tuple of a _token_ and its _token translator_.

**token descriptor object**: an _implementation dependent_ _data object_ (a set of information) that describes how to interpret and how to compile a _token_.

**token descriptor**: a value that identifies a _token descriptor object_;
also, less formally and depending on context,
a Forth definition that just returns this value,
or a _token descriptor object_ itself.

**fully qualified token**: a tuple of a _token_ and its _token descriptor_.

**recognizer**: a _Forth definition_ that recognizes a _lexeme_ producing a _fully qualified token_.

**simple recognizer**: a _recognizer_ that may produce the same _token descriptor_ only.

**compound recognizer**: a _recognizer_ that can produce the different _token descriptors_.

**perceptor**: a _recognizer_ that is currently used by the Forth text interpreter to translate a _lexeme_.

**current recognizer**: the _perceptor_ (an unformal synonym).

**default perceptor**: the _perceptor_ before it was changed by a program, or after reverting these changes.


## XY.3 Additional usage requirements

### XY.3.1 Data types

Append table XY.1 to table 3.1

#### Table XY.1
Symbol | Data type | Size on stack
-- | -- | --
td | token descriptor | 1 cell
tt | token translator | 1 cell
ut | unqualifed token | 0 or more cells on the data stack and floating-point stack

#### XY.3.1.1 Data-type relationships
```
td => x ;
tt => xt ;
ut => i*x j*r; where i >=0, j >= 0 ;
```

### XY.3.2 The Forth text interpreter

If the Recognizer word set is present, the following specification should be used instead the specification in the section 3.4 begining with "a. Skip leading spaces" and up to the sub-section "3.4.1".

- a. Skip leading spaces and parse a _lexeme_ (see 3.4.1);
- b. Recognize the _lexeme_ using the perceptor and producing a _fully qualified token_;
  -  1\. if interpreting, according to the _token descriptor_, perform the _interpretation semantics_ that are determined by the _token_ and continue at a).
  -  2\. if compiling, according to the _token descriptor_, perform the _complication semantics_ that are determined by the _token_ and continue at a).
- c. If unsuccessful, an ambiguous condition exists (see 3.4.4).

#### XY.3.2.1 The default perceptor

Initially the perceptor should recognize a lexeme in the following order

- 1\. As the name of a local variable if the Locals word set is provided.
- 2\. As the name of a Forth word according to the search order if the Search-Order word set is provided, or in the dictionary header space otherwise.
- 3\. As a number according to [3.4.1.3](https://forth-standard.org/standard/usage#usage:numbers).
- 4\. As other implementaton defined forms, if any.


### XY.3.3 Contiguous regions

The regions of data space produced by the operations described in 3.3.3.2 Contiguous regions may be non-contiguous if the following words are executed between allocations. 

 - `PERCEPTOR`
 - `SET-PERCEPTOR`
 - `SET-PERCEPTOR-BEFORE`
 - `SET-PERCEPTOR-AFTER`
 - `REVERT-PERCEPTOR`

(the words are *under constraction*, see also [Issue #3](https://github.com/ForthHub/fep-recognizer/issues/3))
