# Klisp in Oak 🌳

This repository holds an implementation of an interpreter for **[Klisp](https://github.com/thesephist/klisp)**, my toy dialect of Lisp, **written in [Oak](https://oaklang.org/)** as opposed to the original [Ink](https://dotink.co/). Klisp now has several implementations, of which this repository contains the **most complete and correct version**. In pursuit of that completeness, this repository contains a way to build an "installable" `klisp` binary, as well as a broad standard library and growing test suite. But Klisp started as a learning project for me to learn about lisp, and that remains true.

If you've stumbled onto this repository, you might notice it's quite bare compared to my norm. I didn't really open-source this for anyone's benefit but my own -- I need some place to put this code, and it seemed like it had gotten big enough that it warranted its own small repository.

This repo started out as a sort of a (manual, partial) fork of [thesephist/klisp](https://github.com/thesephist/klisp), especially as far as the libraries (in `./lib`) were concerned. `klisp.oak` is nearly a direct port of [`src/klisp.ink`](https://github.com/thesephist/klisp/blob/main/src/klisp.ink) in the original Klisp repository, with some more built-ins added on. The standard libraries here are much more fleshed out, though.

## Todos

- Finish `lib/json`
- auto-indent in the repl, based on parser errors
- let\* (or make let polymorphic)
- docstrings like clojure, defined as strings. Just trim each line.
- Maybe I should build utilities to be able to work with knowledge bases in Klisp? Bring back xin notes.

## Development and build

Everything is managed with the [Oak CLI](https://oaklang.org/) and the `build.oak` build script.

- Format source files: `oak fmt klisp.oak build.oak --fix`
- Install to `/usr/local/bin/klisp`: `oak build.oak`
- Run tests: `klisp test.klisp`

