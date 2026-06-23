return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'mfussenegger/nvim-jdtls',
        'mfussenegger/nvim-dap',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local autoformat_filetypes = { "lua" }

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end
                if vim.tbl_contains(autoformat_filetypes, vim.bo.filetype) then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                formatting_options = { tabSize = 4, insertSpaces = true },
                                bufnr = args.buf,
                                id = client.id,
                            })
                        end,
                    })
                end
            end,
        })

        local function strip_hover_source_link(value)
            local lines = vim.split(value, "\n", { plain = true })
            local filtered = {}
            for _, line in ipairs(lines) do
                if not (line:match("^Source:%s") and line:match("file://")) then
                    table.insert(filtered, line)
                end
            end
            return table.concat(filtered, "\n"):gsub("\n+$", "")
        end

        -- Plain text hover to avoid Treesitter markdown injection crashes with jdtls.
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(function(err, result, ctx, config)
            config = config or {}
            config.focus_id = ctx.method
            if err then
                vim.notify(err.message, vim.log.levels.ERROR)
                return
            end
            if not (result and result.contents) then return end
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            if client and client.name == "jdtls" and result.contents then
                if type(result.contents) == "string" then
                    result.contents = strip_hover_source_link(result.contents)
                elseif type(result.contents) == "table" then
                    if type(result.contents.value) == "string" then
                        result.contents.value = strip_hover_source_link(result.contents.value)
                    else
                        for index, item in ipairs(result.contents) do
                            if type(item) == "string" then
                                result.contents[index] = strip_hover_source_link(item)
                            elseif type(item) == "table" and type(item.value) == "string" then
                                item.value = strip_hover_source_link(item.value)
                            end
                        end
                    end
                end
            end
            local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
            lines = vim.lsp.util.trim_empty_lines(lines)
            if vim.tbl_isempty(lines) then return end
            return vim.lsp.util.open_floating_preview(lines, "text", config)
        end, { border = 'rounded' })

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
        )

        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = {
                style = 'minimal',
                border = 'rounded',
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = '»',
                },
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            end,
        })

        -- Native nvim 0.10+ LSP config API: replaces mason-lspconfig bridge.
        -- nvim-lspconfig ships lsp/*.lua runtime files that vim.lsp.enable reads.
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    diagnostics = { globals = { 'vim' } },
                    workspace = { library = { vim.env.VIMRUNTIME } },
                },
            },
        })

        -- jdtls is excluded: handled by ftplugin/java.lua via nvim-jdtls
        vim.lsp.enable({ 'lua_ls', 'intelephense', 'ts_ls', 'eslint', 'zls' })

        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = {
                "java-debug-adapter",
                "java-test",
            },
            run_on_start = true,
        })

        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            formatting = {
                fields = { 'abbr', 'menu', 'kind' },
                format = function(entry, item)
                    local n = entry.source.name
                    if n == 'nvim_lsp' then
                        item.menu = '[LSP]'
                    else
                        item.menu = string.format('[%s]', n)
                    end
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs(-5),
                ['<C-e>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = 'select' })
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                ['<C-d>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-b>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
        })
    end,
}
