-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  -- local nmap = function(keys, func, desc)
  --   if desc then
  --     desc = 'LSP: ' .. desc
  --   end

  --   vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  -- end

  
  -----------map info  --------------------------------
    -- +================================== coc.nvim  ======================================+ --
    -- Some servers have issues with backup files, see #649.
    vim.opt.backup = false
    vim.opt.writebackup = false
    -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    -- delays and poor user experience.
    vim.opt.updatetime = 300
    -- Always show the signcolumn, otherwise it would shift the text each time
    -- diagnostics appear/become resolved.
    vim.opt.signcolumn = 'yes'
    -- Use tab for trigger completion with characters ahead and navigate.
    -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    -- other plugin before putting this into your config.
    vim.api.nvim_set_keymap('i', '<TAB>', 'pumvisible() ? "\\<C-n>" : v:lua.CheckBackspace() ? "\\<TAB>" : coc#refresh()', {expr = true, silent = true})
    vim.api.nvim_set_keymap('i', '<S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<C-h>"', {expr = true, silent = true})
    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice.
    vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? coc#pum#confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', {expr = true, silent = true})

    function CheckBackspace()
      local col = vim.fn.col('.') - 1
      return (col == 0 or vim.fn.getline('.'):sub(col, col):match('%s'))
    end

    -- Use <c-space> to trigger completion.
    if vim.fn.has('nvim') then
      vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', {expr = true, silent = true})
    else
      vim.api.nvim_set_keymap('i', '<c-@>', 'coc#refresh()', {expr = true, silent = true})
    end
    -- Use `[g` and `]g` to navigate diagnostics
    -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', {silent = true})
    vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', {silent = true})
    -- GoTo code navigation.
    vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {silent = true})
    vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
    vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {silent = true})
    vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {silent = true})
    -- Use K to show documentation in preview window.
    vim.api.nvim_set_keymap('n', 'K', ':call ShowDocumentation()<CR>', {silent = true})

    function ShowDocumentation()
      if vim.fn.CocAction('hasProvider', 'hover') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.fn.feedkeys('K', 'in')
      end
    end

    -- Highlight the symbol and its references when holding the cursor.
    vim.cmd('autocmd CursorHold * silent call CocActionAsync("highlight")')
    -- Symbol renaming.
    vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {silent = true})
    -- Formatting selected code.
    vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', {silent = true})
    vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', {silent = true})
    vim.cmd([[
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
    ]])
    -- Applying codeAction to the selected region.
    -- Example: `<leader>aap` for current paragraph
    vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', {silent = true})
    vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {silent = true})
    -- Remap keys for applying codeAction to the current buffer.
    vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', {silent = true})
    -- Apply AutoFix to problem on the current line.
    vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', {silent = true})
    -- Run the Code Lens action on the current line.
    vim.api.nvim_set_keymap('n', '<leader>cl', '<Plug>(coc-codelens-action)', {silent = true})
    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    vim.api.nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', {silent = true})
    vim.api.nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', {silent = true})
    vim.api.nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', {silent = true})
    vim.api.nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', {silent = true})
    vim.api.nvim_set_keymap('x', 'ic', '<Plug>(coc-classobj-i)', {silent = true})
    vim.api.nvim_set_keymap('o', 'ic', '<Plug>(coc-classobj-i)', {silent = true})
    vim.api.nvim_set_keymap('x', 'ac', '<Plug>(coc-classobj-a)', {silent = true})
    vim.api.nvim_set_keymap('o', 'ac', '<Plug>(coc-classobj-a)', {silent = true})
    -- Remap <C-f> and <C-b> for scroll float windows/popups.
    if vim.fn.has('nvim-0.4.0') or vim.fn.has('patch-8.2.0750') then
      vim.api.nvim_set_keymap('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-f>"', {expr = true, silent = true, nowait = true})
      vim.api.nvim_set_keymap('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-b>"', {expr = true, silent = true, nowait = true})
      vim.api.nvim_set_keymap('i', '<C-f>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<Right>"', {expr = true, silent = true, nowait = true})
      vim.api.nvim_set_keymap('i', '<C-b>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<Left>"', {expr = true, silent = true, nowait = true})
      vim.api.nvim_set_keymap('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-f>"', {expr = true, silent = true, nowait = true})
      vim.api.nvim_set_keymap('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-b>"', {expr = true, silent = true, nowait = true})
    end
    -- Use CTRL-S for selections ranges.
    -- Requires 'textDocument/selectionRange' support of language server.
    vim.api.nvim_set_keymap('n', '<C-s>', '<Plug>(coc-range-select)', {silent = true})
    vim.api.nvim_set_keymap('x', '<C-s>', '<Plug>(coc-range-select)', {silent = true})
    -- Add `:Format` command to format current buffer.
    vim.cmd('command! -nargs=0 Format :call CocActionAsync("format")')
    -- Add `:Fold` command to fold current buffer.
    vim.cmd('command! -nargs=? Fold :call CocAction("fold", <f-args>)')
    -- Add `:OR` command for organize imports of the current buffer.
    vim.cmd('command! -nargs=0 OR :call CocActionAsync("runCommand", "editor.action.organizeImport")')
    -- Add (Neo)Vim's native statusline support.
    -- NOTE: Please see `:h coc-status` for integrations with external plugins that
    -- provide custom statusline: lightline.vim, vim-airline.
    vim.opt.statusline = '%{coc#status()}%{get(b:,"coc_current_function","")}'
--
  -------------------tag -------------------------------

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
  
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

-- cocvim replace mason 20231102 


-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
-- require('mason').setup()
-- require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}


