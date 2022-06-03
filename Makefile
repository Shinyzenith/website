all: dev

build:
	@hugo --minify

dev:
	@hugo server -D

.PHONY: build dev 
