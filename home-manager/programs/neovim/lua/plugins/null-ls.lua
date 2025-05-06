local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")


null_ls.setup({
    sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.nixfmt,
        -- null_ls.builtins.diagnostics.eslint.with({
        --     command = "/nix/store/fc1bdvr36krhzq6ildabwlypr6b1gknc-eslint_d-13.0.0/bin/eslint_d",
        -- }),
        -- null_ls.builtins.formatting.prettier,

    },
})

local opts = {
    sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.nixfmt,
        -- null_ls.builtins.diagnostics.eslint.with({
        --     command = "/nix/store/fc1bdvr36krhzq6ildabwlypr6b1gknc-eslint_d-13.0.0/bin/eslint_d",
        -- }),
        -- null_ls.builtins.formatting.prettier,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
}

return opts
