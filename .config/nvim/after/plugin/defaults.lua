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
