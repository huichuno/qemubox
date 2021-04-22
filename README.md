# qemubox
Build qemu in docker container

# Prerequisite
Install docker

sudo apt install -y libsdl2-2.0-0 libspice-server1

# Quick Start
git clone https://github.com/huichuno/qemubox.git

make

# Config
Update REPO_URL, BRANCH and PREFIX parameters in 'conf' file to the desired value

Example:

REPO_URL=https://git.qemu.org/git/qemu.git

BRANCH=v4.2.1

PREFIX=/usr

# Patches (optional)
Patch files dropped into 'patches/' folder will be applied to target as part of the build process.
File format: *.patch

# Makefile
"make all" (default)

- Run Check, Build and Clean

"make check"

- Check docker is installed

"make build"

- Build qemu artifacts through docker build process

"make install"

- Install artifacts from build/ folder 

"make clean"

- Delete docker image

# Debug
make build

docker run -it qemu_box:latest bash

