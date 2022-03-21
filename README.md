# Klisp in Oak

This repository holds an implementation of an interpreter for [Klisp](https://github.com/thesephist/klisp), my toy dialect of Lisp, but written in [Oak]() as opposed to the original [Ink](). Klisp now has several implementations, of which this repository contains just one.

If you've stumbled onto this repository, you might notice it's quite bare. I didn't really open-source this for anyone's benefit but my own -- I need some place to put this code, and it seemed like it had gotten big enough that it warranted its own small repository.

This repo started out as a sort of a (manual, partial) fork of [thesephist/klisp](https://github.com/thesephist/klisp), especially as far as the libraries (in `./lib`) were concerned. `klisp.oak` is nearly a direct port of [`src/klisp.ink`](https://github.com/thesephist/klisp/blob/main/src/klisp.ink) in the original Klisp repository, with some more built-ins added on. The standard libraries here are much more fleshed out, though.

## Todos

- File I/O APIs
- auto-indent in the repl, based on parser errors
- let\* (or make let polymorphic)
- docstrings like clojure, defined as strings. Just trim each line.
- `macroexpand-all` sometimes doesn't expand all: `(macroexpand-all (match (list 1 2 3)))`

## Development and build

Format files

```
oak fmt klisp.oak build.oak --fix
```

Install to `/usr/local/bin/klisp`

```
oak build.oak
```

Test

```
klisp test.klisp
```
