#!/bin/bash

# COLOR VARIABLES
green='\033[0;32m'
red='\033[0;31m'
cyan='\033[0;36m'
black='\033[0;30m'

echo -e "${red}======================================================="
echo "= DISCLAIMER! This is an OSX script, at the moment    ="
echo "= it's only dedicated to OSX users, it will install   ="
echo "= docker and the epitest image for continuous testing ="
echo "= on a fedora dump for epitech student. It will ask   ="
echo "= you questions during the installation,              ="
echo "= please answer them correctly.                       ="
echo "= This script has been tested on a macOS 10.13.2.     ="
echo "= Please use at your own risk.                        ="
echo "======================================================="
echo
echo -e "${cyan}======================================================="
echo "=          MADE WITH LOVE BY CORENTIN BARREAU         ="
echo "=             https://github.com/corentinb            ="
echo "======================================================="
echo

###################
# INSTALLING BREW #
###################
echo -e "${green}Let's begin!"
read -p "Maybe you already have brew, or not, do you want me to install brew for you? (y/n)" -n 1 -r
echo -e "${black}"
if [[ $REPLY =~ ^[Yy]$ ]]
then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Ok baby."
fi

#####################
# INSTALLING DOCKER #
#####################
echo
echo -e "${green}This script consider that you have Docker already installed"
echo "on your machine, if not please go to :"
echo -e "${red}https://docs.docker.com/docker-for-mac/install/#what-to-know-before-you-install"
echo -e "${green}Then download the ${red}.dmg ${green}file (Get Docker for Mac (stable) button) and"
echo "install it!"
echo
read -p "Is it done? (y/n)" -n 1 -r
echo -e "${black}"
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Great!"
else
	echo -e "${green}I'll continue without it, but it'll obviously not work,"
	echo "I give you some more time to do it, please go to:"
	echo "https://docs.docker.com/docker-for-mac/install/#what-to-know-before-you-install"
	echo "and install docker on your machine."
	read -p "Is it done? (y/n)" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo -e "${green}Great!"
	else
		echo -e "${red}Cool!"
	fi
fi

#########################
# PULLING EPITEST IMAGE #
#########################
echo
echo -e "${green}We are now gonna pull the ${red}epitest docker image.${green}"
read -p "Did you already pulled it or do you want me to do it for you? (y/n)" -n 1 -r
echo -e "${black}"
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "${green}Ok let's go!${black}"
	docker pull epitechcontent/epitest-docker
	echo -e "${green}Done!"
else
	echo -e "${green}Nice, let's install other stuff now."
fi

##############################
# DOWNLOADING AND INSTALLING #
# DOCKER-OSX-DEV             #
##############################
echo
echo -e "${green}We will now install a little piece of software called"
echo -e "${red}docker-osx-dev${green}, with it you'll be able to mount any directory"
echo "into the Docker container, for testing your programs"
echo
read -p "Please type 'y' to begin. (y)" -n 1 -r
echo -e "${black}"
if [[ $REPLY =~ ^[Yy]$ ]]
then
	curl -o /usr/local/bin/docker-osx-dev https://raw.githubusercontent.com/brikis98/docker-osx-dev/master/src/docker-osx-dev
	chmod +x /usr/local/bin/docker-osx-dev
	docker-osx-dev install
else
	curl -o /usr/local/bin/docker-osx-dev https://raw.githubusercontent.com/brikis98/docker-osx-dev/master/src/docker-osx-dev
	chmod +x /usr/local/bin/docker-osx-dev
	docker-osx-dev install
fi
echo -e "${green}Done!"

##############################
#   NOW SOME EXPLANATIONS    #
##############################
echo
echo -e "${red}================================================================================================${green}"
echo -e "${green}Now to sync any folder, you can just execute ${red}'docker-osx-dev'${green} anywhere"
echo "and it'll sync your current folder, or you can execute:"
echo -e "${red}'docker-osx-dev -s /other/path' ${green}where /other/path is the folder you want to sync."
echo
echo "But there is something way more cool."
echo -e "${red}'docker run -v /just/a/path:/src -it epitechcontent/epitest-docker bash'${green}"
echo "You see this? It'll run bash in your docker container and sync your dev folder"
echo "(here /just/a/path) to the /src folder into the docker container."
echo "You just have to change at least the first path, and the second one if you want!"
echo
echo -e "${red}NOTE THAT YOU HAVE TO RUN THE DOCKER-OSX-DEV COMMAND FIRST TO BE ABLE TO USE THE"
echo "DIRECTORY IN DOCKER!"
echo -e "${red}================================================================================================"

######################
# WRITING COMMAND ON #
# A MEMO FILE        #
######################
echo -e "${black}"
echo "First sync any folder with docker-osx-dev command." >> memo.txt
echo "" >> memo.txt
echo "If performed without any argument, it'll sync your current folder." >> memo.txt
echo "You can use -s /other/path to specify a path" >> memo.txt
echo "Once performed for the first time in a folder, the initial sync" >> memo.txt
echo "will be done, you can kill it, and just run it again if you want to update" >> memo.txt
echo "the sync in case you created new files or directories." >> memo.txt
echo "or you can simply let it run in the background, with 'screen' or just" >> memo.txt
echo "another terminal window." >> memo.txt
echo "" >> memo.txt
echo "Now to launch the docker image with this folder in order to test" >> memo.txt
echo "your project, here is the command:" >> memo.txt
echo "'docker run -v /just/a/path:/src -it epitechcontent/epitest-docker bash'" >> memo.txt
echo "Where /just/a/path is the path of the folder you synced before," >> memo.txt
echo "/src is the folder in the container where you want the files to appear," >> memo.txt
echo "and bash is the command you want to execute." >> memo.txt
echo "Have fun!" >> memo.txt

echo
echo -e "${green}I just created a memo.txt file in the folder where you launched this script,"
echo "I wrote this command and some others so you'll never forget them."
echo "Everything is done, have fun and may the force be with you!"
echo -e "${black}"
exit 0