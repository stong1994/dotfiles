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

    # prevent iterm2 from closing when typing Ctrl-D (EOF)
    bind \cd delete-char
end

# Call the function
#fish_user_key_bindings
# fzf plugin
# fzf_configure_bindings --directory=\co
