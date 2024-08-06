set fish_greeting ""

alias ls "ls -p -G"
alias la "ls -A"
alias ll "eza -l --time-style relative --git"
alias lla "ll -A"
alias lg lazygit
alias vim nvim
alias v nvim
alias v. "nvim ."
alias cat='bat --paging=never'
alias fzfp "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias gitdiff 'git diff --name-only --diff-filter=d | xargs bat --diff'
alias ghcs "gh copilot suggest -t shell"
alias ghcg "gh copilot suggest -t git"
alias ghce "gh copilot explain"
alias gr. "go run ."
alias grm "go run main.go"

set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx GOBIN "$HOME/go/bin/"
set -gx LS_COLORS "$(vivid generate snazzy)" # colorized output of `tree`,`fd`..
set -gx LANG "en_US.UTF-8"
set -gx NO_PROXY 127.0.0.1,localhost
set -gx ANDROID_HOME "$HOME/Library/Android/sdk"

fish_add_path "/Applications/kitty.app/Contents/MacOS/"
fish_add_path "$HOME/.local/share/bob/nvim-bin"
fish_add_path $GOBIN
fish_add_path "/opt/homebrew/opt/node@20/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.config/fish/integration.fish
end

# color scheme
starship init fish | source
# private config
source $HOME/.config/fish/private.fish

function fish_title
    set -q argv[1]; or set argv fish
    echo (basename (prompt_pwd)): $argv
end
