{
  globals.mapleader = " ";

  extraConfigLua = ''
     -- Folding uniquement pour C/C++
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "h", "hpp", "java" },
      callback = function()
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt_local.foldenable = true
        vim.opt_local.foldlevel = 99
      end
    })

    -- Configuration des diagnostics avec hover automatique
    vim.diagnostic.config({
      virtual_text = {
        prefix = '●',
        source = "always",
      },
      float = {
        source = "always",
        border = "rounded",
        header = "",
        prefix = "",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Hover automatique sur diagnostic quand on met la souris dessus
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })

    -- Raccourcis sans leader
    vim.keymap.set('n', '<F2>', ':echo "Test fonctionne!"<CR>', { desc = 'Test F2' })
    vim.keymap.set('n', '<F3>', ':Neotree toggle<CR>', { desc = 'Toggle Neotree' })
    vim.keymap.set('n', '<leader>e', ':Telescope find_files<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<F5>', ':setlocal foldmethod=syntax<CR>', { desc = 'Enable syntax folding' })
    vim.keymap.set('n', '<F6>', ':setlocal foldenable!<CR>', { desc = 'Toggle folding' })

    -- Raccourcis pour diagnostics
    vim.keymap.set('n', '<F7>', vim.diagnostic.open_float, { desc = 'Show diagnostic popup' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
     -- En mode Visual, Tab indente et garde la sélection
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent and keep selection' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Outdent and keep selection' })

-- Alternative avec > et < qui réindentent après sélection
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and reselect' })
vim.keymap.set('v', '<', '<gv', { desc = 'Outdent and reselect' })

-- Bonus : En mode Normal, indenter ligne courante
vim.keymap.set('n', '<Tab>', '>>', { desc = 'Indent current line' })
vim.keymap.set('n', '<S-Tab>', '<<', { desc = 'Outdent current line' })
  '';

  opts = {
    number = true;
    relativenumber = true;
    smartindent = true;
    wrap = false;
    swapfile = false;
    backup = false;
    hlsearch = false;
    incsearch = true;
    termguicolors = true;
    scrolloff = 8;
    updatetime = 50;
    foldmethod = "indent"; # ou "syntax" ou "marker"
    foldlevel = 99; # Tout close par défaut
    foldenable = false;
    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    softtabstop = 4;
    
    # Ligne à 80 caractères
    colorcolumn = "80";  # Ligne verticale rouge à 80 chars
    textwidth = 80;
  };

  keymaps = [
    {
      key = "<leader>f";
      action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
      mode = "n";
    }
  ];

  # Colorscheme
  colorschemes.gruvbox.enable = true;
}
