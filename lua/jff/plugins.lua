return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("telescope").load_extension("undo")
        end,
    },
    {"nvim-lua/plenary.nvim"},
    {"nvim-tree/nvim-web-devicons"},
    {
        "nvim-treesitter/nvim-treesitter",
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {"ThePrimeagen/harpoon"},
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-nvim-lsp'},
		    {'hrsh7th/cmp-nvim-lua'},
            {'saadparwaiz1/cmp_luasnip'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },
    {"numToStr/Comment.nvim"},
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
     "folke/trouble.nvim",
     dependencies = { "nvim-tree/nvim-web-devicons" },
     opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
         },
     }
}
