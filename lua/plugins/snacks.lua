return {
  "folke/snacks.nvim",
  opts = {
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
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.smart() end, desc = "Find Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },

    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },

    { "<leader>sk", function() Snacks.picker.keymaps({ preview = false }) end, desc = "Keymaps" },

    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

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
