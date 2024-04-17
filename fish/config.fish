set fish_greeting ""

set -gx TERM xterm-256color

# theme
# set -g theme_color_scheme terminal-dark
# set -g theme_color_scheme shellder
# set -g fish_prompt_pwd_dir_length 1
# set -g theme_display_user no
# set -g theme_hide_hostname no
# set -g theme_hostname no

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "eza -l --time-style relative --git"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
starship init fish | source
