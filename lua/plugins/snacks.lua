return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = { preset = "ivy" },
    },
    bigfile = { enabled = true },
    dashboard = { enabled = false},
    explorer = { enabled = false},
    indent = { enabled = false},
    input = { enabled = false },
    picker = { enabled = true },
    notifier = { enabled = false},
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false},
    statuscolumn = { enabled = false},
    words = { enabled = false },
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader>f", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    --{ "<leader>t", function() Snacks.explorer() end, desc = "File Explorer" },
    -- git
    { "<leader>gdd", function() Snacks.picker.git_diff() end, desc = "Find Git Files" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- utility
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    -- LSP
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "<leader>gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<leader>gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "<leader>gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "<leader>gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- terminal
    { "<leader>tt", function() Snacks.terminal() end, desc = "Terminals" },
    { "<leader>lz", function() Snacks.lazygit() end, desc = "lazygit" },
    {
        "<leader>fc",
        function()
          Snacks.picker.grep({
            prompt = " ",
            search = "^\\s*class\\s",
            regex = true,
            live = true,
            dirs = { vim.fn.getcwd() },
            args = { "--no-ignore" },
            finder = "grep",
            --format = "file",
            show_empty = true,
            --supports_live = false,
            layout = "ivy",
          })
        end,
        desc = "Search for incomplete tasks",
      },
  },
}
