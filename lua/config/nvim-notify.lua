local nvim_notify = require("notify")


nvim_notify.setup({
  -- Animation style
  -- stages = "fade_in_slide_out",
  -- Default timeout for notifications
  timeout = 1500,
  background_colour = "#2E3440",
  fps = 144,
})

-- hack :C
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    nvim_notify(msg, ...)
end
