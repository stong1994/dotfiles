-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here

local discipline = require("stong.discipline")
discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- To resolve the conflict with Tab and Ctrl-i
keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap.set("n", "<C-i>", "<C-i>", opts)
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

-- Copy content to the next line
vim.keymap.set("n", "<C-p>", "m`o<ESC>p>`", opts)

-- Buffer switch
vim.keymap.set("n", "]b", [[<cmd>bnext<cr>]])
vim.keymap.set("n", "[b", [[<cmd>bprevious<cr>]])

-- Quick Move
vim.keymap.set("n", "J", "10j")
vim.keymap.set("n", "K", "10k", { noremap = true })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New Tab
keymap.set("n", "te", ":tabedit<Return>", opts)
keymap.set("n", "<tab-n>", ":tabnext<Return>", opts)
keymap.set("n", "<tab-p>", ":tabprev<Return>", opts)

-- Resize window
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

--  Select Window
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- keymap.set("n", "sd", "<Space-w>d", opts)

---- Page up/down
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), mode, false)
end

keymap.set("n", "<C-u>", function()
  local height = math.floor(math.min(vim.fn.winheight(0) / 2, 20))
  feedkey(height .. "<C-u>", "n")
end)
keymap.set("n", "<C-d>", function()
  local height = math.floor(math.min(vim.fn.winheight(0) / 2, 20))
  feedkey(height .. "<C-d>", "n")
end)

-- Terminal
keymap.set("n", "<A-CR>", '<Cmd>exe winheight(0)/3."split" | term<CR>', opts)
-- keymap.set("n", "<A-CR>", function()
--   require("toggleterm").exec_command("cmd='go run .'")
-- end, { desc = "run project" })
-- keymap.set("n", "<leader>tt", function()
--   require("toggleterm").toggle_all()
-- end, { desc = "toggle all term", noremap = true })
-- keymap.set("n", "<leader>to", function()
--   require("toggleterm").exec_command("cmd='fish'")
-- end, { desc = "toggle all term", noremap = true })
