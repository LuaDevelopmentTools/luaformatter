#!/usr/bin/env lua
-- Check interpreter version
if _VERSION ~= 'Lua 5.1' then
  print 'Only compatible with Lua 5.1'
  return
end

local help = [[Formats Lua code.
  -a, --autosave Flush formatted Lua in given file instead of stdout.
  -s, --spaces (default 2) Spaces to use as indentation.
  -t, --tabs   (default 0) Tabulation(s) to use as indentation.
  -d, --delimiter (default unix) Type of new line to detect and use while formatting:
    * unix: '\n' LF Line feed.
    * windows: '\r\n' CR+LF
    * mac: '\r' CR Carriage Return of Macs before OSX.
  -h, --help This help.
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
  -- Default indentation
  args.spaces = 2
end

-- Compute indentation sequence
local indentation
if args.tabs > 0 then
  -- Use tabs when asked
  local char = '\t'
  indentation = char:rep(args.tabs)
else
  -- Use spaces elseway
  local char = ' '
  indentation = char:rep(args.spaces)
end

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
  local file, err = io.open(filename, 'r')
  if not file then print( err ) return end
  local code, err = file:read('*a')
  if not code then print( err ) return end
  file:close()

  -- Format source
  local formatted, errormessage = formatter.indentcode(code, delimiter, true,
    indentation)
  if formatted then
    if args.autosave then
      -- Saving formatted code straight in original file
      local file, err = io.open(filename, 'w+')
      if not file then print( err ) return end
      local code, err = file:write(formatted)
      if not code then print( err ) return end
      file:close()
    else
      io.write(formatted)
    end
  else
    print(string.format('Unable to format `%s`:\n%s', filename, errormessage))
  end
end
