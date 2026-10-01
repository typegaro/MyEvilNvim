local autoformat_filetypes = { 'lua' }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, opts)

        if vim.tbl_contains(autoformat_filetypes, vim.bo[args.buf].filetype) then
            vim.api.nvim_create_autocmd('BufWritePre', {
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

vim.keymap.set('i', '<C-Space>', function()
    vim.lsp.completion.get()
end, { desc = 'Trigger LSP completion' })

local function strip_hover_source_link(value)
    local lines = vim.split(value, '\n', { plain = true })
    local filtered = {}
    for _, line in ipairs(lines) do
        if not (line:match('^Source:%s') and line:match('file://')) then
            table.insert(filtered, line)
        end
    end
    return table.concat(filtered, '\n'):gsub('\n+$', '')
end

-- Plain text hover avoids Treesitter markdown injection crashes with jdtls.
vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
    config = vim.tbl_deep_extend('force', { border = 'rounded' }, config or {})
    config.focus_id = ctx.method
    if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
    end
    if not (result and result.contents) then return end
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client and client.name == 'jdtls' and result.contents then
        if type(result.contents) == 'string' then
            result.contents = strip_hover_source_link(result.contents)
        elseif type(result.contents) == 'table' then
            if type(result.contents.value) == 'string' then
                result.contents.value = strip_hover_source_link(result.contents.value)
            else
                for index, item in ipairs(result.contents) do
                    if type(item) == 'string' then
                        result.contents[index] = strip_hover_source_link(item)
                    elseif type(item) == 'table' and type(item.value) == 'string' then
                        item.value = strip_hover_source_link(item.value)
                    end
                end
            end
        end
    end
    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    lines = vim.lsp.util.trim_empty_lines(lines)
    if vim.tbl_isempty(lines) then return end
    return vim.lsp.util.open_floating_preview(lines, 'text', config)
end

vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
    config = vim.tbl_deep_extend('force', { border = 'rounded' }, config or {})
    return vim.lsp.handlers.signature_help(err, result, ctx, config)
end

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = { vim.env.VIMRUNTIME } },
        },
    },
})

vim.lsp.config('intelephense', {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { 'composer.json', '.git' },
})

vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('eslint', {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = {
        '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml',
        '.eslintrc.yml', '.eslintrc.json', 'eslint.config.js', 'package.json', '.git',
    },
    settings = {
        validate = 'on',
        packageManager = 'npm',
        useESLintClass = false,
        experimental = { useFlatConfig = false },
    },
})

vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
})

-- jdtls is excluded: handled by ftplugin/java.lua via nvim-jdtls.
vim.lsp.enable({ 'lua_ls', 'intelephense', 'ts_ls', 'eslint', 'zls' })

require('mason').setup({})
require('mason-tool-installer').setup({
    ensure_installed = {
        'java-debug-adapter',
        'java-test',
    },
    run_on_start = true,
})
