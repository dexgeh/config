function conky_xmonadStatus()
  local f = io.open("/tmp/xmonad-status","r")
  local content = f:read("*all")
  f:close()
  return content
end
