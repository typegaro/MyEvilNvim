require("config.lazy")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>.', function()
    vim.cmd("edit " .. vim.fn.expand("%:p:h"))
end, {})
vim.keymap.set('n', '<leader>vs', ":vsplit<CR>", {})
vim.keymap.set('n', '<leader>hs', ":split<CR>", {})
vim.keymap.set('n', '<leader>bb', ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sc', ":setlocal spell spelllang=it,en<CR>", {})
vim.keymap.set('n', '<leader>lc', ":!pdflatex %:r.tex <CR>", {})
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
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>q", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>w", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>r", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>t", function() ui.nav_file(4) end)
-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>gD', builtin.git_status, {})
-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)


vim.keymap.set("n", "<leader>ai", function()
  vim.cmd("vsplit")        
  vim.cmd("wincmd l")      
  vim.cmd("vertical resize 60")    
  vim.cmd("term opencode")
end, { desc = "Open opencode in right vertical split" })

vim.keymap.set("n", "<leader>oai", function()
  vim.cmd("vsplit")        
  vim.cmd("wincmd l")      
  vim.cmd("vertical resize 60")    
  vim.cmd("term codex")
end, { desc = "Open opencode in right vertical split" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

