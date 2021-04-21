# qemubox
Build qemu in docker container

# Prerequisite
Install docker

# Quick Start
git clone https://github.com/huichuno/qemubox.git

make

# Config
Update REPO_URL and BRANCH parameters in 'conf' file to the desired value

Example:

REPO_URL=https://git.qemu.org/git/qemu.git

BRANCH=v4.2.1

# Patches (optional)
Patch files dropped into 'patches/' folder will be applied to target as part of the build process.
File format: *.patch

# Makefile
"make check"

- Check docker is installed

"make build"

- Build qemu artifacts through docker build process

"make output"

- Copy artifacts from docker image to local 'build/' folder

"make clean"

- Delete docker image

"make all"

- Run all of above

# Artifacts - Install
cd build

tar -xzvf qemu-v4.2.1.tar.gz

cd src

make install
