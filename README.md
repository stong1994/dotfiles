<!-- markdownlint-disable MD013  -->

# Stong's dotfiles

## Fish

Fish is a interactive shell, you can find anything about it in the [document](https://fishshell.com/docs/current/index.html).

### Setup

- [Fisher](https://github.com/jorgebucaran/fisher) - Plugin manager
- [Z](https://github.com/jethrokuan/z) - A tool to jumping to the recent directory
- [peco](https://github.com/peco/peco) - Enhance search, eg. command history, project name
- [eza](https://github.com/eza-community/eza) - A replacement for ls.
- [startship](https://starship.rs/) - color shceme.
-

### Shortcut

| Shortcut    | Description                                                | Implementation              |
| ----------- | ---------------------------------------------------------- | --------------------------- |
| ctrl-r      | Search command history                                     | peco                        |
| ctrl-f      | Search the configured directories                          | fzf                         |
| z {keyword} | Jump to the last directory which name contains the keyword | z for fish                  |
| ctrl-l      | Forward a char like vim in command line                    | fish_user_key_bindings.fish |
| ctrl-w      | Forward a word like vim in command line                    | fish_user_key_bindings.fish |
| ctrl-a      | Move to the end of line like vim in command line           | fish_user_key_bindings.fish |
| ctrl-h      | Backward a char like vim in command line                   | fish_user_key_bindings.fish |
| ctrl-b      | Backward a word like vim in command line                   | fish_user_key_bindings.fish |
| ctrl-i      | Move to the begin of line like vim in command line         | fish_user_key_bindings.fish |

## Neovim

### ui

recommend color scheme: [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

| Shortcut   | Description         | implementation      |
| ---------- | ------------------- | ------------------- |
| <leader>uC | change color scheme |                     |
| <leader>uz | zen mode            | folke/zen-mode.nvim |

### git

| Shortcut   | Description                   | implementation |
| ---------- | :---------------------------- | -------------- |
| <leader>gg | git gui                       | lazygit        |
| <leader>gb | git blame line                |                |
| <leader>gc | git commits                   | "              |
| <leader>gf | current file's commit history | lazygit        |

### editor

| Shortcut     | Description                                               | implementation            |
| ------------ | :-------------------------------------------------------- | ------------------------- |
| ctrl-o       | go to older position in jump list                         | :h jumplist               |
| ctrl-i       | go to newer position in jump list                         | :h jumplist               |
| g;           | go to older position in change list                       | :h jumplist               |
| g,           | go to newer position in change list                       | :h jumplist               |
| J            | a keymap to 5j                                            |                           |
| K            | a keymap to 5k                                            |                           |
| ctrl-p       | paste to next line                                        |                           |
| ctrl-a       | copy the whole content of the file                        |                           |
| ctrl-s       | save the file                                             |                           |
| +            | expand the visual selection                               | terryma/vim-expand-region |
| -            | shrink the visual selection                               | terryma/vim-expand-region |
| w            | forward next word like w but can recognize cojoined words | chrisgrieser/nvim-spider  |
| e            | forward next word like e but can recognize cojoined words | chrisgrieser/nvim-spider  |
| b            | forward next word like b but can recognize cojoined words | chrisgrieser/nvim-spider  |
| <leader>sf   | tag all words to jump                                     | phaazon/hop.nvim          |
| option-left  | move to left (todo option-l not work)                     | mini.move                 |
| option-right | move to right                                             | mini.move                 |
| option-up    | move to up                                                | mini.move                 |
| option-down  | move to down                                              | mini.move                 |
| <leader>cs   | symbol outline                                            |                           |
| gd           | goto defination                                           | telescope                 |
| gr           | goto reference                                            | telescope                 |
| ;e           | goto diagnostics                                          | telescope                 |
| ;s           | list function name, variables                             | telescope                 |
| ;;           | resume telescope command                                  | telescope                 |
| ctrl-u       | scroll up                                                 |                           |
| ctrl-d       | scroll down                                               |                           |
| tl           | translate current word                                    | voldikss/vim-translator   |
| <leader>ee   | auto generate if err != nil ... in go                     |                           |

### windows

| Shortcut   | Description                   | implementation |
| ---------- | :---------------------------- | -------------- |
| ss         | Horizontal split window       |                |
| sv         | Veritical split window        |                |
| <leader>wd | Close current window          |                |
| =          | Horizontal expand window size |                |
| -          | Horizontal shrink window size |                |
| +          | Vertical expand window size   |                |
| -          | Vertical shrink window size   |                |
| ctrl-h     | choose left window            |                |
| ctrl-j     | choose below window           |                |
| ctrl-k     | choose above window           |                |
| ctrl-l     | choose right window           |                |
| option-cr  | show terminal below           |                |

### file system

| Shortcut      | Description                                                                  | implementation                |
| ------------- | :--------------------------------------------------------------------------- | ----------------------------- |
| ;f            | find files under root                                                        | telescope.nvim                |
| ;r            | find words in files under root                                               | telescope.nvim                |
| ;br           | find words in buffers                                                        | telescope.nvim                |
| ;p            | find projects                                                                | GnikDroy/projections.nvim     |
| ;b            | find buffers                                                                 | telescope.nvim                |
| [b            | last buffers                                                                 |                               |
| ]b            | next buffers                                                                 |                               |
| ;e            | Lists Diagnostics for all open buffers or a specific buffer                  | telescope.nvim                |
| ;;            | resume the previous telescope picker                                         | telescope.nvim                |
| ;s            | Lists Function names, variables                                              | telescope.nvim                |
| ;t            | Lists available help tags and opens a new window with the relevant help info | telescope.nvim                |
| sf            | Open File Browser with the path of the current buffer                        | telescope.vim                 |
| <leader>e     | explore neotree(root dir)                                                    |                               |
| <leader>E     | explore neotree(cmd dir)                                                     |                               |
| <leader>H     | add file to harpoon                                                          | ThePrimeagen/harpoon          |
| <leader>h     | get files from harpoon                                                       | ThePrimeagen/harpoon          |
| <leader>{num} | choose the file from harpoon                                                 | ThePrimeagen/harpoon          |
| te            | create a new tab (save with :w filename)                                     |                               |
| <tab>         | next tab                                                                     |                               |
| ctrl-x        | Go to file selection as a split                                              | nvim-telescope/telescope.nvim |
| ctrl-v        | Go to file selection as a vsplit                                             | nvim-telescope/telescope.nvim |
| <leader>fP    | list the neovim plugin files                                                 | telescope                     |

## kitty

Kitty is a fast GPU-based terminal emulator.
You can change the color scheme with command:

```
kitten themes
```

| Shortcut              | Description                     | implementation |
| --------------------- | :------------------------------ | -------------- |
| command-{i}           | move to the tab that index is i |                |
| command + enter       | new window                      |                |
| command + n           | new OS window                   |                |
| shift + command + d   | close window                    |                |
| shift+command + left  | resize window narrower          |                |
| shift+command + right | resize window wider             |                |
| shift+command + up    | resize window taller            |                |
| shift+command + down  | resize window shorter           |                |
| shift+command + [     | previous window                 |                |
| shift+command + ]     | next window                     |                |
| shift+command + b     | move window backward(not work)  |                |
| shift+command + f     | move window forward             |                |
| shift+command + k     | move window top                 |                |

## Base Tool

- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration) - A fuzzy finder, can be used with any list.

- [ghq](https://github.com/x-motemen/ghq) - Manage remote repository clones.

- [fd](https://github.com/sharkdp/fd) - A replacement for find.

- [rg](https://github.com/BurntSushi/ripgrep) - A tool that search file contents for a regex pattern.

-
