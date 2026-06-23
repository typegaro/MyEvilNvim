vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.keymap.set('n', '<leader>.', function()
    vim.cmd.Oil(vim.fn.expand('%:p:h'))
end, { desc = 'Open file directory in Oil' })
vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open Oil' })
vim.keymap.set('n', '<leader>vs', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>hs', '<cmd>split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>sc', '<cmd>setlocal spell! spelllang=it,en<CR>', { desc = 'Toggle spell check' })
vim.keymap.set('n', '<leader>lc', '<cmd>!pdflatex %:r.tex<CR>', { desc = 'Compile LaTeX' })
vim.keymap.set('n', '<leader>op', '<cmd>!zathura %:r.pdf &<CR>', { desc = 'Open PDF' })
vim.keymap.set('n', '<leader>mr', '<cmd>!make run<CR>', { desc = 'Run make target' })
vim.keymap.set('n', '<leader>mc', [[<cmd>!Rscript -e 'rmarkdown::render("%:p")'<CR>]], { desc = 'Render R markdown' })
vim.keymap.set('n', '<leader>lu', '<cmd>Lazy update<CR>', { desc = 'Lazy update plugins' })
vim.keymap.set('n', '<leader>lC', '<cmd>Lazy check<CR>', { desc = 'Lazy check plugin updates' })
vim.keymap.set('n', '<leader>ls', '<cmd>Lazy sync<CR>', { desc = 'Lazy sync plugins' })

vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle undo tree' })


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
