# Comments denoted with ##? are used by 'help' to construct the help docs.
##? zshrc1 - A powerful starter .zshrc
##?
##? Usage:  make <command>
##?
##? Commands:

.DEFAULT_GOAL := help
all : help bump-major bump-minor bump-revision bumpver
.PHONY : all

##?   help            display this makefile's help information
help:
	@grep "^##?" makefile | cut -c 5-

##?   bump-major      bump the major version (X.0.0)
bump-major:
	bumpversion --allow-dirty major

##?   bump-minor      bump the minor version (0.X.0)
bump-minor:
	bumpversion --allow-dirty minor

##?   bump-revision   bump the revision version (0.0.X)
bump-revision:
	bumpversion --allow-dirty revision

##?   bumpver         alias to bump the revision version (0.0.X)
bumpver:
	bumpversion --allow-dirty revision
