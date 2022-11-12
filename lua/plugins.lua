local utils = require("utils")
local fn = vim.fn

vim.g.package_home = fn.stdpath("data") .. "/site/pack/packer/"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

local plug_url_format = "https://github.com/%s"

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require('packer.util')

require("packer").startup({
  function(use)
    -- it is recommened to put impatient.nvim before any other plugins
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

    use({"wbthomason/packer.nvim", opt = true})

    use {"onsails/lspkind-nvim", event = "BufEnter"}
    -- auto-completion engine
    use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]]}

    -- nvim-cmp completion sources
    use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    -- use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
    use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
    use {"jose-elias-alvarez/null-ls.nvim",
        config = [[require('config.null-ls')]],
        -- requires = { 'nvim-lua/plenary.nvim' },
        -- rocks = {{ 'plenary.nvim', server = 'https://luarocks.org/dev'}, 'gitsigns.nvim'},
    }

    use { 'williamboman/mason.nvim', config = [[require('config.mason')]]}
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'simrat39/rust-tools.nvim' }

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })

    use({ "nvim-treesitter/nvim-treesitter", event = 'BufEnter', run = ":TSUpdate", config = [[require('config.treesitter')]] })

    -- Python indent (follows the PEP8 style)
    use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

    -- Super fast buffer jump
    use {
      'phaazon/hop.nvim',
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.nvim_hop') end, 2000)
      end
    }

    -- Show match number and index for searching
    use {
      'kevinhwang91/nvim-hlslens',
      branch = 'main',
      keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
      config = [[require('config._hlslens')]]
    }

    -- Stay after pressing * and search selected text
    use({"haya14busa/vim-asterisk", event = 'VimEnter'})

    use { 'nvim-telescope/telescope-ui-select.nvim' }
    if not vim.g.is_win then
      use {
        'nvim-telescope/telescope-frecency.nvim',
        requires = {
          {
            'tami5/sqlite.lua', rocks = { 'sqlite', 'luv' }
          }
        }
      }
    end
    use { 'nvim-telescope/telescope-live-grep-raw.nvim' }
    use ({ 'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('config.nvim-telescope')]],
      event = "VimEnter",
    })

    use({"sainnhe/gruvbox-material", opt = true})
    use({"folke/tokyonight.nvim"})
    use({"catppuccin/nvim"})
    use({"EdenEast/nightfox.nvim"})

    -- Show git change (change, delete, add) signs in vim sign column
    use({"mhinz/vim-signify", event = 'BufEnter'})

    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = [[require('config.statusline')]]
    }

    use({ "akinsho/bufferline.nvim", branch = "main", event = "VimEnter", config = [[require('config.bufferline')]] })

    -- fancy start screen
    use { 'goolord/alpha-nvim', event = 'VimEnter', config = [[require('config.alpha-nvim')]] }

    -- notification plugin
    use({
      "rcarriga/nvim-notify",
      event = "BufEnter",
      config = function()
        vim.defer_fn(function() require('config.nvim-notify') end, 2000)
      end
    })

    -- Snippet engine and snippet template
    use({"SirVer/ultisnips", event = 'InsertEnter'})
    use({ "honza/vim-snippets", after = 'ultisnips'})

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
      end
    }

    use({"tpope/vim-scriptease", cmd = {"Scriptnames", "Message", "Verbose"}})

    -- The missing auto-completion for cmdline!
    use({"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]})

    -- showing keybindings
    use {"folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function() require('config.which-key') end, 2000)
    end
    }

    use { 'mfussenegger/nvim-dap', config = [[require('config.nvim-dap')]] }
    use { 'jayp0521/mason-nvim-dap.nvim', config = [[require('config.mason-nvim-dap')]] }
    use { "rcarriga/nvim-dap-ui", config = [[require('config.nvim-dap-ui')]] }
    use { 'preservim/nerdtree' }
    use ({ 'arcashka/neovim-cmake',
      branch = 'fix_select_target_with_telescope',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('config.neovim-cmake')]],
      event = "VimEnter"
    })
  end,

  config = {
    max_jobs = 16,
    compile_path = util.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua'),
    git = {
      default_url_format = plug_url_format,
    },
  },
  log = { level = 'warning' },
})

local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
