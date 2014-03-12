# Lua Formatter

This library beautify Lua code:

* Indent block
* Indent expressions
* Trim trailing white spaces

It is plain _Lua 5.1_.

## Prerequisites

* Lua 5.1
* Metalua >= 0.7

## Installation

```sh
$ luarocks install --local formatter
```

## How does it work?

### Library

```lua
$ lua
Lua 5.1.5  Copyright (C) 1994-2012 Lua.org, PUC-Rio
> formatter = require 'formatter'
> code = [[do
>> local var = 
>> 42
>> end]]
> formattedcode = formatter.indentcode(code, '\n', true, '  ')
> print( formattedcode )
do
  local var =
    42
end
```

### Command line

```sh
$ cat sample.lua
do
local var =
42
end
$ luaformatter sample.lua
do
  local var =
    42
end
```

Want more options?

```sh
$ luaformatter --help
Formats Lua code.
  -a, --autosave Flush formatted Lua in given file instead of stdout.
  -s, --spaces (default 2) Spaces to use as indentation.
  -t, --tabs   (default 0) Tabulation(s) to use as indentation.
  -d, --delimiter (default unix) Type of new line to detect and use while formatting:
    * unix: '\n' LF Line feed.
    * windows: '\r\n' CR+LF
    * mac: '\r' CR Carriage Return of Macs before OSX.
  -h, --help This help.
  [files] Files to format.
```
