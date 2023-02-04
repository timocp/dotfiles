vim.o.cmdheight = 2
vim.o.expandtab = true
vim.o.splitbelow = true

vim.g.netrw_liststyle = 3

-- colour scheme overrides
--------------------------

-- link ALE VTs defaults to diagnostic style (looks better)
vim.cmd [[highlight link ALEVirtualTextError DiagnosticVirtualTextError]]
vim.cmd [[highlight link ALEVirtualTextWarning DiagnosticVirtualTextWarn]]
vim.cmd [[highlight link ALEVirtualTextInfo DiagnosticVirtualTextInfo]]
-- only use italics for virtualtext
vim.cmd [[highlight DiagnosticVirtualTextError gui=italic]]
vim.cmd [[highlight DiagnosticVirtualTextWarn gui=italic]]
vim.cmd [[highlight DiagnosticVirtualTextInfo gui=italic]]
-- replace underlines with subtle red background (was SpellBad, SpellCap)
vim.cmd [[highlight ALEError guibg=#660000]]
vim.cmd [[highlight ALEWarning guibg=#440000]]

-- mappings
-----------

vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Search Files' })

vim.keymap.set('n', '<leader>b', "<cmd>Git blame<cr>", { desc = 'Git blame' })

vim.keymap.set('n', ';', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('', 'Q', "gq", { desc = 'Wrap text' })

vim.keymap.set('n', '<F2>', "<cmd>Explore<cr>", { desc = 'Open explorer' })
vim.keymap.set('n', '<F3>', "<cmd>Sexplore<cr>", { desc = 'Split open explorer' })
vim.keymap.set('n', '<F6>', function () vim.cmd [[exe "!gitk " . shellescape(expand("%")) . " &"]] end, { desc = 'Run gitk' })
