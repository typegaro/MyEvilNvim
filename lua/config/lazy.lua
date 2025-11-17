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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
vim.o.termguicolors = true

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { 'nvim-telescope/telescope.nvim' },
        {
            "NTBBloodbath/doom-one.nvim",
            config = function()
                vim.g.doom_one_transparent_background = false
                vim.cmd.colorscheme("doom-one")
            end,
        },
        { "nvim-treesitter/nvim-treesitter" },
        { "theprimeagen/harpoon" },
        { "mbbill/undotree" },
        { "neovim/nvim-lspconfig" },
        { 'saadparwaiz1/cmp_luasnip' },
        {
            "lewis6991/gitsigns.nvim",
            opts = {
            current_line_blame = true, 
            current_line_blame_opts = { delay = 300 },
            },
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && yarn install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        {
            'chomosuke/typst-preview.nvim',
            lazy = false, -- or ft = 'typst'
            version = '1.*',
            opts = {},    -- lazy.nvim will implicitly calls `setup {}`
        },
    },
})
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#B0B0B0' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFFFFF', bold = true })
