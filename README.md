# Lua Formatter

This library beautify Lua code:

* Indent block
* Indent expressions
* Trim trailing white spaces

It is plain _Lua 5.1_.

## Prerequisites

* Lua 5.1
* Metalua >= 0.7

## Usage sample

```bash
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
