# jinja.nvim

A modern Neovim plugin for Jinja2 template support, written in Lua. Provides comprehensive syntax highlighting, file type detection, and integration with [vim-matchup](https://github.com/andymass/vim-matchup) for matching Jinja control structures.

## Features

- **Syntax Highlighting**: Complete Jinja2 syntax highlighting including:
  - Template tags (`{% %}`)
  - Variables (`{{ }}`)
  - Comments (`{# #}`)
  - Filters, operators, strings, and numbers
  - Built-in keywords and special variables
  - **Base format highlighting**: Highlights the underlying file format (HTML, YAML, XML, CSS, JavaScript) alongside Jinja syntax

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

**Note for large files**: This plugin automatically configures vim-matchup to handle Jinja files with long control structures. It sets `g:matchup_matchparen_stopline = 1000` (default is 400 lines), which allows match highlighting to work correctly even when `{% if %}` and `{% else %}` blocks are hundreds of lines apart.

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

### Base Syntax Highlighting

The plugin automatically detects and highlights the underlying file format based on filename patterns:

- `*.html.jinja`, `*.html.jinja2`, `*.html.j2` → HTML highlighting
- `*.yaml.jinja`, `*.yml.jinja`, etc. → YAML highlighting
- `*.xml.jinja`, `*.xml.jinja2`, etc. → XML highlighting
- `*.css.jinja`, `*.scss.jinja`, etc. → CSS highlighting
- `*.js.jinja`, `*.js.jinja2`, etc. → JavaScript highlighting
- `*.sls`, `*.yaml`, `*.yml` → YAML highlighting (for Salt/Ansible)

You can manually specify the base syntax by setting `g:jinja_base_syntax`:

```vim
" Force HTML syntax highlighting for all Jinja files
let g:jinja_base_syntax = 'html'
```

Or in Lua:

```lua
vim.g.jinja_base_syntax = 'html'
```

Supported base syntaxes include: `html`, `xml`, `yaml`, `css`, `scss`, `javascript`, and any other Vim syntax file available in your runtime path.

## Comparison with Other Plugins

This plugin is designed as a modern, Lua-based replacement for:

- [Glench/Vim-Jinja2-Syntax](https://github.com/Glench/Vim-Jinja2-Syntax): Provides similar syntax highlighting but is written in Vimscript
- Custom vim-matchup configurations: Includes vim-matchup support out of the box

Key differences:

- Written in Lua for better Neovim integration
- Supports highlighting both Jinja syntax and base file formats (HTML, YAML, etc.)
- Built-in vim-matchup support
- Automatic base syntax detection from filename patterns
- Optimized for SaltStack `.sls` files and Ansible templates
- Cleaner, more maintainable codebase
- Supports whitespace control syntax (`{%-`, `-%}`, etc.)

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

Inspired by [Glench/Vim-Jinja2-Syntax](https://github.com/Glench/Vim-Jinja2-Syntax) and designed for modern Neovim workflows.
