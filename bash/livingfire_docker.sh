#!/bin/bash
livingfire-docker-bash() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi

    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME container_1\e[39m"
    local USAGE_PARAM="\e[33musage: $FUNCNAME <DOCKER_CONTAINER_NAME>\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi

    if [[ -z "$1" ]]; then
        echo -e "$USAGE_PARAM \n\e[31mmissing: DOCKER_CONTAINER_NAME\e[39m"
        echo -e "$USAGE_EXAMPLE"
        return 1
    fi
    local DOCKER_CONTAINER_NAME="$1"

    docker exec -ti $DOCKER_CONTAINER_NAME bash
    return $?
}

livingfire-docker-cat() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi

    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME container_1 /var/log/foo.log\e[39m"
    local USAGE_PARAM="\e[33musage: $FUNCNAME <DOCKER_CONTAINER_NAME> <LOG_FILE>\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi

    if [[ -z "$1" ]]; then
        echo -e "$USAGE_PARAM \n\e[31mmissing: DOCKER_CONTAINER_NAME\e[39m"
        echo -e "$USAGE_EXAMPLE"
        return 1
    fi
    local DOCKER_CONTAINER_NAME="$1"

    shift
    if [[ -z "$1" ]]; then
        echo -e "$USAGE_PARAM \n\e[31mmissing: LOG_FILE\e[39m"
        echo -e "$USAGE_EXAMPLE"
        return 1
    fi
    local LOG_FILE="$1"


    docker exec -ti $DOCKER_CONTAINER_NAME cat $LOG_FILE
    return $?
}

livingfire-docker-tail() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi

    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME container_1 /var/log/foo.log\e[39m"
    local USAGE_PARAM="\e[33musage: $FUNCNAME <DOCKER_CONTAINER_NAME> <LOG_FILE>\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi

    if [[ -z "$1" ]]; then
        echo -e "$USAGE_PARAM \n\e[31mmissing: DOCKER_CONTAINER_NAME\e[39m"
        echo -e "$USAGE_EXAMPLE"
        return 1
    fi
    local DOCKER_CONTAINER_NAME="$1"

    shift
    if [[ -z "$1" ]]; then
        echo -e "$USAGE_PARAM \n\e[31mmissing: LOG_FILE\e[39m"
        echo -e "$USAGE_EXAMPLE"
        return 1
    fi
    local LOG_FILE="$1"

    docker exec -ti $DOCKER_CONTAINER_NAME tail -f $LOG_FILE
    return $?
}

livingfire-docker-clean() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi
    local USAGE_PARAM="\e[33musage: $FUNCNAME\e[39m"
    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi

    # https://docs.docker.com/engine/reference/commandline/ps/#filtering
    if [[ $(docker ps -qa --no-trunc --filter 'status=exited' | wc -l) -ne 0 ]]; then
        echo -e "\e[32mdocker remove exited containers\e[39m"
        docker rm -f $(docker ps -qa --no-trunc --filter 'status=exited')
    fi

    # https://docs.docker.com/engine/reference/commandline/images/#filtering
    if [[ $(docker images --quiet --filter 'dangling=true' | wc -l) -ne 0 ]]; then
        echo -e "\e[32mdocker remove intermediate images\e[39m"
        docker rmi $(docker images --quiet --filter 'dangling=true')
    fi

    if [[ $(docker volume ls --quiet --filter 'dangling=true' | wc -l) -ne 0 ]]; then
        echo -e "\e[32mdocker remove tangling volumes\e[39m"
        docker volume rm $(docker volume ls --quiet --filter 'dangling=true')
    fi

    return 0
}

livingfire-docker-stats() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi
    local USAGE_PARAM="\e[33musage: $FUNCNAME\e[39m"
    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi
    
    # https://docs.docker.com/engine/reference/commandline/stats/#formatting
    docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}\t{{.Container}}"
    return $?
}

livingfire-docker-remove-everything() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi
    local USAGE_PARAM="\e[33musage: $FUNCNAME\e[39m"
    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi

    # https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -a -q)
    return $?
}
