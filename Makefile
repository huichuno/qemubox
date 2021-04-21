NEY
all: check build output clean

.PHONY: check
check:
	@docker --version || (echo "'docker --version' return code: $$?. Make sure docker is installed"; exit 1)  

.PHONY: build
build:
	@echo "Build qemu_box image"
	@docker build -t qemu_box:latest . 

.PHONY: output
output:
	@echo "Copy output to local build/ folder"
	@if [ -d build ]; then rm -rf build; fi;
	@docker create --name qemu_box_inst qemu_box
	@docker cp qemu_box_inst:/build build
	@docker rm -f qemu_box_inst

.PHONY: clean
clean:
	@echo "Delete qemu_box image" 
	@docker rmi -f qemu_box:latest
