vim.g.mapleader = " "
vim.keymap.set('n', '<leader>vs', ":vsplit<CR>", {})
vim.keymap.set('n', '<leader>hs', ":split<CR>", {})
vim.keymap.set('n', '<leader>ee', ":bprev<CR>", {})
vim.keymap.set('n', '<leader>qq', ":bnext<CR>", {})
vim.keymap.set('n', '<leader>sc', ":setlocal spell<CR>", {})
vim.keymap.set('n', '<leader>lc', ":!pdflatex %:r.tex ; rm *.aux *.log *.toc<CR>",{})
