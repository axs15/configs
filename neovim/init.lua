vim.cmd("source ~/.vimrc")
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
local lazypath           = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local plugins = {
    "karb94/neoscroll.nvim",
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = { style = "night", transparent = true },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            dashboard = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        "folke/which-key.nvim",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function(_, opts)
            require("which-key").setup(opts)
            require("mappings")
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        init = function()
            require("nvim-tree").setup()
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require("plugins.luasnip")
                end,
            },
        },

        opts = function()
            return require("plugins.cmp")
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require("plugins.lspconfig")
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                line = '<leader>/',
            },
            opleader = {
                line = '<leader>/'
            }
        }
    },
    {
      "esmuellert/codediff.nvim",
      cmd = "CodeDiff",
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }

}
require("lazy").setup(plugins)
vim.cmd [[colorscheme tokyonight]]
