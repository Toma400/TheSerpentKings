import strutils

proc getCurrentDir* (): string =
  result = currentSourcePath().replace("utils.nim", "")