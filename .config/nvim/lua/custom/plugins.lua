-- when modifying these plugins, may need to execute :PackerInstall

return function(use)
  -- linter
  use 'dense-analysis/ale'

  -- nicer colour scheme
  use 'EdenEast/nightfox.nvim'

  -- fancier explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193 - this is actually the stable branch)
  }
end
