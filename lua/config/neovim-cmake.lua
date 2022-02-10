local Path = require('plenary.path')
require('cmake').setup({
  cmake_executable = 'cmake',
  parameters_file = 'CMakeSettings.json',
  build_dir = tostring(Path:new('{cwd}', '..', 'build-{project_name}-{build_type}')),
  configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-DCMAKE_CXX_COMPILER=clang++', '-DCMAKE_C_COMPILER=clang' },
  build_args = { '-j', '10' },
  quickfix_height = 10,
  dap_configuration = { type = 'lldb', request = 'launch' },
  dap_open_command = require('dap').repl.open,
})
