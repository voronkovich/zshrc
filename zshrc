source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles {{{
antigen bundle git
antigen bundle symfony 
antigen bundle vagrant 
#antigen bundle web-search
antigen bundle voronkovich/sf2.plugin.zsh
#antigen bundle voronkovich/apache2.plugin.zsh
antigen bundle voronkovich/mysql.plugin.zsh
antigen bundle composer
antigen bundle extract
#antigen bundle $HOME/development/plugin --no-local-clone
antigen bundle /home/oleg/development/apache2.plugin.zsh/ --no-local-clone
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
export PROJECTS=~/workspace
export ZSH_PLUGIN_APACHE_SITES_CUSTOM_TEMPLATES=~/.sites_templates
# }}}

# Aliases {{{
alias zshrs="source ~/.zshrc"
alias zshrc="e ~/.zshrc"
alias vim="stty stop '' -ixoff ; vim"
alias e="$EDITOR"
alias ec="eclim -command"
alias ecpc="eclim -command project_create -f"
alias ecpu="eclim -command project_update -p"
alias ack="ack-grep"
alias yad="yandex-disk"
alias yadpub="yandex-disk publish"
alias v="vagrant"
alias fzf='~/bin/fzfrepo/fzf'
alias gaa='git add .'
# }}}

# Projects {{{
p() { if [[ -f $PROJECTS/$1 ]] then cd $PROJECTS/$1; else take $PROJECTS/$1; fi; }
_project() { _files -W $PROJECTS; }
compdef _project p
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

# Fuzzy shell widget {{{
fzf-install() {
    git clone https://github.com/junegunn/fzf.git ~/bin/fzfrepo
}
# CTRL-T - Paste the selected file(s) path into the command line
fzf-file-widget() {
      local FILES
        local IFS="
        "
          FILES=($(
              find * -path '*/\.*' -prune \
                  -o -type f -print \
                      -o -type l -print 2> /dev/null | fzf -m))
            unset IFS
              FILES=$FILES:q
                LBUFFER="${LBUFFER%% #} $FILES"
                  zle redisplay
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

# ALT-C - cd into the selected directory
fzf-cd-widget() {
      cd "${$(find * -path '*/\.*' -prune \
                -o -type d -print 2> /dev/null | fzf):-.}"
                  zle reset-prompt
}
zle     -N    fzf-cd-widget
bindkey '\ec' fzf-cd-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
      LBUFFER=$(history | fzf +s | sed "s/ *[0-9]* *//")
        zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget
# }}}

# vim: foldmethod=marker
