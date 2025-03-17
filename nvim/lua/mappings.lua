require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
-- telescope

map("n", "<Leader>ff", "<cmd>lua require'telescope.builtin'.find_files()<CR>", { desc = "Telescope find files " })
map("n", "<Leader>fg", "<cmd>lua require'telescope.builtin'.live_grep()<CR>", { desc = "Telescope live_grep " })
map("n", "<Leader>fb", "<cmd>lua require'telescope.builtin'.buffers()<CR>", { desc = "Telescope buffers " })
map("n", "<Leader>fh", "<cmd>lua require'telescope.builtin'.help_tags()<CR>", { desc = "Telescope help tags " })
map('n', '<leader>rs', ':RustLsp workspaceSymbol<CR>', { noremap = true, silent = true })

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)


local dap = require('dap')
local dapui = require('dapui')

vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Start/Continue Debugging" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set('n', '<C-b>', function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<C-S-b>', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Set Conditional Breakpoint" })
vim.keymap.set('n', '<C-r>', function() dap.run_last() end, { desc = "Restart Debugging" })
vim.keymap.set('n', '<C-q>', function() dap.terminate() end, { desc = "Quit Debugging" })

-- DAP UI Controls
vim.keymap.set('n', '<F8>', function() dapui.open() end, { desc = "Open Debug UI" })
vim.keymap.set('n', '<F9>', function() dapui.close() end, { desc = "Close Debug UI" })
vim.keymap.set('n', '<Leader>d', function() dapui.toggle() end, { desc = "Toggle Debug UI" })
