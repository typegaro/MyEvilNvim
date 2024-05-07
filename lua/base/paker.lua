vim.cmd [[packadd packer.nvim]] 
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'nvim-telescope/telescope.nvim'}
  use 'nvim-lua/plenary.nvim'
  use ('nvim-treesitter/nvim-treesitter', {run= ':TSUpdate'})
  use "nvim-lualine/lualine.nvim"
  use "theprimeagen/harpoon"
  use "mbbill/undotree"
  use "tpope/vim-fugitive"
  use({
    'NTBBloodbath/doom-one.nvim',
    setup = function()
        -- Add color to cursor
		vim.g.doom_one_cursor_coloring = false
		-- Set :terminal colors
		vim.g.doom_one_terminal_colors = true
		-- Enable italic comments
		vim.g.doom_one_italic_comments = false
		-- Enable TS support
		vim.g.doom_one_enable_treesitter = true
		-- Color whole diagnostic text or only underline
        vim.g.doom_one_diagnostics_text_color = false
		-- Enable transparent background
		vim.g.doom_one_transparent_background = false

        -- Pumblend transparency
		vim.g.doom_one_pumblend_enable = false
		vim.g.doom_one_pumblend_transparency = 20

        -- Plugins integration
		vim.g.doom_one_plugin_neorg = true
		vim.g.doom_one_plugin_barbar = false
		vim.g.doom_one_plugin_telescope = false
		vim.g.doom_one_plugin_neogit = true
		vim.g.doom_one_plugin_nvim_tree = true
		vim.g.doom_one_plugin_dashboard = true
		vim.g.doom_one_plugin_startify = true
		vim.g.doom_one_plugin_whichkey = true
		vim.g.doom_one_plugin_indent_blankline = true
		vim.g.doom_one_plugin_vim_illuminate = true
		vim.g.doom_one_plugin_lspsaga = false
	end,
	config = function() vim.cmd("colorscheme doom-one") end,
    })
    use "j-hui/fidget.nvim"
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
    }
    use('Exafunction/codeium.vim')

  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } vim.g.mkdp_auto_close = 0 vim.g.mkdp_markdown_css = '/Users/rp/markdown.css' end, ft = { "markdown" }, })
  use 'nvim-tree/nvim-web-devicons'
end)

