#!/usr/bin/env lua
-- Check interpreter version
if _VERSION ~= 'Lua 5.1' then
  print 'Only compatible with Lua 5.1'
  return
end

local help = [[Formats Lua code.
  -s, --spaces Use spaces as indentation.
  -t, --tabs   Use tabulations as indentation.
  -d, --delimiter (default unix) Type of new line to detect and use while formatting:
    * unix: '\n' LF Line feed.
    * windows: '\r\n' CR+LF
    * mac: '\r' CR Carriage Return of Macs before OSX.
  -h, --help This help.
  <indentationsize> (number) Count of spaces or tabulation to use as indentation.
  [files] Files to format.
]]
local lapp = require 'pl.lapp'
local args = lapp( help )

-- Print help
if not args or args.help then
  print( help )
  return
end

--
-- Check arguments
--
if #args == 0 then
  print 'No files to format.'
  return
elseif not (args.spaces or args.tabs) then
  print 'No indentation sequence, please provide --spaces or --tabs.'
  return
end

-- Compute indentation
local char = args.tabs and '\t' or ' '
local indentation = char:rep(args.indentationsize)

-- End of line to use
local delimiters = {
  mac = '\r',
  unix = '\n',
  windows = '\r\n'
}
local delimiter = delimiters[ args.delimiter ]
if not delimiter then
  print( string.format('Unhandled delimiter: %s.', args.delimiter) )
  return
end

--
-- Output formatted file
--
local formatter = require 'formatter'
for _, filename in ipairs(args) do

  --
  -- Reading file
  --
  local file, err = io.open(filename,'r')
  if not file then print( err ) return end
  local code, err = file:read('*a')
  if not code then print( err ) return end
  file:close()

  -- Check if code is valid
  local valid, err = pcall(loadstring, code, 'codetoformat')
  if not valid then print(err) return end

  -- Format source
  local formatted = formatter.indentcode(code, delimiter, true, indentation)
  io.write(formatted)
end
