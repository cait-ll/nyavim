#!/bin/bash

needcmd=''

if [ ! $(which nvim) ]; then
    needcmd="nvim "
fi
if [ ! $(which git) ]; then
    needcmd="${needcmd}git "
fi
if [ ! $(which npm) ]; then
    needcmd="${needcmd}npm "
fi

if [ -z $needcmd ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    [ -f $HOME/.config/nvim/init.vim ] && mv $HOME/.config/nvim $HOME/.config/nvim.old
    [ -f $HOME/.config/nvim/init.lua ] && mv $HOME/.config/nvim $HOME/.config/nvim.old

    cp -r dist $HOME/.config/nvim

    nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync" &> /dev/null
    nvim --headless -c "MasonInstall rust-analyzer typescript-language-server" -c "exit"
    printf '\n\nInstallation complete! \n\n'
else
    echo "Please install the following programs and run the script again: ${needcmd}"
    exit 1
fi
