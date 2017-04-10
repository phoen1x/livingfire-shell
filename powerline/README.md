# usage

```bash
sudo -i
apt-get -y install python-pip git
pip install git+https://github.com/powerline/powerline
curl -o /usr/share/fonts/PowerlineSymbols.otf https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
curl -o /etc/fonts/conf.d/10-powerline-symbols.conf https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -O 
fc-cache -vf

# git repo for vim, bash, tmux, ...
git clone https://github.com/powerline/powerline.git    /usr/share/powerline
```

# link
* https://powerline.readthedocs.org/en/latest/
* https://fedoramagazine.org/add-power-terminal-powerline/
* http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
* https://www.youtube.com/watch?v=XSeO6nnlWHw&list=PLu8EoSxDXHP7tXPJp5ZmUpuT7sFvrswzf
