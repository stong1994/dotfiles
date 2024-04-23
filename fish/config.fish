set fish_greeting ""

alias ls "ls -p -G"
alias la "ls -A"
alias ll "eza -l --time-style relative --git"
alias lla "ll -A"
alias g git
alias lg lazygit
alias vim nvim
alias cat='bat --paging=never'
alias fzfp "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

set -gx EDITOR nvim

fish_add_path /Users/stong/ghq/github.com/stong1994/ghq

if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.config/fish/integration.fish
end

# color scheme
starship init fish | source
