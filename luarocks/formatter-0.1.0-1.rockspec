package = 'Formatter'
version = '0.1.0-1'
description = {
  summary = 'Beautifies Lua code.',
  detailed = [[
    This library beautify Lua code:
    * Indent block
    * Indent expressions
    * Trim trailing white spaces
    It is plain Lua 5.1.
  ]],
  license = 'EPL'
}
source = {
  url = 'git://github.com/LuaDevelopmentTools/luaformatter.git',
  tag = 'v0.1.0'
}
dependencies = {
  'metalua-compiler == 0.7.2'
}
build = {
  type = 'builtin',
  modules = {
    formatter = 'formatter.lua'
  }
}
