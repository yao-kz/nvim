require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pyright", "ruff" }
vim.lsp.enable(servers)

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})

-- read :h vim.lsp.config for changing options of lsp servers 

-- Show the full diagnostic message below the line under the cursor instead of
-- truncated virtual text at the end of the line.
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = {
    current_line = true,
    -- virtual lines don't soft-wrap, so wrap the message to the window width
    format = function(d)
      local win = vim.fn.bufwinid(d.bufnr)
      local info = vim.fn.getwininfo(win ~= -1 and win or vim.api.nvim_get_current_win())[1]
      local line = vim.api.nvim_buf_get_lines(d.bufnr, d.lnum, d.lnum + 1, false)[1] or ""
      local indent = vim.fn.strdisplaywidth(line:sub(1, d.col))
      local width = math.max(info.width - info.textoff - indent - 8, 20)

      local out = {}
      for para in (d.message .. "\n"):gmatch "(.-)\n" do
        local cur = ""
        for word in para:gmatch "%S+" do
          if cur ~= "" and vim.fn.strdisplaywidth(cur .. " " .. word) > width then
            table.insert(out, cur)
            cur = word
          else
            cur = cur == "" and word or cur .. " " .. word
          end
        end
        if cur ~= "" then
          table.insert(out, cur)
        end
      end
      return table.concat(out, "\n")
    end,
  },
  float = { border = "rounded", source = true },
}

-- gl: open the diagnostic(s) for the current line in a floating window
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "LSP show line diagnostics" })
