# usage

```bash
sudo -i
apt-get -y install python-pip git

# install powerline
pip install git+https://github.com/powerline/powerline

# install powerline bindings
git clone https://github.com/powerline/powerline.git /tmp/powerline
rsync -avzP /tmp/powerline/powerline /usr/share

# install powerline fonts (global)
git clone https://github.com/powerline/fonts.git --depth=1 /tmp/powerline_font
cd /tmp/powerline_font
./install.sh
rsync -avzP /root/.local/share/fonts/* /usr/share/fonts
fc-cache -vf

# cleanup
rm -r /tmp/powerline /tmp/powerline_font
```

# link
* https://powerline.readthedocs.org/en/latest/
* https://github.com/powerline/fonts
* https://fedoramagazine.org/add-power-terminal-powerline/
* http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
* https://www.youtube.com/watch?v=XSeO6nnlWHw&list=PLu8EoSxDXHP7tXPJp5ZmUpuT7sFvrswzf
