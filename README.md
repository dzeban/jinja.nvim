# jinja.nvim

A modern Neovim plugin for Jinja2 template support, written in Lua. Provides comprehensive syntax highlighting, file type detection, and integration with [vim-matchup](https://github.com/andymass/vim-matchup) for matching Jinja control structures.

## Features

- **Syntax Highlighting**: Complete Jinja2 syntax highlighting including:
  - Template tags (`{% %}`)
  - Variables (`{{ }}`)
  - Comments (`{# #}`)
  - Filters, operators, strings, and numbers
  - Built-in keywords and special variables

- **File Type Detection**: Automatic detection for:
  - `*.jinja`
  - `*.jinja2`
  - `*.j2`
  - `*.sls` (SaltStack state files)

- **vim-matchup Integration**: Navigate between matching Jinja blocks with `%`:
  - `if`/`elif`/`else`/`endif`
  - `for`/`endfor`
  - `block`/`endblock`
  - `macro`/`endmacro`
  - `call`/`endcall`
  - `filter`/`endfilter`
  - `set`/`endset`
  - `raw`/`endraw`
  - `autoescape`/`endautoescape`
  - `with`/`endwith`
  - `trans`/`endtrans`
  - `blocktrans`/`endblocktrans`

- **Smart Defaults**: Sensible defaults for Jinja files:
  - Comment string set to `{# %s #}`
  - 2-space indentation
  - Auto-indentation enabled

## Requirements

- Neovim 0.7.0 or later (for Lua autocmd support)
- Optional: [vim-matchup](https://github.com/andymass/vim-matchup) for enhanced block matching

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "dzeban/jinja.nvim",
  ft = { "jinja", "sls" },
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "dzeban/jinja.nvim",
  ft = { "jinja", "sls" },
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'dzeban/jinja.nvim'
```

### Manual Installation

Clone this repository into your Neovim runtime path:

```bash
git clone https://github.com/dzeban/jinja.nvim ~/.config/nvim/pack/plugins/start/jinja.nvim
```

## Usage

The plugin works automatically once installed. Open any file with `.jinja`, `.jinja2`, `.j2`, or `.sls` extension and you'll get:

- Syntax highlighting
- Proper comment strings for commenting/uncommenting lines
- Block matching (if vim-matchup is installed)

### With vim-matchup

If you have [vim-matchup](https://github.com/andymass/vim-matchup) installed, you can:

- Press `%` to jump between matching Jinja tags
- Use `[%` and `]%` to navigate to previous/next matching tags
- Press `z%` to navigate inside blocks
- Use text objects like `i%` and `a%` for inner/around blocks

### Example

```jinja
{% if user.is_authenticated %}
  <p>Welcome, {{ user.name }}!</p>
  {% for item in user.items %}
    <li>{{ item.name|upper }}</li>
  {% endfor %}
{% else %}
  <p>Please log in.</p>
{% endif %}
```

## Configuration

The plugin uses sensible defaults, but you can override settings in your Jinja files using modeline or autocmd:

```lua
-- In your init.lua, customize Jinja settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "jinja",
  callback = function()
    vim.bo.shiftwidth = 4  -- Use 4 spaces instead of 2
    vim.bo.tabstop = 4
  end,
})
```

## Comparison with Other Plugins

This plugin is designed as a modern, Lua-based replacement for:

- [Glench/Vim-Jinja2-Syntax](https://github.com/Glench/Vim-Jinja2-Syntax): Provides similar syntax highlighting but is written in Vimscript
- Custom vim-matchup configurations: Includes vim-matchup support out of the box

Key differences:

- Written in Lua for better Neovim integration
- Focused on generic Jinja2 templates (no HTML/Django-specific features)
- Built-in vim-matchup support
- Optimized for SaltStack `.sls` files
- Cleaner, more maintainable codebase

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

Inspired by [Glench/Vim-Jinja2-Syntax](https://github.com/Glench/Vim-Jinja2-Syntax) and designed for modern Neovim workflows.
