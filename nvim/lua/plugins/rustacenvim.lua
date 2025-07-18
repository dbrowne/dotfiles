return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = "rust",
  lazy = false,
  config = function()
    local function try_configure_dap()
      local ok, registry = pcall(require, "mason-registry")
      if not ok then
        vim.notify("[rustaceanvim] Failed to load mason-registry", vim.log.levels.ERROR)
        return
      end

      local pkg = registry.get_package("codelldb")
      if not (pkg and pkg.is_installed and pkg:is_installed()) then
        vim.notify("[rustaceanvim] codelldb is not installed", vim.log.levels.WARN)
        return
      end

      if type(pkg.get_install_path) ~= "function" then
        vim.defer_fn(try_configure_dap, 100)
        return
      end

      local extension_path = pkg:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      -- Dynamically resolve project root at runtime
      local root_dir = vim.fn.getcwd()

      vim.g.rustaceanvim = {
        dap = {
          adapter = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--liblldb", liblldb_path, "--port", "${port}" },
              detached = true,
            },
          },
        },
        tools = {
          autoSetHints = true,
        },
        server = {
           on_attach = function(client)
      --client.server_capabilities.documentFormattingProvider = false
    end,
          settings = {
            ["rust-analyzer"] = {
              rustfmt = {
                extraArgs = { "--config-path", root_dir }, -- dynamic, not hardcoded
              },
            },
          },
        },
      }

      vim.notify("[rustaceanvim] DAP + rustfmt config-path set: " .. root_dir, vim.log.levels.INFO)
    end

    require("mason-registry").refresh(function()
      vim.defer_fn(try_configure_dap, 100)
    end)
  end,
}
