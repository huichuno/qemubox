all: check build install clean

BRANCH := $(shell awk -F '=' '/^BRANCH/{print $$NF}' conf)
PREFIX := $(shell awk -F '=' '/^PREFIX/{print $$NF}' conf)

.PHONY: check
check:
	@docker --version || (echo "'docker --version' return code: $$?. Make sure docker is installed"; exit 1)  

.PHONY: build
build:
	@echo "Build qemu_box image and artifacts"
	@docker build -t qemu_box:latest . 
	@if [ -d build ]; then rm -rf build; fi;
	@docker create --name qemu_box_inst qemu_box
	@docker cp qemu_box_inst:/build build
	@docker rm -f qemu_box_inst

.PHONY: install
install:
	@echo "Install artifacts"
	@if [ ! -f /build/qemu-$(BRANCH).tar.gz ]; then $(error Cannot find build artifact. Installation failed! ); fi;
	@sudo tar -xzvf qemu-$(BRANCH).tar.gz --strip-components=1 --overwrite -C $(PREFIX)

.PHONY: clean
clean:
	@echo "Delete qemu_box image" 
	@docker rmi -f qemu_box:latest

.PHONY: help
help:
	@echo "Targets:"
	@echo "  all            - Build all"
	@echo "  check          - Basic sanity check"
	@echo "  build          - Build qemu_box docker image and qemu artifacts"
	@echo "  install        - Install artifacts"
	@echo "  clean          - Delete qemu_box docker image"
	@echo ""
