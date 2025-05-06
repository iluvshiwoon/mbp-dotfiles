local keymap = vim.keymap

-- keymap
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
local todo_comments = require("todo-comments")
keymap.set("n", "[t", function() todo_comments.jump_next() end, { desc = "Next todo comment" })
keymap.set("n", "]t", function() todo_comments.jump_prev() end, { desc = "Previous todo comment" })
keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
keymap.set({ "n", "v" }, "<leader>mp", function()
	require('conform').format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file or range (in visual mode)" })
keymap.set("n", "<leader>l", function()
	require('lint').try_lint()
end, { desc = "Trigger linting for current file" })
-- substitute
local substitute = require('substitute')
keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })

-- trouble
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Open/close trouble list" })
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>",
    { desc = "Open trouble workspace diagnostics" })
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>",
    { desc = "Open trouble document diagnostics" })
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open trouble quickfix list" })
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Open trouble location list" })
keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>", { desc = "Open todos in trouble" })

-- bufferline
keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close right tabs" })
keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close left tabs" })
keymap.set("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other tabs" })
keymap.set("n", "<leader>bf", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

-- windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make window equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
keymap.set("n", "<leader>sm", "<cmd>lua require('windex').toggle_nvim_maximize()<CR>", { desc = "Maximize window" })

-- tree
keymap.set("n", "<leader>ef", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeClose<CR>", { desc = "Close file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
keymap.set("n", "<leader>a", mark.add_file)
keymap.set("n", "<C-e>", ui.toggle_quick_menu)
keymap.set("n", "<leader>j", function() ui.nav_file(1) end)
keymap.set("n", "<leader>k", function() ui.nav_file(2) end)
keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

--telescope
local builtin = require('telescope.builtin')

keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Fuzzy find files" })
keymap.set("n", "<Leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
keymap.set("n", "<Leader>fs", builtin.live_grep, { desc = "Find string" })
keymap.set("n", "<Leader>fc", builtin.grep_string, { desc = "Find string under cursor" })
keymap.set("n", "<Leader>H", builtin.keymaps, { desc = "List keymaps" })
keymap.set("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
keymap.set("n", "<Leader>T", builtin.treesitter, { desc = "List function / variables" })

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Primeagen
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<leader>p", [["_dP]])
keymap.set("n", "<leader>P", [["+p]])

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- dap
keymap.set({ "n" }, "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
keymap.set({ "n" }, "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })
