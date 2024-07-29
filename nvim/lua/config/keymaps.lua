-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here

-- local discipline = require("stong.discipline")
-- discipline.cowboy()

local keymap = require("stong.utils.keymap")

-- To resolve the conflict with Tab and Ctrl-i
keymap.default_map_n("<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap.default_map_n("<C-i>", "<C-i>", { desc = "Define C-i to resove conflict with Tab and Ctrl-i" })
keymap.default_map_n("<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Last Buffer" })
keymap.default_map({ "i" }, "jj", "<Esc>", { desc = "replace Esc" })

-- Copy content to the next line
keymap.default_map_n("np", "m`o<ESC>p>`", { desc = "Copy content to the next line" })

-- Buffer switch
keymap.default_map_n("]b", [[<cmd>bnext<cr>]])
keymap.default_map_n("[b", [[<cmd>bprevious<cr>]])

-- Quick Move
keymap.default_map_n("K", "10k")
keymap.default_map_n("J", "10j")
keymap.default_map({ "n", "x", "o" }, "<S-l>", "$", { desc = "move end of line" })
keymap.default_map({ "n", "x", "o" }, "<S-h>", "^", { desc = "move begin of line" })

-- Select all
keymap.default_map_n("<C-a>", "gg<S-v>G", { desc = "Select all" })

-- New Tab
keymap.default_map_n("te", ":tabedit<Return>", { desc = "Create a new tab" })
keymap.default_map_n("<tab-n>", ":tabnext<Return>", { desc = "Next tab" })
keymap.default_map_n("<tab-p>", ":tabprev<Return>", { desc = "Last tab" })

-- Resize window
keymap.default_map_n("=", [[<cmd>vertical resize +5<cr>]], { desc = "increase window vertical size" }) -- make the window biger vertically
keymap.default_map_n("-", [[<cmd>vertical resize -5<cr>]], { desc = "decrease window vertical size" }) -- make the window smaller vertically
keymap.default_map_n("+", [[<cmd>horizontal resize +2<cr>]], { desc = "increase window horizontal size" }) -- make the window bigger horizontally by pressing shift and =
keymap.default_map_n("_", [[<cmd>horizontal resize -2<cr>]], { desc = "decrease window horizontal size" }) -- make the window smaller horizontally by pressing shift and -

--  Select Window
keymap.default_map_n("<C-h>", "<C-w>h", { desc = "Switch to left window" })
keymap.default_map_n("<C-l>", "<C-w>l", { desc = "Swith to right window" })
keymap.default_map_n("<C-j>", "<C-w>j", { desc = "Switch to below window" })
keymap.default_map_n("<C-k>", "<C-w>k", { desc = "Swith to upper window" })

-- Split window
keymap.default_map_n("ss", ":split<Return>", { desc = "Split window horizontal" })
keymap.default_map_n("sv", ":vsplit<Return>", { desc = "Split window vertical" })
-- keymap.set("n", "sd", "<Space-w>d", opts)

---- Page up/down
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), mode, false)
end

keymap.default_map_n("<C-u>", function()
  local height = math.floor(math.min(vim.fn.winheight(0) / 2, 20))
  feedkey(height .. "<C-u>", "n")
end)
keymap.default_map_n("<C-n>", function()
  local height = math.floor(math.min(vim.fn.winheight(0) / 2, 20))
  feedkey(height .. "<C-d>", "n")
end)

-- Terminal
keymap.default_map_n("<A-CR>", '<Cmd>exe winheight(0)/3."split" | term<CR>', { desc = "Open a new terminal" })
-- keymap.set("n", "<A-CR>", function()
--   require("toggleterm").exec_command("cmd='go run .'")
-- end, { desc = "run project" })
-- keymap.set("n", "<leader>tt", function()
--   require("toggleterm").toggle_all()
-- end, { desc = "toggle all term", noremap = true })
-- keymap.set("n", "<leader>to", function()
--   require("toggleterm").exec_command("cmd='fish'")
-- end, { desc = "toggle all term", noremap = true })
keymap.default_map_n("<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>") -- auto code if err .. in go
keymap.default_map_n("<leader>ep", "oif err != nil {<CR>}<Esc>Opanic(err)<Esc>")

keymap.default_map_n("gh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle lsp inlay hint" })

keymap.default_map_n("yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:."))
  vim.notify("Copied file path", vim.log.levels.INFO)
end, { desc = "Copy file path" })
keymap.default_map_n("yd", function()
  vim.fn.setreg("+", vim.fn.expand("%:h"))
  vim.notify("Copied directory path", vim.log.levels.INFO)
end, { desc = "Copy directory path" })
keymap.default_map_n("yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t:r"))
  vim.notify("Copied fiel name", vim.log.levels.INFO)
end, { desc = "Copy file name" })
keymap.default_map_n("yl", function()
  vim.fn.setreg("+", vim.lsp.get_log_path())
  vim.notify("Copied lsp log path", vim.log.levels.INFO)
end, { desc = "Copy lsp log path" })

keymap.default_map_n("fo", "<cmd>foldopen<CR>", { desc = "Open fold" })
keymap.default_map_n("fi", "<cmd>foldclose<CR>", { desc = "Close fold" })
keymap.default_map_n("sk", "<cmd>Screenkey<CR>", { desc = "ScreenKey" })
