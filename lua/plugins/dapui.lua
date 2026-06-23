return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  opts = require('lazydev').setup {
    library = { 'nvim-dap-ui' },
  },
}
