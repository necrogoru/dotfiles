return {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")
        vim.keymap.set("n", "<tab>", function()
            local bufnr = vim.api.nvim_get_current_buf()
            local state = vim.b[bufnr].nes_state
            if state then
                -- Try to jump to the start of the suggestion edit.
                -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                    or (
                        require("copilot-lsp.nes").apply_pending_nes()
                        and require("copilot-lsp.nes").walk_cursor_end_edit()
                    )
                return nil
            else
                -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
                return "<C-i>"
            end
        end, { desc = "Accept Copilot NES suggestion", expr = true })
    end,
    config = function()
        local ok, util = pcall(require, "copilot-lsp.util")
        if not ok or util._codex_safe_hl_text_to_virt_lines then
            return
        end

        local original = util.hl_text_to_virt_lines
        local warned = false

        local function plain_virt_lines(text)
            local lines = vim.split(text or "", "\n", { plain = true })
            return vim.iter(lines)
                :map(function(line)
                    return { { line, nil } }
                end)
                :totable()
        end

        util.hl_text_to_virt_lines = function(text, lang)
            local ok_highlight, virt_lines = pcall(original, text, lang)
            if ok_highlight then
                return virt_lines
            end

            if not warned then
                warned = true
                vim.schedule(function()
                    vim.notify(
                        "copilot-lsp NES preview highlight fallback enabled after renderer error",
                        vim.log.levels.WARN
                    )
                end)
            end

            return plain_virt_lines(text)
        end

        util._codex_safe_hl_text_to_virt_lines = true
    end,
}
