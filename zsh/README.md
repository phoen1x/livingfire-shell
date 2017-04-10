# usage

```bash
# set commands to download
unset FILE_SCRIPTS
FILE_SCRIPTS[$((${#FILE_SCRIPTS[@]}+1))]="_livingfire-docker-bash"
FILE_SCRIPTS[$((${#FILE_SCRIPTS[@]}+1))]="_livingfire-docker-cat"
FILE_SCRIPTS[$((${#FILE_SCRIPTS[@]}+1))]="_livingfire-docker-tail"

# download and check sha512sum
cd /tmp \
    &&  for FILE_SCRIPT in "${FILE_SCRIPTS[@]}"; do
            curl --silent -o $FILE_SCRIPT "https://raw.githubusercontent.com/phoen1x/shell/master/zsh/$FILE_SCRIPT"
        done \
    &&  curl --silent -o check.sha512sum https://raw.githubusercontent.com/phoen1x/shell/master/zsh/check.sha512sum \
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
    echo -e "\e[32madding path: $PWD\e[39m"
    fpath=($PWD $fpath)
    autoload -U compinit
    compinit
else
    echo -e "\e[31madding path failed: $PWD\e[39m"
    sha512sum -c check.sha512sum
fi
cd -  &> /dev/null
```
