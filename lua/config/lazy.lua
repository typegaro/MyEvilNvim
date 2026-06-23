-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.clipboard = "unnamedplus"
vim.opt.spelllang = "it_it,en_us"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
        {
            "NTBBloodbath/doom-one.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.g.doom_one_transparent_background = true
                vim.cmd.colorscheme("doom-one")
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            event = { "BufReadPost", "BufNewFile" },
            build = ":TSUpdate",
            config = function()
                require('nvim-treesitter.configs').setup({
                    highlight = {
                        enable = true,
                        -- nvim-treesitter markdown queries use conceal_lines which
                        -- calls :range() on a nil node in nvim 0.12 (API changed).
                        -- Disable for markdown and let nvim's built-in handle it.
                        disable = { "markdown", "markdown_inline" },
                    },
                    indent = { enable = true },
                })
            end,
        },
        {
            "mbbill/undotree",
            cmd = "UndotreeToggle",
        },
        {
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            opts = {
            current_line_blame = true,
            current_line_blame_opts = { delay = 300 },
            },
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && npm install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        {
            'chomosuke/typst-preview.nvim',
            ft = 'typst',
            version = '1.*',
            opts = {},
        },
    },
})
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#B0B0B0' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFFFFF', bold = true })
