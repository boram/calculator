# CLI RPN Calculator 

## Usage

`cd` into this project and run the binary:

```bash
$ ./bin/calculator
```

To exit, type `q` or `CTRL+D`.

## Overview
`Calculator` is composed of:
* `Calculator::CLI`
* `Calculator::Processor`


## Calculator::CLI

`Calculator::CLI` owns the REPL.

When exceptions are raised in `Calculator::Processor`, they are rescued here and written to `stdout`.


## Calculator::Processor
`Calculator::Processor` owns the core calculator functionality. Numbers are pushed on to an internal stack and evaluated when an arithmetic operator (`+`, `-`, `*`, `/`) is encountered.

Input values are validated here to be arithmetic operators or numbers.

Exceptions raised here bubble up to the `CLI`.


### Future Improvements

1. Specs have many opportunities for DRYing up.
1. Specs spawn this in a separate process so that input and output can be tested directly. However, this means that async issues can mean these tests are potentially brittle. Perhaps, we should look at non-async testing strategies.
1. Fix divide by zero errors in some scenarios where they are not handled. This means there might also be an opportunity for normalizing some logic.


