## XY.2 Additional terms and notations

### XY.2.1 Definitions of terms

(NB: perhaps some terms are unnecessary, see [#2](../../issues/2)/Rationale)

**tuple**: a logical ordered union of several elements with possible duplicates.
(#todo #maybe harmonize with XY.3.1.x Tuple)

**lexeme**: a syntactic unit of a _program_ (a Forth source code); (unless otherwise noted, it is a sequence of non-blank characters delimited by a blank).

to **recognize** a _lexeme_: to determine the _interpretation semantics_ and the _compilation semantics_ for the _lexeme_.

**lexical context**: the set of all possible system's states on which recognizing of lexemes depends on.

**lexical context** of a _lexeme_: the element of _lexical context_ in which this _lexeme_ is recognized.

to **interpret** a _lexeme_: to perform the _interpretation semantics_ for the _lexeme_ in its lexical context.

to **compile** a _lexeme_: to perform the _compilation semantics_ for the _lexeme_ in its lexical context.

to **translate** a _lexeme_: to _interpret_ the _lexeme_ if interpreting, or to _compile_ the _lexeme_ if compiling.

**unqualified token**: a tuple of arbitrary _data objects_ that determines the _interpretation semantics_ and the _compilation semantics_ for a _lexeme_ in its _lexical context_.

**token**: _unqualified token_ (a synonym, when it is clear from context).

to **interpret** a _token_: to perform the _interpretation semantics_ that are determined by the token.

to **compile** a _token_: to perform the _compilation semantics_ that are determined by the token.

to **translate** a _token_: to _interpret_ the _token_ if interpreting, or to _compile_ the _token_ if compiling.

**token translator**: a _Forth definition_ that translates a _token_;
also, depending on context,
an _execution token_ for this Forth definition.

**resolver**: a _Forth definition_ that tries to recognize a _lexeme_ producing a tuple of a _token_ and its _token translator_.

**token descriptor object**: an _implementation dependent_ _data object_ (a set of information) that describes how to interpret and how to compile a _token_.

**token descriptor**: a value that identifies a _token descriptor object_;
also, less formally and depending on context,
a Forth definition that just returns this value,
or a _token descriptor object_ itself.

**fully qualified token**: a tuple of a _token_ and its _token descriptor_.

**recognizer**: a _Forth definition_ that tries to recognize a _lexeme_ producing a _fully qualified token_.

**simple recognizer**: a _recognizer_ that may produce the same _token descriptor_ only.

**compound recognizer**: a _recognizer_ that may produce the different _token descriptors_.

**perceptor**: a _recognizer_ that is currently used by the Forth text interpreter to translate a _lexeme_.

**current recognizer**: the _perceptor_ (an unformal synonym).

**initial perceptor**: the _perceptor_ before it was changed by a program, or after reverting these changes.


### XY.2.2 Notation

#### XY.2.2.1 Tuple notation

A tuple is described by a space separated list of data type symbols that is enclosed in parentheses:
`(  symbol_i ... symbol_2 symbol_1 )`

A tuple that contains a nested tuple:
`(  symbol_k ... ( symbol_j ... symbol_i ) ... symbol_1 )`
is equal to the tuple with removed nested parentheses:
`(  symbol_k ... symbol_j ... symbol_i ... symbol_1 )`

In a stack diagram a tuple can be shown in an abbreviation form as `i*x`,
or  surrounded by curved brackets as
`( stack-id: symbol_k ... { symbol_j ... symbol_i } ... symbol_1 -- ... )`

(the latter option is a subject for a discussion)


## XY.3 Additional usage requirements

### XY.3.1 Data types

Append table XY.1 to table 3.1

#### Table XY.1
Symbol | Data type | Size on stack
-- | -- | --
any  | any tuple | 0 or more cells
td | token descriptor | 1 cell
tt | token translator | 1 cell
ut | unqualified token | 0 or more cells
qt | fully qualified token (qtoken) | 1 or more cells

#### XY.3.1.1 Data-type relationships
- `any => ( S: i*x  F: j*r  C: k*x )`
- `td => x`
- `tt => xt`
- `tt => td`
- `ut => ( S: i*x  F: j*r )`
- `qt => ( ut td )`


#### XY.3.1.x Tuple

A tuple is an ordered union of data objects, with possible duplicates.

A tuple is characterized by the number of data objects and the data type for each object,
that are constitute the **tuple signature**.
The number of data objects in a tuple may be uncertain.

A tuple may be empty, that means the number of its data objects is zero.

When a tuple is placed on the stacks,
the elements of the tuple (that are particular data objects)
are placed on the data stack, the floating-point stack, and the control-flow stack,
in accordance with the corresponding data types and their symbols order.
The rightmost element in the tuple becomes the topmost in a stack.
It's possible that none data object is placed on some stack.

(Rationale: the control flow stack is mentioned to allow to use the tuple notation for control flow operations too, if any)

#### XY.3.1.x Unqualified token

(todo: maybe replace "token" with "tuple" everywhere)

An unqualified token is a tuple.

An unqualified token shall be placable on the data and floating point stacks only.


#### XY.3.1.x Token translator

(In this section, "translator" means "token translator")

A translator translates a tuple.
A translator is specialized to a tuple having some particular signature only.
An ambiguous condition exists if a translator is applied to a tuple having another signature.
An ambiguous condition exists if a translator cannot translate a tuple in the current state.


The stack effect of performing a translator is:
`( t_2 t_1 -- t_3 )`. It takes the tuple `t_1` from the stack and translates it.
Other stack effects and side effects are due to the particular translator specializing and translating of this tuple.


#### XY.3.1.x Token descriptor

(In this section, "descriptor" means "token descriptor")

A descriptor is specialized to a tuple having some particular signature only.

NB: A token translator can play role of the descriptor.

#### XY.3.1.x Fully qualified token

A fully qualified token is a tuple of an unqualified token and a corresponding descriptor.
The descriptor can be used to translate the token.

### XY.3.x Recognizer

The stack effect of performing a recognizer is:
`( c-addr u -- qt | 0 )`

A recognizer tries to recognize the lexeme identified by the string `( c-addr u )` in its lexical context.
It returns a fully qualified token `qt` if successful, or zero otherwise (if unsuccessful).

Neither interpretation state nor compilation state are the part of the lexical context.

A recognizer shall not have side effects that can be detectable by a standard program that is unaware of internal details of this recognizer.
A recognizer shall return the semantically same results when it is performed consecutively with the same arguments.


### XY.3.2 The Forth text interpreter

If the Recognizer word set is present, the following specification should be used instead the specification in the section 3.4 beginning with "a. Skip leading spaces" and up to the sub-section "3.4.1".

- a. Skip leading spaces and parse a _lexeme_ (see 3.4.1);
- b. Recognize the _lexeme_ using the perceptor and producing a _fully qualified token_;
  -  1\. if interpreting, according to the _token descriptor_, perform the _interpretation semantics_ that are determined by the _token_ and continue at a).
  -  2\. if compiling, according to the _token descriptor_, perform the _complication semantics_ that are determined by the _token_ and continue at a).
- c. If unsuccessful, an ambiguous condition exists (see 3.4.4).

#### XY.3.2.1 The initial perceptor

Initially the perceptor should recognize a lexeme in the following order

- 1\. As the name of a local variable if the Locals word set is provided.
- 2\. As the name of a Forth word according to the search order if the Search-Order word set is provided, or in the dictionary header space otherwise.
- 3\. As a number according to [3.4.1.3](https://forth-standard.org/standard/usage#usage:numbers).
- 4\. As other implementation defined forms, if any.


### XY.3.3 Contiguous regions

The regions of data space produced by the operations described in 3.3.3.2 Contiguous regions may be non-contiguous if the following words are executed between allocations.

 - `PERCEPTOR`
 - `SET-PERCEPTOR`
 - `SET-PERCEPTOR-BEFORE`
 - `SET-PERCEPTOR-AFTER`
 - `REVERT-PERCEPTOR`

(the words are *under construction*, see also [Issue #3](https://github.com/ForthHub/fep-recognizer/issues/3))
