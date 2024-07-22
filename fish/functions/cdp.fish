function cdp
    set arg $argv[1]
    if string match -qr "^\d+\$" -- $arg
        set -l num (string trim -l -c "-" -- $arg)
        set -l path (string repeat -n $num ../ )
        builtin cd $path
    else
        builtin cd $argv
    end
end
