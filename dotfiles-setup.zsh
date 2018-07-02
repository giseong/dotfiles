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

    # zsh
    link $DOTFILES_PATH/zshrc ~/.zshrc
    link $DOTFILES_PATH/antigen ~/.antigen
    link $DOTFILES_PATH/antigenrc ~/.antigenrc

    # git
    link $DOTFILES_PATH/gitconfig ~/.gitconfig
    link $DOTFILES_PATH/gitignore ~/.gitignore
    link $DOTFILES_PATH/gitattributes ~/.gitattributes

    # vim
    curl -sLf https://spacevim.org/install.sh | bash
    link $DOTFILES_PATH/init.toml ~/.SpaceVim.d/init.toml

    # tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    link $DOTFILES_PATH/tmux.conf ~/.tmux.conf

    # pandoc
    link $DOTFILES_PATH/pandoc ~/.pandoc

    # fonts
    link $DOTFILES_PATH/fonts ~/.fonts
    mkdir -p ~/.config/fontconfig/conf.d
    link $DOTFILES_PATH/fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf

    # Misc
    link $DOTFILES_PATH/ctags ~/.ctags
    link $DOTFILES_PATH/globalrc ~/.globalrc
    link $DOTFILES_PATH/latexmkrc ~/.latexmkrc
    link $DOTFILES_PATH/gitignore ~/.agignore
    link $DOTFILES_PATH/editorconfig ~/.editorconfig
fi
