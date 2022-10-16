all: build

# build CLI
build:
	oak build.oak --path ./klisp
b: build

# install CLI
install:
	oak build.oak --path /usr/local/bin/klisp
	cp klisp.vim ~/.vim/syntax/klisp.vim

# run CLI after building an executable
run: build
	./klisp

# build + run Klisp test suite
test: build
	time ./klisp test.klisp
t: test

# format changed Oak source
fmt:
	oak fmt klisp.oak build.oak --fix
f: fmt

