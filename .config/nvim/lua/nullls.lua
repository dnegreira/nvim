-- require("null-ls").setup({
--                sources = {
--                        require("null-ls").builtins.formatting.gofumpt,
--                        require("null-ls").builtins.formatting.goimports_reviser,
--                        require("null-ls").builtins.formatting.black,
--                        require("null-ls").builtins.diagnostics.flake8,
--                        require("null-ls").builtins.formatting.shfmt,
--                        require("null-ls").builtins.diagnostics.shellcheck,
--                }})
--

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
               sources = {
                       require("null-ls").builtins.formatting.gofumpt,
                       require("null-ls").builtins.formatting.goimports_reviser,
                       require("null-ls").builtins.formatting.black,
                       require("null-ls").builtins.diagnostics.flake8,
                       require("null-ls").builtins.formatting.shfmt,
                       require("null-ls").builtins.diagnostics.shellcheck,
               },
	       debug = true,
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})
