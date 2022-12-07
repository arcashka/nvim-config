-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `ultisnips` user.
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' }, -- For nvim-lsp
        { name = 'path' }, -- for path completion
        { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
        { name = 'emoji', insert = true, } -- emoji completion
    },
    completion = {
        keyword_length = 1,
        completeopt = "menu,noselect"
    },
    experimental = {
        ghost_text = false
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            menu = {
                nvim_lsp = "[LSP]",
                ultisnips = "[US]",
                path = "[Path]",
                buffer = "[Buffer]",
                emoji = "[Emoji]",
            },
        }),
    },
})

vim.cmd("hi link CmpItemMenu Comment")
