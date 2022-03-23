# Klisp in Oak 🌳

This repository holds an implementation of an interpreter for **[Klisp](https://github.com/thesephist/klisp)**, my toy dialect of Lisp, **written in [Oak](https://oaklang.org/)** as opposed to the original [Ink](https://dotink.co/). Klisp now has several implementations, of which this repository contains the **most complete and correct version**. In pursuit of that completeness, this repository contains a way to build an "installable" `klisp` binary, as well as a broad standard library and growing test suite. But Klisp started as a learning project for me to learn about lisp, and that remains true.

If you've stumbled onto this repository, you might notice it's quite bare compared to my norm. I didn't really open-source this for anyone's benefit but my own -- I need some place to put this code, and it seemed like it had gotten big enough that it warranted its own small repository.

This repo started out as a sort of a (manual, partial) fork of [thesephist/klisp](https://github.com/thesephist/klisp), especially as far as the libraries (in `./lib`) were concerned. `klisp.oak` is nearly a direct port of [`src/klisp.ink`](https://github.com/thesephist/klisp/blob/main/src/klisp.ink) in the original Klisp repository, with some more built-ins added on. The standard libraries here are much more fleshed out, though.

## Repl walkthrough

This is a walkthrough of a sample interactive repl session in Klisp. It shows off some parts of the language (and Lisps in general) that I like.

When you first fire up `klisp`, you see a prompt. The prompt starts with a `λ` because I am an uber nerd and I like how it looks. (It's also an un-subtle reference to the [labmda calculus](https://dotink.co/posts/lambda/).) Klisp can do basic things like math and list operations.

```clj
$ klisp
Klisp interpreter v0.1-oak.
λ (+ 1 2 3)
6
λ (append (list 1 2 3) (list 'a' 'b' 'c'))
(1 2 3 'a' 'b' 'c')
λ (reduce (range 100) 0 +)
4950
```

Klisp supports common string/list operations and macros like the [threading macros](https://clojure.org/guides/threading_macros) `->` and `->>`, which makes certain kinds of programs very pleasant to write and easy to read.

```
λ (-> 'Hello Klisp!' upper (split ' ') reverse)
('KLISP!' 'HELLO')
```

Of course, you can define functions and use them in your programs.

```
λ (defn factorial (n) (prod (nat n)))
(fn (n) (prod (nat n)))
λ (factorial 10)
3628800
λ (-> (nat 10) (map factorial) (each println))
1
2
6
24
120
720
5040
40320
362880
3628800
()
```

Klisp has good design and [standard library support for working with iterable data types](lib/iter.klisp) like strings and lists. For example, the `list-of` macro generates a list from a count and a given expression. Here, we can use tools like this toss 100 fair coins.

```
λ (list-of 10 (rand-choice (list 'head' 'tail')))
('tail' 'tail' 'head' 'tail' 'head' 'tail' 'head' 'tail' 'head' 'head')
λ (-> (list-of 100 (rand-choice (list 'head' 'tail'))) sort partition)
(('head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head' 'head') ('tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail' 'tail'))
λ (-> (list-of 100 (rand-choice (list 'head' 'tail'))) freq)
(('head' . 44) ('tail' . 56))
```

Klisp also has a decent library for manipulating strings (which are byte arrays). Here are some of them in action:

```
λ (replace 'Hello, World!' 'World' 'Klisp')
'Hello, Klisp!'
λ (trim '           So much space!\t\n        ')
'So much space!'
λ (defn format-num (n) (-> n (round 2) ->string (pad-start 8 ' ')))
(fn (n) (-> n (round 2) ->string (pad-start 8 ' ')))
λ (format-num 25.6789)
'   25.68'
```

Klisp has some fun stuff in the [math library](lib/math.klisp), which I added mostly to have some more compute-intensive functions to test the interpreter. `prime-factors` and `factors` are particularly fun.

```
λ (factor? 10 2)
true
λ (prime-factors 10)
(2 5)
λ (prime-factors 60)
(2 2 3 5)
λ (factors 60)
(1 2 3 4 5 6 10 12 15 20 30 60)
λ (factors 1000)
(1 2 4 5 8 10 20 25 40 50 100 125 200 250 500 1000)
λ (factors (factorial 10))
(1 2 3 4 5 6 7 8 9 10 12 14 15 16 18 20 21 24 25 27 28 30 32 35 36 40 42 45 48 50 54 56 60 63 64 70 72 75 80 81 84 90 96 100 105 108 112 120 126 128 135 140 144 150 160 162 168 175 180 189 192 200 210 216 224 225 240 252 256 270 280 288 300 315 320 324 336 350 360 378 384 400 405 420 432 448 450 480 504 525 540 560 567 576 600 630 640 648 672 675 700 720 756 768 800 810 840 864 896 900 945 960 1008 1050 1080 1120 1134 1152 1200 1260 1280 1296 1344 1350 1400 1440 1512 1575 1600 1620 1680 1728 1792 1800 1890 1920 2016 2025 2100 2160 2240 2268 2304 2400 2520 2592 2688 2700 2800 2835 2880 3024 3150 3200 3240 3360 3456 3600 3780 3840 4032 4050 4200 4320 4480 4536 4725 4800 5040 5184 5376 5400 5600 5670 5760 6048 6300 6400 6480 6720 6912 7200 7560 8064 8100 8400 8640 8960 9072 9450 9600 10080 10368 10800 11200 11340 11520 12096 12600 12960 13440 14175 14400 15120 16128 16200 16800 17280 18144 18900 19200 20160 20736 21600 22400 22680 24192 25200 25920 26880 28350 28800 30240 32400 33600 34560 36288 37800 40320 43200 44800 45360 48384 50400 51840 56700 57600 60480 64800 67200 72576 75600 80640 86400 90720 100800 103680 113400 120960 129600 134400 145152 151200 172800 181440 201600 226800 241920 259200 302400 362880 403200 453600 518400 604800 725760 907200 1.2096e+06 1.8144e+06 3.6288e+06)
```

Lastly, there are a handful of built-in functions that let Klisp programs interact with the local filesystem in a synchronous, blocking way.

```
λ (-> (read-file 'README.md') (split '\n') (filter (partial (starts-with? ? '- '))) (map upper))
('- FINISH `LIB/JSON`' '- AUTO-INDENT IN THE REPL, BASED ON PARSER ERRORS' '- LET\\* (OR MAKE LET POLYMORPHIC)' '- DOCSTRINGS LIKE CLOJURE, DEFINED AS STRINGS. JUST TRIM EACH LINE.' '- MAYBE I SHOULD BUILD UTILITIES TO BE ABLE TO WORK WITH KNOWLEDGE BASES IN KLISP? BRING BACK XIN NOTES.' '- FORMAT SOURCE FILES: `OAK FMT KLISP.OAK BUILD.OAK --FIX`' '- INSTALL TO `/USR/LOCAL/BIN/KLISP`: `OAK BUILD.OAK`' '- RUN TESTS: `KLISP TEST.KLISP`')
λ (-> (list-files 'lib') (map (partial (getc ? ,name))) sort)
('comp.klisp' 'iter.klisp' 'json.klisp' 'klisp.klisp' 'macro.klisp' 'math.klisp' 'random.klisp' 'sort.klisp' 'str.klisp' 'test.klisp')
λ (-> (list-files 'lib') (map (partial (getc ? ,name))) (map (partial (trim-end ? '.klisp'))) sort)
('comp' 'iter' 'json' 'klisp' 'macro' 'math' 'random' 'sort' 'str' 'test')
```

## Todos

- Finish `lib/json` for JSON parsing and serialization. Can model off of [Oak's libjson](https://oaklang.org/lib/json/).
- Maybe I should build utilities to be able to work with knowledge bases in Klisp? Bring back Xin notes?

## Development and build

Everything is managed with the [Oak CLI](https://oaklang.org/) and the `build.oak` build script.

- Format source files: `oak fmt klisp.oak build.oak --fix`
- Install to `/usr/local/bin/klisp`: `oak build.oak`
- Run tests: `klisp test.klisp`

