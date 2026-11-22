require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")


vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end)
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "DAP start/continue" })
vim.keymap.set("n", "<leader>dn", function() require("dap").step_over() end, { desc = "DAP step over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "DAP step into" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "DAP step out" })
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "DAP terminate" })

-- compile and run C++
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("w") -- save first
  vim.cmd("split | term g++-15 -g -std=c++23 -Wall -Wextra -o /tmp/main %:p && /tmp/main")
  vim.cmd("startinsert")
end, { desc = "Compile and run C++" })

-- compile only (useful when you just want to check for errors)
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd("w")
  vim.cmd("split | term g++-15 -g -std=c++23 -Wall -Wextra -o /tmp/main %:p")
end, { desc = "Compile C++" })

-- Cargo
vim.keymap.set("n", "<leader>cb", function()
  vim.cmd("w")
  vim.cmd("split | term cargo build")
end, { desc = "Cargo build" })

vim.keymap.set("n", "<leader>cr", function()
  vim.cmd("w")
  vim.cmd("split | term cargo run")
  vim.cmd("startinsert")
end, { desc = "Cargo run" })

vim.keymap.set("n", "<leader>ct", function()
  vim.cmd("w")
  vim.cmd("split | term cargo test")
end, { desc = "Cargo test" })

-- Python
vim.keymap.set("n", "<leader>rp", function()
  vim.cmd("w")
  vim.cmd("split | term python3 %:p")
  vim.cmd("startinsert")
end, { desc = "Run Python file" })

vim.keymap.set("n", "<leader>rT", function()
  vim.cmd("w")
  vim.cmd("split | term python3 -m pytest %:p -v")
end, { desc = "Pytest current file" })
