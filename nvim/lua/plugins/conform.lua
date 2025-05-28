return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        rust = { "rustfmt_wrapper" },
      },
      formatters = {
        rustfmt_wrapper = {
          command = "~/.local/bin/rustfmt_project",
          stdin = false,
        },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rs",
      callback = function(args)
        require("conform").format({ bufnr = args.buf, lsp_fallback = false })
      end,
    })
  end,
}
