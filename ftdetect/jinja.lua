-- ftdetect/jinja.lua
-- Detect Jinja template files

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.jinja", "*.jinja2", "*.j2" },
  callback = function()
    vim.bo.filetype = "jinja"
  end,
})

-- Salt Stack state files often use Jinja templating
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.sls",
  callback = function()
    vim.bo.filetype = "jinja"
  end,
})
