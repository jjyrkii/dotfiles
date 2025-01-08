return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      bashls = {},
      gdscript = {},
    },
  },
}
