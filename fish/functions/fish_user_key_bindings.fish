
function fish_user_key_bindings
    # fzf
    bind \cf fzf_change_directory

    # vim-like
    bind \cl forward-char
    bind \cw forward-word
    bind \ca end-of-line
    bind \ch backward-char
    bind \cb backward-word
    bind \ci beginning-of-line
    bind \t complete
end
