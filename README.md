# qemubox
Build qemu-system-x86_64 in docker container

# Prerequisite
Install Docker
--------------
sudo apt update && sudo apt -y upgrade

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt update

sudo apt install docker-ce docker-ce-cli

sudo usermod -aG docker ${USER}

Install other dependencies
--------------------------
sudo apt install -y libsdl2-2.0-0 libspice-server1 git make

# Quick Start
git clone https://github.com/huichuno/qemubox.git

make help

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

- Run check, build and clean

"make check"

- Check docker is installed

"make build"

- Build qemu artifacts through docker build process

"make install"

- Install artifacts from build/ folder 

"make clean"

- Delete docker image

"make help"

- Print make options

# Debug
make build

docker run -it qemu_box:latest bash

