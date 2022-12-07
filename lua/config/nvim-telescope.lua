require("telescope").load_extension("ui-select")
if not vim.g.is_win and not vim.g.is_linux then
  require("telescope").load_extension("frecency")
end
require("telescope").load_extension("live_grep_args")

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}
