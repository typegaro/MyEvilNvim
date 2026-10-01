local Snacks = require('snacks')

Snacks.setup({
    bigfile = { enabled = true },
    dashboard = { enabled = false},
    explorer = { enabled = false},
    indent = { enabled = false},
    input = { enabled = false },
    picker = { enabled = true, layout = { preset = "ivy" } },
    notifier = { enabled = false},
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false},
    statuscolumn = { enabled = false},
    words = { enabled = false },
})

vim.keymap.set('n', '<leader>ff', function() Snacks.picker.smart() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })

vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })

vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps({ preview = false }) end, { desc = 'Keymaps' })

vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = 'References' })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto Type Definition' })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

vim.keymap.set('n', '<leader>tt', function() Snacks.terminal() end, { desc = 'Terminals' })
vim.keymap.set('n', '<leader>lz', function() Snacks.lazygit() end, { desc = 'lazygit' })
vim.keymap.set('n', '<leader>fc', function()
  Snacks.picker.grep({
    prompt = " ",
    search = "^\\s*class\\s",
    regex = true,
    live = true,
    dirs = { vim.fn.getcwd() },
    args = { "--no-ignore" },
    finder = "grep",
    show_empty = true,
    layout = "ivy",
  })
end, { desc = 'Search for incomplete tasks' })
