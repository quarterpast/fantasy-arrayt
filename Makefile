all: index.js

%.js: %.ls
	node_modules/.bin/lsc -pc $(LS_OPTS) "$<" > "$@"

.PHONY: clean test
clean:
	rm index.js

test: all
	node_modules/.bin/lsc test.ls