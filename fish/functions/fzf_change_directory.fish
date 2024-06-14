
function _fzf_change_directory
    fzf | perl -pe 's/([ ()])/\\\\$1/g' | read foo
    if [ $foo ]
        cd $foo
        commandline -r ''
        commandline -f repaint
    else
        commandline ''
    end
end

function fzf_change_directory
    begin
        echo $HOME/.config
        fd --type d --max-depth 1 . $HOME/.config
        # todo we use --hidden because we need search the directory with '.git', but with --hidden, we will search with all directory with prefix '.', wait fd to optimize it
        ghq root --all | xargs -I {} fd --type d --max-depth 6 --hidden .git {} | sed 's/\/\.git//'
        $HOME/.local/share/nvim/lazy | xargs -I {} fd --type d --max-depth 4 --hidden .git {} | sed 's/\/\.git//'
        ls -ad */ | perl -pe "s#^#$PWD/#" | grep -v \.git
    end | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end
