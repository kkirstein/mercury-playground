# start docker image interactively with Mercury compiler
# and current folder mounted
docker run -it -v ${PWD}:/var/tmp/mercury/mercury-playground mercury bash
