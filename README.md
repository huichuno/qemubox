# qemubox
Build qemu in docker container

# Prerequisite
Install docker

# Quick Start
git clone git@github.com:huichuno/qemubox.git
make

# conf 
Update REPO_URL and BRANCH parameters in conf file to the desired value

Example:
REPO_URL=https://git.qemu.org/git/qemu.git
BRANCH=v4.2.1

# patches (optional)
Patch files dropped into 'patches/' folder will be applied to target as part of the build process.
File format: *.patch

# "make check"
Make sure docker is installed

# "make build"
Build qemu artifacts through docker build process

# "make output"
Copy artifacts from docker image to local 'build/' folder

# "make clean"
Delete docker image

# "make"
Run make check, build, output and clean
