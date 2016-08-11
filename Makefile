.DEFAULT_GOAL := help

help:
	@echo "help      -- print this help"
	@echo "all       -- generate yaml and build new docker image"
	@echo "build     -- build docker image"
	@echo "yaml      -- generate yaml file from 'supported hooks' json URL"

all: yaml build

build:
	docker build -t pre-commit .

yaml:
	./get-hooks-as-yaml.py > .pre-commit-config-for-build.yaml
