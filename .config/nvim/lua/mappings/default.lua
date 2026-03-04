local M = {}
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set

vim.keymap.del("n", "go")
map("n", "go", "gg", { noremap = true, silent = true, nowait = true, desc = "Go to first line" })
-- go to next buffer

map("i", "<C-d>", "<Del>")
map("n", "<C-z>", "<C-R>")
map("n", "<D-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
map("v", "<D-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
map("i", "<D-v>", '<C-r>+', { noremap = true, silent = true, desc = "Paste from clipboard" })
map('n', '<leader>yp', function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy relative file path' })

map("n", "<leader>th", ":Telescope colorscheme<CR>", { desc = "telescope themes" })

map("n", "<leader>h", ':BufferLineCyclePrev<CR>', { silent = true, desc = "Go to previous buffer" })
map("n", "<leader>l", ':BufferLineCycleNext<CR>', { silent = true, desc = "Go to next buffer" })
map("n", "<leader>j", ':BufferLineMoveNext<CR>', { silent = true, desc = "Move buffer to next" })
map("n", "<leader>k", ':BufferLineMovePrev<CR>', { silent = true, desc = "Move buffer to previous" })

map("n", "<leader>ff", ":Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob,!.git/*<CR>", { desc = "Find files" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>fc", function()
  require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })
end, { desc =  "Files in current folder" })

map("n", "<C-\\>", "<cmd>NvimTreeFindFile<CR>", { desc = "NvimTree find file" })

local opts = { noremap = true, silent = true }

vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Delete without yanking' })

map("i", "<C-Right>", "<Plug>(copilot-suggest)", { noremap = false, silent = true, desc = "Copilot Suggest" })
map('i', '<C-;>', function ()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, { desc = 'Copilot Accept', noremap = true, silent = true })

map("n", "<C-e>", ":lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostic float" })
map("n", "<leader>yd", function()
  local d = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if not d[1] then
    vim.notify("No diagnostic on this line", vim.log.levels.INFO)
    return
  end
  vim.fn.setreg("+", d[1].message)
  vim.notify("Diagnostic copied to clipboard", vim.log.levels.INFO)
end, { desc = "Yank diagnostic message" })

map("n", "<leader>cf", ":CopilotChatFix<CR>", { desc = "Copilot fix current error" })
map("n", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Copilot add tests" })
map("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
map("n", "<leader>cq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChatToggle").ask(input, {
      sticky = { "#buffer" },
    })
  end
end, { desc = "CopilotChat - Quick chat" })
map('n', ']t', ':TSTextobjectGotoNextEnd @tag.outer<CR>', { noremap = true, silent = true })
map('n', '[t', ':TSTextobjectGotoPreviousStart @tag.outer<CR>', { noremap = true, silent = true })

map({ "n", "x" }, "<leader>ta", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- vim.lsp.buf.hover()
map("n", "<leader>H", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover" })

-- change neovide scale factor with a promt
map("n", "<leader>ts", function()
  local input = vim.fn.input("Set neovide scale factor (current: " .. vim.g.neovide_scale_factor .. "): ")
  local scale = tonumber(input)
  if scale and scale > 0 then
    vim.g.neovide_scale_factor = scale
  else
    print("Invalid scale factor")
  end
end, { desc = "Set neovide scale factor" })

map("n", "<leader>to", function()
  local input = vim.fn.input("Set neovide opactity (current: " .. vim.g.neovide_normal_opacity .. "): ")
  local opacity = tonumber(input)
  if opacity and opacity > 0 and opacity <= 1 then
    vim.g.neovide_normal_opacity = opacity
    vim.g.neovide_opacity = opacity
  else
    print("Invalid opacity value")
  end
end, { desc = "Set neovide opacity" })

map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<leader>x", function()
  local buf = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(buf, "modified")

  if modified then
    local choice = vim.fn.confirm("Save before close?", "&Yes\n&No\n&Cancel", 2)
    if choice == 1 then
      vim.cmd("w | Bdelete")
    elseif choice == 2 then
      vim.cmd("Bdelete!")
    elseif choice == 3 then
      vim.notify("Buffer close canceled", vim.log.levels.INFO)
      return
    end
  else
    vim.cmd("Bdelete")
  end
end, { desc = "Close buffer" })

map("n", "<leader>vv", "<cmd>vsp<CR><cmd>enew<CR>", { desc = "Split buffer vertically and focus new buffer" })
