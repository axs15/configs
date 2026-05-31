local M = {}

local severity = {
    [vim.diagnostic.severity.ERROR] = { label = "ERROR", hl = "DiagnosticError" },
    [vim.diagnostic.severity.WARN]  = { label = "WARN",  hl = "DiagnosticWarn"  },
    [vim.diagnostic.severity.INFO]  = { label = "INFO",  hl = "DiagnosticInfo"  },
    [vim.diagnostic.severity.HINT]  = { label = "HINT",  hl = "DiagnosticHint"  },
}

local function format_diagnostic(d)
    local sev = severity[d.severity] or { label = "DIAG", hl = "Normal" }
    local parts = {}
    if d.source then table.insert(parts, "[" .. d.source:gsub("%.$", "") .. "]") end
    if d.code   then table.insert(parts, "(" .. tostring(d.code) .. ")") end
    local label = #parts > 0 and table.concat(parts, " ") or sev.label
    local lines = { label }
    for _, l in ipairs(vim.split(d.message, "\n", { plain = true })) do
        table.insert(lines, "  " .. l)
    end
    return lines, sev.hl
end

function M.show_line_diagnostics()
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(0, { lnum = lnum })
    if #diagnostics == 0 then return end

    local lines = {}
    local highlights = {}
    for i, d in ipairs(diagnostics) do
        if i > 1 then table.insert(lines, "") end
        local diag_lines, hl = format_diagnostic(d)
        table.insert(highlights, { line = #lines, hl = hl })
        vim.list_extend(lines, diag_lines)
    end

    local width = 40
    for _, l in ipairs(lines) do width = math.max(width, #l) end
    width = math.min(width + 2, 100)

    Snacks.win({
        text = lines,
        style = "float",
        border = "rounded",
        title = " Diagnostics ",
        title_pos = "center",
        relative = "cursor",
        row = 1, col = 0,
        width = width,
        height = #lines,
        wo = { wrap = true },
        on_buf = function(win)
            for _, h in ipairs(highlights) do
                vim.api.nvim_buf_add_highlight(win.buf, 0, h.hl, h.line, 0, -1)
            end
        end,
    })
end

return M
