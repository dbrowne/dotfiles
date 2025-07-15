return {
	  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        rust = { "rustfmt" },  -- Use standard rustfmt
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
    })
  end,
}
