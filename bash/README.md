# usage

```bash
# set commands to download
unset FILE_SCRIPTS
FILE_SCRIPTS[$((${#FILE_SCRIPTS[@]}+1))]="livingfire_shell.sh"
FILE_SCRIPTS[$((${#FILE_SCRIPTS[@]}+1))]="livingfire_docker.sh"

# download and check sha512sum
cd /tmp \
    &&  for FILE_SCRIPT in "${FILE_SCRIPTS[@]}"; do
            curl --silent -o $FILE_SCRIPT "https://raw.githubusercontent.com/phoen1x/shell/master/bash/$FILE_SCRIPT"
        done \
    &&  curl --silent -o check.sha512sum https://raw.githubusercontent.com/phoen1x/shell/master/bash/check.sha512sum \
    &&  for FILE_SCRIPT in "${FILE_SCRIPTS[@]}"; do
            if [[ $(sha512sum -c check.sha512sum | grep "$FILE_SCRIPT.*OK" | wc -l) -eq 1 ]]; then
                echo -e "\e[32mdownload $FILE_SCRIPT OK\e[39m"
            else
                echo -e "\e[31mdownload $FILE_SCRIPT FAILED\e[39m"
            fi
        done
```


# autoload functions
```bash
cd /path/to/files
sha512sum -c check.sha512sum &> /dev/null
if [[ $? -eq 0 ]]; then
    for ACT_FILE in $(cat check.sha512sum | awk '{print $2}')
    do source $ACT_FILE && echo -e "\e[32mloaded $ACT_FILE\e[39m"; done
else
    echo -e "\e[31madding path failed: $PWD\e[39m"
    sha512sum -c check.sha512sum
fi
cd -  &> /dev/null
```
