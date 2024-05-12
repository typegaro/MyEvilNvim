vim.g.mapleader = " "
vim.keymap.set('n', '<leader>vs', ":vsplit<CR>", {})
vim.keymap.set('n', '<leader>hs', ":split<CR>", {})
vim.keymap.set('n', '<leader>ee', ":bprev<CR>", {})
vim.keymap.set('n', '<leader>qq', ":bnext<CR>", {})
vim.keymap.set('n', '<leader>sc', ":setlocal spell<CR>", {})
vim.keymap.set('n', '<leader>lc', ":!pdflatex %:r.tex ; rm *.aux *.log *.toc<CR>",{})
vim.keymap.set('n', '<leader>op', ":!zathura %:r.pdf &<CR>",{})
vim.keymap.set('n', '<leader>mr', ":!make run <CR>",{})

-- nvim candy
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")





