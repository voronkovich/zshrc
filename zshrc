# Bootstrap {{{
source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

Bundle() {
    antigen bundle $*
}
# }}}

# Bundles {{{
Bundle git
Bundle github
# Bundle symfony2
Bundle vagrant
Bundle composer
Bundle extract
Bundle npm
Bundle yarn
Bundle bower
Bundle mafredri/zsh-async
Bundle sindresorhus/pure
Bundle voronkovich/phpcs.plugin.zsh
Bundle /home/oleg/workspace/project.plugin.zsh --no-local-clone
Bundle /home/oleg/workspace/phpunit.plugin.zsh --no-local-clone
Bundle /home/oleg/workspace/symfony.plugin.zsh --no-local-clone
Bundle voronkovich/apache2.plugin.zsh
Bundle voronkovich/mysql.plugin.zsh
# Bundle /home/oleg/workspace/mysql.plugin.zsh --no-local-clone
# Bundle voronkovich/gitignore.plugin.zsh
Bundle /home/oleg/workspace/gitignore.plugin.zsh --no-local-clone
Bundle voronkovich/get-jquery.plugin.zsh
Bundle zsh-users/zsh-syntax-highlighting
Bundle zsh-users/zsh-completions src
Bundle supercrabtree/k
Bundle willghatch/zsh-snippets
Bundle uvaes/fzf-marks
Bundle unixorn/autoupdate-antigen.zshplugin
Bundle rg3/youtube-dl
# }}}

# Tell antigen that you're done.
antigen apply

ZSH_THEME="pure"

# Exporting variables {{{
export LC_ALL=en_US.UTF-8
export PATH=$PATH:~/bin:~/eclipse:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export EDITOR=vim
export PAGER=most
export PROJECTS=~/workspace
export ZSH_PLUGIN_APACHE_SITES_CUSTOM_TEMPLATES=~/.sites_templates
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="$HOME/.gitignore:$ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS"
export PATH="/usr/local/heroku/bin:$PATH"
# }}}

# History settings {{{
setopt hist_ignore_all_dups
# }}}

# Aliases {{{
alias ack="ag"
alias e="$EDITOR"
alias ec="eclim -command"
alias eclim-start="tmux new-session -s eclim eclimd"
alias ecpc="eclim -command project_create -f"
alias ecpu="eclim -command project_update -p"
alias fzf='~/bin/fzf/fzf'
alias gaa='git add .'
alias ide="tmux -2 new-session $EDITOR \; split-window \; resize-pane -D 4"
alias j='jump'
alias localhost8080='sudo iptables -t nat -A OUTPUT -d localhost -p tcp --dport 80 -j REDIRECT --to-port 8080'
alias root='sudo -s'
alias sfide="tmux -2 new-session -s symfony -n terminal \; new-window -n code $EDITOR \; split-window 'php app/console --shell --process-isolation' \; resize-pane -D 4 \; select-pane -U"
alias v="vagrant"
alias vb='virtualbox'
alias vim="stty stop '' -ixoff ; vim"
alias vspec=~/.vim/bundle/vim-vspec/bin/vspec
alias yad="yandex-disk"
alias yadpub="yandex-disk publish"
alias zshrc-pull="echo '**** Pulling .zshrc'; git --git-dir ~/.zsh/.git --work-tree ~/.zsh pull; echo; antigen update; zshrc-reload"
alias zshrc-push="git --git-dir ~/.zsh/.git --work-tree ~/.zsh add . && git --git-dir ~/.zsh/.git --work-tree ~/.zsh commit && git --git-dir ~/.zsh/.git --work-tree ~/.zsh push"
alias zshrc-reload="source ~/.zshrc"
alias zshrc="$EDITOR ~/.zshrc"
if $(which htop &>/dev/null); then
    alias top=htop
fi
# }}}

# {{{ Hashes
hash -d desk=~/Desktop
hash -d docs=~/Documents
hash -d down=~/Downloads
hash -d yad=~/Yandex.Disk
hash -d logs=/var/log
hash -d config=~/.config
# }}}

# Functions {{{
gac() {
    git add -A;
    git ls-files --deleted -z | xargs -r0 git rm;
    if [[ $# -gt 0 ]]; then
        git commit -m "$*"
    else
        git commit
    fi
}
genpass() {
    pwgen -0A ${1:-12} 1
}
upsearch () {
    slashes=${PWD//[^\/]/}
    directory="$PWD"
    for (( n=${#slashes}; n>0; --n ))
    do
        test -e "$directory/$1" && echo "$directory/$1" && return
        directory="$directory/.."
    done
}
# }}}

# Automatically run ls on blank line for faster navigation {{{
auto-ls () {
    if [[ $#BUFFER -eq 0 ]]; then
        echo
        k
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

# Fuzzy shell {{{
fzf-install() {
    git clone https://github.com/junegunn/fzf.git ~/bin/fzf
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
