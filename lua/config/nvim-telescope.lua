require("telescope").load_extension("ui-select")
if not vim.g.is_win then
  require("telescope").load_extension("frecency")
end
require("telescope").load_extension("live_grep_raw")

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}
