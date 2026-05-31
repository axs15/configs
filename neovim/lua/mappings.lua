local M = {}

local wk = require("which-key")
local ts = require("telescope.builtin")
local snacks = require("plugins.snacks")

M.general = {
    { "<Esc>", "<CMD>noh <CR>",             desc = "Clear highlights" },
    -- switch between windows
    { "<C-h>", "<C-w>h",                    desc = "Window left" },
    { "<C-l>", "<C-w>l",                    desc = "Window right" },
    { "<C-j>", "<C-w>j",                    desc = "Window down" },
    { "<C-k>", "<C-w>k",                    desc = "Window up" },
    -- go to  beginning and end
    { "<C-b>", "<ESC>^i",                   desc = "Beginning of line" },
    { "<C-e>", "<End>",                     desc = "End of line" },
    -- toggle
    { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree" },
}
wk.add(M.general)

local telescope = require("telescope.builtin")
M.telescope = {
    -- find
    { "<leader>ff", "<cmd> Telescope find_files <CR>",                                        desc = "Find files" },
    { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
    { "<leader>fw", "<cmd> Telescope live_grep <CR>",                                         desc = "Live grep" },
    { "<leader>fb", "<cmd> Telescope buffers <CR>",                                           desc = "Find buffers" },
    { "<leader>fh", "<cmd> Telescope help_tags <CR>",                                         desc = "Help pages" },
    { "<leader>fm", function() ts.man_pages({ sections = { "ALL" } }) end,                    desc = "Man pages" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>",                                          desc = "Find oldfiles" },
    {
        "<leader>fs",
        function()
            telescope.lsp_workspace_symbols()
        end,
        desc = "List workspace symbols"
    },
    { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },

    -- git
    { "<leader>gc", "<cmd> Telescope git_commits <CR>",               desc = "Git commits" },
    { "<leader>gs", "<cmd> Telescope git_status <CR>",                desc = "Git status" },

    { "<leader>ma", "<cmd> Telescope marks <CR>",                     desc = "telescope bookmarks" },
}
wk.add(M.telescope)

M.lspconfig = {
    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
    { "<leader>q", snacks.show_line_diagnostics, desc = "Show diagnostics" },
    {
        "<leader>]",
        function()
            vim.diagnostic.jump({ count = 1, float = true })
        end,
        desc = "Open next diagnostic",
    },
    {
        "<leader>[",
        function()
            vim.diagnostic.jump({ count = -1, float = true })
        end,
        desc = "Open previous diagnostic",
    },

    {
        "gD",
        function()
            vim.lsp.buf.declaration()
        end,
        desc = "LSP declaration",
    },

    {
        "gd",
        function()
            vim.lsp.buf.definition()
        end,
        desc = "LSP definition",
    },

    {
        "K",
        function()
            vim.lsp.buf.hover()
        end,
        desc = "LSP hover",
    },

    {
        "gi",
        function()
            telescope.lsp_implementation()
        end,
        desc = "LSP implementation",
    },

    {
        "<leader>ls",
        function()
            vim.lsp.buf.signature_help()
        end,
        desc = "LSP signature help",
    },

    {
        "<leader>la",
        function()
            vim.lsp.buf.code_action()
        end,
        desc = "LSP code actions",
    },

    {
        "gR",
        function()
            vim.lsp.buf.rename()
        end,
        desc = "LSP rename",
    },

    {
        "gr",
        function()
            telescope.lsp_references()
        end,
        desc = "LSP references",
    },
    { "<leader>lm", function() vim.lsp.buf.format { async = true } end, desc = "LSP formatting" },
}
wk.add(M.lspconfig)


return M
