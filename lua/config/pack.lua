vim.pack.add({
    'https://github.com/NTBBloodbath/doom-one.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
    'https://github.com/mbbill/undotree',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/iamcco/markdown-preview.nvim',
    { src = 'https://github.com/chomosuke/typst-preview.nvim', version = vim.version.range('1') },
    'https://github.com/folke/snacks.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/echasnovski/mini.icons',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    'https://github.com/mfussenegger/nvim-jdtls',
    'https://github.com/mfussenegger/nvim-dap',
}, { confirm = false, load = true })

vim.g.doom_one_transparent_background = true
vim.cmd.colorscheme('doom-one')

require('nvim-treesitter').setup({})
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        if vim.tbl_contains({ 'markdown', 'markdown_inline' }, vim.bo[args.buf].filetype) then
            return
        end
        pcall(vim.treesitter.start, args.buf)
        vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
    end,
})

require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = { delay = 300 },
})

vim.g.mkdp_filetypes = { 'markdown' }
require('typst-preview').setup({})
