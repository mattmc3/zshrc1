# Comments denoted with ##? are used by 'help' to construct the help docs.
##? zshrc1 - A powerful starter .zshrc
##?
##? Usage:  make <command>"
##?
##? Commands:

.DEFAULT_GOAL := help
all : build buildman test unittest bump-maj bump-min bump-rev help
.PHONY : all

##? help        display this makefile's help information
help:
	@grep "^##?" makefile | cut -c 5-

##? bump-maj    bump the major version (X.0.0)
bump-maj:
	bumpversion --allow-dirty major

##? bump-min    bump the minor version (0.X.0)
bump-min:
	bumpversion --allow-dirty minor

##? bump-rev    bump the revision version (0.0.X)
bump-rev:
	bumpversion --allow-dirty revision
