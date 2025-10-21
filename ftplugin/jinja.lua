-- ftplugin/jinja.lua
-- Filetype plugin for Jinja templates

-- Only load this plugin once for this buffer
if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = 1

-- Save current compatibility options
local cpo_save = vim.o.cpo
vim.o.cpo = vim.o.cpo .. "C"

-- Comment string for commenting lines
vim.bo.commentstring = "{# %s #}"

-- Set up matching words for vim-matchup plugin
-- Format: start:middle:end
-- Supports whitespace control with {%- and -%}
vim.b.match_words = table.concat({
  -- Core control structures
  "{%-\\?\\s*\\<if\\>.*-\\?%}:{%-\\?\\s*\\<elif\\>.*-\\?%}:{%-\\?\\s*\\<else\\>\\s*-\\?%}:{%-\\?\\s*\\<endif\\>\\s*-\\?%}",
  "{%-\\?\\s*\\<for\\>.*-\\?%}:{%-\\?\\s*\\<else\\>\\s*-\\?%}:{%-\\?\\s*\\<endfor\\>\\s*-\\?%}",

  -- Block definitions
  "{%-\\?\\s*\\<block\\>.*-\\?%}:{%-\\?\\s*\\<endblock\\>.*-\\?%}",

  -- Macro definitions
  "{%-\\?\\s*\\<macro\\>.*-\\?%}:{%-\\?\\s*\\<endmacro\\>.*-\\?%}",

  -- Call blocks
  "{%-\\?\\s*\\<call\\>.*-\\?%}:{%-\\?\\s*\\<endcall\\>.*-\\?%}",

  -- Filter blocks
  "{%-\\?\\s*\\<filter\\>.*-\\?%}:{%-\\?\\s*\\<endfilter\\>.*-\\?%}",

  -- Set blocks
  "{%-\\?\\s*\\<set\\>.*-\\?%}:{%-\\?\\s*\\<endset\\>.*-\\?%}",

  -- Raw blocks (no jinja processing)
  "{%-\\?\\s*\\<raw\\>.*-\\?%}:{%-\\?\\s*\\<endraw\\>.*-\\?%}",

  -- Autoescape blocks
  "{%-\\?\\s*\\<autoescape\\>.*-\\?%}:{%-\\?\\s*\\<endautoescape\\>.*-\\?%}",

  -- With blocks
  "{%-\\?\\s*\\<with\\>.*-\\?%}:{%-\\?\\s*\\<endwith\\>.*-\\?%}",

  -- Translation blocks
  "{%-\\?\\s*\\<trans\\>.*-\\?%}:{%-\\?\\s*\\<endtrans\\>.*-\\?%}",
  "{%-\\?\\s*\\<blocktrans\\>.*-\\?%}:{%-\\?\\s*\\<endblocktrans\\>.*-\\?%}",
}, ",")

-- Set up matchit.vim patterns (fallback for vim-matchup)
vim.b.match_ignorecase = 0

-- Indentation settings
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2

-- Enable automatic indentation
vim.bo.autoindent = true
vim.bo.smartindent = false  -- smartindent can interfere with template syntax

-- Folding settings (optional, can be customized by users)
-- vim.wo.foldmethod = "indent"
-- vim.wo.foldlevel = 99

-- Undo ftplugin settings when changing filetype
vim.b.undo_ftplugin = "setlocal commentstring< expandtab< shiftwidth< softtabstop< tabstop< autoindent< smartindent<"
  .. " | unlet! b:match_words b:match_ignorecase"

-- Restore compatibility options
vim.o.cpo = cpo_save
