#/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

realPathParser(){
	local realPathRet=$(realpath -q $1)
	if [ -z $realPathRet ] 
	then
  		echo ""
  	else
  		echo $realPathRet
	fi
}

detectDependencyFile(){
	local potentialFilePath=$(realPathParser ${1})
	if [ -z $potentialFilePath ]
	then
		echo -e "${YELLOW}Did NOT detect '${1}'. Be sure that flow_settings.txt is updated to reflect where the recource is located on your system${NC}"
	else
		if [ -f $potentialFilePath ]
    	then
			echo -e "${GREEN}'${1}' detected... continuing${NC}"
    	else
	    echo -e "${RED}Did NOT detect the required recource'${1}'. Exiting now ${NC}"
	    exit 1
    	fi
	fi
}

detectDependencyDir(){
    local potentialDirPath=$(realPathParser ${1})
    if [ -z $potentialDirPath ]
    then
	echo -e "${YELLOW}Did NOT detect '${1}'. Be sure that flow_settings.txt is updated to reflect where the recource is located on your system${NC}"
    else
	if [ -d $potentialDirPath ]
    	then
	    echo -e "${GREEN}'${1}' detected... continuing${NC}"
    	else
	    echo -e "${YELLOW}Did NOT detect '${1}'. Be sure that flow_settings.txt is updated to reflect where the recource is located on your system${NC}"
    	fi
    fi
}

detectDependencyFile "/usr/bin/docker"

IMAGE_NAME="em_img"
IMAGE_OS="debian:buster" #official docker container images: https://hub.docker.com/search?q=&type=image&image_filter=official&category=os

docker stop $IMAGE_NAME > /dev/null
docker rm $IMAGE_NAME > /dev/null

# create image that binds port 80 to port 80?
docker create --name $IMAGE_NAME $IMAGE_OS

SANITY_VAR1=$( docker ps -a | grep $IMAGE_NAME )
if [ -z "$SANITY_VAR1" ]
then
    echo -e "${RED}New docker caontainer was not detected! exiting now${NC}"
    exit 1
fi

mkdir $IMAGE_NAME
docker build -t $IMAGE_NAME -f /home/runner/work/action_test/action_test/Dockerfile \
       --build-arg IMAGE_NAME=${IMAGE_NAME} \
       --no-cache \
       . 



#
#
#Usefull docker image links:
#start docker w bash access: https://stackoverflow.com/questions/29599632/docker-container-is-not-running
