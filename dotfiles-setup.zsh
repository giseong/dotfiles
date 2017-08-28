#!/usr/bin/env zsh

if [ -z "$PS1" ]; then
    echo -e "${COLOR_RED}You should source this, not run it${COLOR_NC}"
else

    link (){
        rm -rf $2
        ln -s $1 $2
    }

    DOTFILES_PATH=~/.dotfiles
    cd $DOTFILES_PATH
    git submodule update --init
    cd $HOME

    # powerline
    sudo python3.6 -m pip install powerline-status

    # zsh
    rm -rf ~/.oh-my-zsh
    link $DOTFILES_PATH/zshrc ~/.zshrc
    link $DOTFILES_PATH/antigen ~/.antigen
    link $DOTFILES_PATH/antigenrc ~/.antigenrc

    # git
    # echo -e "copy gitconfig and modify it"
    if [[ `uname` == "Darwin" ]]; then
        link $DOTFILES_PATH/gitconfig_osx ~/.gitconfig
    elif [[ `uname` == "Linux" ]]; then
        link $DOTFILES_PATH/gitconfig_linux ~/.gitconfig
    fi
    link $DOTFILES_PATH/gitignore ~/.gitignore
    link $DOTFILES_PATH/gitattributes ~/.gitattributes

    # vim
    link $DOTFILES_PATH/vim ~/.vim
    link $DOTFILES_PATH/vimrc ~/.vimrc

    # tmux
    if [[ `uname` == "Darwin" ]]; then
        link $DOTFILES_PATH/tmux_osx.conf ~/.tmux.conf
    elif [[ `uname` == "Linux" ]]; then
        link $DOTFILES_PATH/tmux_linux.conf ~/.tmux.conf
    fi
    link $DOTFILES_PATH/tmux_shared.conf ~/.tmux_shared.conf

    # pandoc
    link $DOTFILES_PATH/pandoc ~/.pandoc

    # config
    mkdir -p ~/.config
    link $DOTFILES_PATH/config/zathura ~/.config/zathura
    link $DOTFILES_PATH/config/powerline ~/.config/powerline

    # task
    link $DOTFILES_PATH/taskd ~/.taskd
    link $DOTFILES_PATH/taskrc ~/.taskrc

    # fonts
    link $DOTFILES_PATH/fonts ~/.fonts
    mkdir -p ~/.config/fontconfig/conf.d
    link $DOTFILES_PATH/fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf

    # Misc
    link $DOTFILES_PATH/ctags ~/.ctags
    link $DOTFILES_PATH/latexmkrc ~/.latexmkrc
    link $DOTFILES_PATH/inputrc ~/.inputrc
    link $DOTFILES_PATH/editrc ~/.editrc
    link $DOTFILES_PATH/gtkrc-2.0 ~/.gtkrc-2.0
    link $DOTFILES_PATH/gitignore ~/.agignore
    link $DOTFILES_PATH/tigrc ~/.tigrc
    link $DOTFILES_PATH/editorconfig ~/.editorconfig

fi
