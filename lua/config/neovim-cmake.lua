local Path = require('plenary.path')

local platform_configure_args = {}
if not vim.g.is_win then
  platform_configure_args = { '-G', 'Ninja', '-DCMAKE_CXX_COMPILER=clang++', '-DCMAKE_C_COMPILER=clang' }
else
  platform_configure_args = {
      '-G', 'Ninja',
  }
end

require('cmake').setup({
  cmake_executable = 'cmake',
  parameters_file = 'CMakeSettings.json',
  build_dir = tostring(Path:new('{cwd}', '..', 'build-{project_name}-{build_type}')),
  configure_args = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1', unpack(platform_configure_args) },
  build_args = { '-j', '10' },
  quickfix_height = 10,
  dap_configuration = { type = 'cppdbg', request = 'launch' },
  dap_open_command = require('dap').repl.open,
})
