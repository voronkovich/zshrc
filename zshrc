source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle symfony 
antigen bundle sf2
antigen bundle composer
antigen bundle extract

# Load the theme.
antigen theme gentoo

# Tell antigen that you're done.
antigen apply

# Customize to your needs...
export PATH=$PATH:~/bin:~/eclipse:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export EDITOR=vim
export PROJECTS=~/development

alias zshrs="source ~/.zshrc"
alias zshrc="e ~/.zshrc"
alias vim="stty stop '' -ixoff ; vim"
alias e="$EDITOR"
alias se="sudo $EDITOR"
alias a2reload="sudo service apache2 reload"
alias a2ensite="sudo a2ensite"
alias a2dissite="sudo a2dissite"
alias a2addsite="sudo ~/bin/a2create_site/a2create_site"

project() { if [[ -f $PROJECTS/$1 ]] then cd $PROJECTS/$1; else take $PROJECTS/$1; fi; }
_project() { _files -W $PROJECTS; }
compdef _project project

search () {
    find . -iname "*$1*"
}
searchl () {
    find . -iname "$1*"
}
searchr () {
    find . -iname "*$1"
}
