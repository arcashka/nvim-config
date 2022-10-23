local dap = require('dap')


local platform_lldb_vscode = 'C:/Program Files/LLVM/bin/lldb-vscode.exe'
if vim.g.is_mac then
  platform_lldb_vscode = '/usr/local/Cellar/llvm/14.0.6_1/bin/lldb-vscode'
elseif vim.g.is_linux then
  platform_lldb_vscode = '/usr/bin/lldb-vscode'
end

dap.adapters.lldb = {
  type = 'executable',
  command = platform_lldb_vscode,
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
    -- postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
  },
}

-- dap.adapters.cppdbg = {
--   id = 'cppdbg',
--   type = 'executable',
--   command = 'C://Users//arcashka//.vscode//extensions//ms-vscode.cpptools-1.9.5//debugAdapters//bin//OpenDebugAD7.exe',
-- }

-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     MIMode = 'gdb',
--     MIDebuggerPath = 'gdb.exe',
--   }
-- }

