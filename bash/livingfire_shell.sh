#!/bin/bash
livingfire-shell-backup() {
    if [[ -z $FUNCNAME ]]; then
        # get zsh function name
        local FUNCNAME=$funcstack[1]
    fi
    local USAGE_EXAMPLE="\e[32mexample: $FUNCNAME '/tmp/foo.txt'\e[39m"
    local USAGE_PARAM="\e[33musage: $FUNCNAME <FILE_PATH>\e[39m"

    if [[ "$1" == "--help" ]]; then
        echo -e "$USAGE_PARAM"
        echo -e "$USAGE_EXAMPLE"
        return 0
    fi

    if [[ -z "$1" ]]; then
        echo -e "$USAGE_PARAM \n\e[31mmissing: FILE_PATH\e[39m"
        echo -e "$USAGE_EXAMPLE"
        return 1
    fi
    local FILE_PATH="$1"

    ## start script

    local FILE_NAME=""
    local BACKUP_DIR=""
    if [[ -f $FILE_PATH ]]; then
        FILE_NAME="$(basename "$FILE_PATH")"
        FILE_PATH="$(dirname $FILE_PATH)"
        BACKUP_DIR="$FILE_PATH/_archive/$(date +%Y%m%d_%H%M%S)"
    else
        if [[ -d $FILE_PATH ]]; then
            FILE_NAME=""
            FILE_PATH="$FILE_PATH"
            BACKUP_DIR="$FILE_PATH/_archive"
        else
            echo -e "\e[31mnot found: $FILE_PATH"
            return 1
        fi
    fi

    mkdir -p $BACKUP_DIR
    if [[ $? -ne 0 ]]; then
        echo -e "\e[31mcan not create: $BACKUP_DIR\e[39m"
        return 1
    fi

    if [[ $FILE_NAME == "" ]]; then
        echo -e "backup directory to: \e[32m$BACKUP_DIR\e[39m"
        TMP_DIR="/tmp/$(date +%Y%m%d_%H%M%S)"
        rsync -avzP --exclude '_archive' "$FILE_PATH" "$TMP_DIR"
        mv $TMP_DIR $BACKUP_DIR
    else
        echo -e "backup file to: \e[32m$BACKUP_DIR\e[39m"
        rsync -avzP "$FILE_PATH/$FILE_NAME" "$BACKUP_DIR/$FILE_NAME"
    fi
    return 0
}

livingfire-shell-color() {
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

echo '
    xdg-open http://misc.flogisoft.com/bash/tip_colors_and_formatting

\e[32m    GREEN\techo -e "\\e[32mfoo\\e[39m"
\e[31m    RED\t\techo -e "\\e[31mfoo\\e[39m"
\e[33m    YELLOW\techo -e "\\e[33mfoo\\e[39m"
'

    return 0
}
