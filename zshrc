source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles {{{
antigen bundle git
antigen bundle github
antigen bundle symfony 
antigen bundle vagrant 
antigen bundle composer
antigen bundle extract
antigen bundle sindresorhus/pure
antigen bundle voronkovich/sf2.plugin.zsh
antigen bundle voronkovich/apache2.plugin.zsh
antigen bundle voronkovich/mysql.plugin.zsh
antigen bundle voronkovich/gitignore.plugin.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zaw
antigen bundle zsh-users/zsh-completions
antigen bundle jocelynmallon/zshmarks
fpath=(~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git/src $fpath)
# }}}

# Load the theme.
#antigen theme dst

# Tell antigen that you're done.
antigen apply

ZSH_THEME="pure"

# Exporting variables {{{
export PATH=$PATH:~/bin:~/eclipse:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export EDITOR=vim
export PAGER=most
export PROJECTS=~/workspace
export ZSH_PLUGIN_APACHE_SITES_CUSTOM_TEMPLATES=~/.sites_templates
# }}}

# History settings {{{
setopt hist_ignore_all_dups
# }}}

# Aliases {{{
alias zshrs="source ~/.zshrc"
alias zshrc="e ~/.zshrc"
alias zshrc-update="git --work-tree ~/.zsh/zshrc pull"
alias vim="stty stop '' -ixoff ; vim"
alias e="$EDITOR"
alias ec="eclim -command"
alias ecpc="eclim -command project_create -f"
alias ecpu="eclim -command project_update -p"
alias eclim-start="tmux new-session -s eclim eclimd"
alias ack="ack-grep"
alias yad="yandex-disk"
alias yadpub="yandex-disk publish"
alias v="vagrant"
alias fzf='~/bin/fzfrepo/fzf'
alias gaa='git add .'
alias root='sudo -s'
# }}}

# Projects {{{
p() { if [[ -f $PROJECTS/$1 ]] then cd $PROJECTS/$1; else take $PROJECTS/$1; fi; }
_project() { _files -W $PROJECTS; }
compdef _project p
project-widget() {
    local dir=$(find $PROJECTS -maxdepth 1 -type d -o -type l ! -name '.*' | xargs basename -a | tail -n +2 | fzf)
    cd $PROJECTS/$dir
    echo; prompt_pure_precmd; # Fix pure theme
    zle reset-prompt
    zle redisplay
}
zle     -N    project-widget
bindkey '^[;' project-widget
# }}}

# Bookmarks {{{
fuzzygo-widget() {
    go $(cut -d '|' -f 2 ~/.bookmarks | fzf)
    echo; prompt_pure_precmd; # Fix pure theme
    zle reset-prompt
}
zle     -N    fuzzygo-widget
bindkey '^[g' fuzzygo-widget
# }}}

# Automatically run ls on blank line for faster navigation {{{
auto-ls () {
    if [[ $#BUFFER -eq 0 ]]; then
        echo
        ls
        prompt_pure_precmd; # Fix pure theme
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
    local IFS=""
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

# CTRL-Q - cd into the selected directory
fzf-cd-widget() {
      cd "${$(find * -path '*/\.*' -prune \
          -o -type d -print 2> /dev/null | fzf):-.}"
      echo; prompt_pure_precmd; # Fix pure theme
      zle redisplay
}
zle     -N   fzf-cd-widget
bindkey '^Q' fzf-cd-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
      LBUFFER=$(history | fzf +s | sed "s/ *[0-9]* *//")
      zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

fzf-cd-history-widget() {
    cd $(dirs -pl | fzf) 
}
zle     -N   fzf-cd-history-widget
bindkey '\ec' fzf-cd-history-widget
# }}}

# vim: foldmethod=marker
