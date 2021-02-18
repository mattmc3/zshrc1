.PHONY: help submodules
.DEFAULT_GOAL := help

submodules:
	git submodule update --recursive --remote

help:
	@echo "help        Show this message"
	@echo "submodules  Update git submodules"
