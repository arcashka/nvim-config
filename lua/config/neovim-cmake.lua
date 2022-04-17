local Path = require('plenary.path')

local platform_configure_args = {}
local dap_configuration
if vim.g.is_mac then
  local c = '/Users/nikita/.conan/data/clang/12.0/movavi/stable/package/cc471ed355602ffa7007968c83aa4e7e648a38b5/clang-12.0/bin/clang'
  local cpp = '/Users/nikita/.conan/data/clang/12.0/movavi/stable/package/cc471ed355602ffa7007968c83aa4e7e648a38b5/clang-12.0/bin/clang++'
  platform_configure_args = { '-G', 'Ninja', '-DCMAKE_CXX_COMPILER=' .. cpp, '-DCMAKE_C_COMPILER=' .. c }
  dap_configuration = 'lldb'
elseif vim.g.is_linux then
  platform_configure_args = { '-G', 'Ninja', '-DCMAKE_CXX_COMPILER=clang++', '-DCMAKE_C_COMPILER=clang' }
  dap_configuration = 'cppdbg'
elseif vim.g.is_win then
  platform_configure_args = {
      '-G', 'Ninja',
  }
  dap_configuration = 'cppdbg'
end

require('cmake').setup({
  cmake_executable = 'cmake',
  parameters_file = 'CMakeSettings.json',
  build_dir = tostring(Path:new('{cwd}', '..', 'build-{project_name}-{build_type}')),
  configure_args = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1', unpack(platform_configure_args) },
  build_args = { '-j', '10' },
  quickfix_height = 10,
  dap_configuration = { type = dap_configuration, request = 'launch' },
  dap_open_command = require('dap').repl.open,
})
