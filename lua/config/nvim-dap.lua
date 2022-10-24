local dap = require('dap')

dap.adapters.lldb = {
  type = 'server',
  executable = {
    command = '/Users/nikita/.local/share/nvim/mason/bin/codelldb',
    args = {'--port', '13000'},
  },
  name = 'lldb',
  port = '13000',
  host = '127.0.0.1',
}

dap.configurations.cpp = {
  {
    name = "Debug",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
    port = '13000',
    host = '127.0.0.1',
    -- postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
