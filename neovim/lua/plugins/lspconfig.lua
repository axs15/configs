-- Setup language servers.
vim.lsp.config('lua_ls', {
    -- Resolve symlinks before searching for root markers so that ~/.config/nvim
    -- (a symlink) correctly finds the .git root in the real path. Falls back to
    -- the file's own directory so LSP always starts even without a project root.
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local real = vim.uv.fs_realpath(fname) or fname
        local root = vim.fs.root(real, { '.git', '.luarc.json', '.luarc.jsonc' })
            or vim.fn.fnamemodify(real, ':h')
        on_dir(root)
    end,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "Snacks" },
            },
            completion = {
                showWord = "Disable",
                workspaceWord = false,
            },
            hint = {
                enable = true,
            },
            runtime = {
                version = 'LuaJIT',
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent = 4,
                }
            },
        }
    }
})
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('pylsp')
vim.lsp.enable('nixd')
vim.lsp.config('rust_analyzer', {
    settings = {
        rust_analyzer = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        },
    },
})
vim.lsp.enable('rust_analyzer')

-- nvim-lspconfig loads during VimEnter, after the initial buffer's FileType
-- event has already fired. Re-trigger for any buffers already open.
vim.schedule(function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= '' then
            vim.api.nvim_exec_autocmds('FileType', { group = 'nvim.lsp.enable', buffer = buf })
        end
    end
end)
