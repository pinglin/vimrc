SHELL	:= /bin/bash
FILES	:= $(shell git ls-files autoload bin doc plugin)

all: clang_complete.vba

clang_complete.vba: $(FILES)
	vim -c "r! git ls-files autoload bin doc plugin" \
	     -c '$$,$$d _' \
	     -c "%MkVimball! $@ ." -c 'q!'

.PHONY: install uninstall
install: clang_complete.vba
	vim $< -c 'so %' -c 'q'
uninstall:
	vim -c 'RmVimball clang_complete.vba' -c 'q'

.PHONY: clean
clean:
	rm -f clang_complete.vba
