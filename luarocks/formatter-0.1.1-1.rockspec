package = 'Formatter'
version = '0.1.1-1'
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
  url = 'https://github.com/LuaDevelopmentTools/luaformatter/archive/v0.1.1-1.zip'
}
dependencies = {
  'metalua-compiler >= 0.7',
  'penlight ~> 0.9.8'
}
build = {
  type = 'builtin',
  install = {
    bin = {
      luaformatter = 'commandline.lua'
    },
  },
  modules = {
    formatter = 'formatter.lua'
  }
}
