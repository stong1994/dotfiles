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
alias gitdiff 'git diff --name-only --diff-filter=d | xargs bat --diff'
alias autodev '/Users/stong/Project/Personal/dev_helper/autodev/autodev.sh'
set -gx EDITOR nvim

set -gx LS_COLORS "$(vivid generate snazzy)" # colorized output of `tree`,`fd`..

fish_add_path /Users/stong/ghq/github.com/stong1994/ghq
fish_add_path /Users/stong/Project/Github/github.com/Raghav-rv28/kitty-sesh

if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.config/fish/integration.fish
end

# color scheme
starship init fish | source
