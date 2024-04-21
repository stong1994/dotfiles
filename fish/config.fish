set fish_greeting ""

alias ls "ls -p -G"
alias la "ls -A"
alias ll "eza -l --time-style relative --git"
alias lla "ll -A"
alias g git
alias lg lazygit
alias vim nvim

set -gx EDITOR nvim


if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.config/fish/integration.fish
end

# color scheme
starship init fish | source
