-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  dependencies = { 'saghen/blink.cmp' },
  event = 'InsertEnter',
  opts = {
    map_cr = false,
  },
}
