require("config.lazy")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local builtin = require('telescope.builtin')



vim.g.mapleader = " "
vim.keymap.set('n', '<leader>.', ":edit . <CR>", {})
vim.keymap.set('n', '<leader>vs', ":vsplit<CR>", {})
vim.keymap.set('n', '<leader>hs', ":split<CR>", {})
vim.keymap.set('n', '<leader>ee', ":bnex<CR>", {})
vim.keymap.set('n', '<leader>qq', ":bprev<CR>", {})
vim.keymap.set('n', '<leader>bb', ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sc', ":setlocal spell spelllang=it,en<CR>", {})
vim.keymap.set('n', '<leader>lc', ":!pdflatex %:r.tex ; rm *.aux *.log *.toc<CR>", {})
vim.keymap.set('n', '<leader>op', ":!zathura %:r.pdf &<CR>", {})
vim.keymap.set('n', '<leader>mr', ":!make run <CR>", {})
vim.keymap.set('n', '<leader>mc', ":!Rscript -e 'rmarkdown::render(\"%:p\")'<CR>", {})
-- nvim candy
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- harpoon
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', function()
    builtin.grep_string({ search = vim.fn.input("grep ") });
end)
vim.keymap.set('n', '<leader>gD', builtin.git_status, {})
-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gl", ":Git log --graph --oneline --decorate --all<CR>")
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>")
vim.keymap.set("n", "<leader>gP", ":Git push<CR>")
vim.keymap.set("n", "<leader>gp", ":Git pull<CR>")
-- git worktree
vim.keymap.set("n", "<leader>gw", function()
    require("telescope").extensions.git_worktree.git_worktrees()
end, { desc = "Git Worktrees" })

vim.keymap.set("n", "<leader>gW", function()
    require("telescope").extensions.git_worktree.create_git_worktree()
end, { desc = "Create Git Worktree" })
-- CopilotChat
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open Copilot Chat" })
vim.keymap.set("v", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Open Copilot Chat" })
vim.keymap.set("n", "<leader>cq", "<cmd>CopilotChatQuick<CR>", { desc = "Quick Chat" })
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain selected code" })
vim.keymap.set("v", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Generate tests for selection" })
vim.keymap.set("v", "<leader>cf", ":CopilotChatFix<CR>", { desc = "Suggest fixes for selection" })
vim.keymap.set("n", "<leader>cr", ":CopilotChatDocs<CR>", { desc = "Make docs" })
vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatCommit<CR>", { desc = "Generate commit message" })
