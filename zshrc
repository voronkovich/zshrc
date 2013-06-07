source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles {{{
antigen bundle git
antigen bundle symfony 
antigen bundle voronkovich/sf2.plugin.zsh
antigen bundle voronkovich/apache2.plugin.zsh
antigen bundle composer
antigen bundle extract
antigen bundle tarruda/zsh-fuzzy-match
# antigen bundle $HOME/development/apache2.plugin.zsh/ --no-local-clone
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zaw
antigen bundle zsh-users/zsh-completions
fpath=(~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git/src $fpath)
# }}}

# Load the theme.
antigen theme gentoo

# Tell antigen that you're done.
antigen apply

# Exporting variables {{{
export PATH=$PATH:~/bin:~/eclipse:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export EDITOR=vim
export PROJECTS=~/development
export ZSH_PLUGIN_APACHE_SITES_CUSTOM_TEMPLATES=~/.sites_templates
# }}}

# Aliases {{{
alias zshrs="source ~/.zshrc"
alias zshrc="e ~/.zshrc"
alias vim="stty stop '' -ixoff ; vim"
alias e="$EDITOR"
alias ack="ack-grep"
alias my="mysql -u root -p"
# }}}

# Projects {{{
p() { if [[ -f $PROJECTS/$1 ]] then cd $PROJECTS/$1; else take $PROJECTS/$1; fi; }
_project() { _files -W $PROJECTS; }
compdef _project p
# }}}

# Fuzzy search {{{
f() {
    # TODO: add replacing * to .*
    find -iname "*$1*" | grep -i $1
}
ff() {
    find | grep -i "$(echo "$1" | sed 's/./&.*/g')$(test -z $2 || echo "$2.*")"
}
# }}}

# Automatically run ls on blank line for faster navigation {{{
auto-ls () {
    if [[ $#BUFFER -eq 0 ]]; then
        echo ""
        ls
        zle redisplay
    else
        zle .$WIDGET
    fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls
# }}}

if [[ -r $HOME/.zsh_custom ]]; then
    source $HOME/.zsh_custom
fi
# vim: foldmethod=marker
