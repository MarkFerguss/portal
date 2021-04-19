input = ''
 
function reset()
  input = ''
end
 
function read(m,length,bg_color,input)
  if input == nil then input = "" end
  local m2 = term.native()
  local x,y = m.getCursorPos()
  local x2,y2 = m2.getCursorPos()
  m.setCursorBlink(true)
  m2.setCursorBlink(true)
  if bg_color ~= nil then m.setBackgroundColor(colors[bg_color]) end
  repeat
        m.setCursorPos(x,y)
        m.write(input)
        m2.setCursorPos(x2,y2)
        m2.write(input)
        local ev, p1 = os.pullEvent()
        if ev == 'char' then
          if #input < length then
            input = input .. p1
          end
        elseif ev == 'key' then
          if p1 == keys.backspace then
            if #input ~= 0 then
            local x1, y1 = m.getCursorPos()
            local x2, y2 = m2.getCursorPos()
            m.setCursorPos(x1-1, y1)
            m.write(" ")
            m2.setCursorPos(x2-1,y2)
            m2.write(" ")
            end
            input = input:sub(1, #input - 1)
          end
        end
  until ev == 'key' and p1 == keys.enter or ev == 'mouse_click' or ev == 'monitor_touch'
  m.setCursorBlink(false)
  m2.setCursorBlink(false)
  m2.clearLine() m2.setCursorPos(x2,y2)
  return input, ev, p1
end
 
function check(list,name)
  local chk = false
  for i,v in pairs(list) do
    if string.find(name,v) ~= nil then chk = true end
  end
  if chk == true then return true else return false end
end
function unlock(p,word)
  local chestSize = p.getInventorySize()
  list = {}
  if chestSize ~= nil then
    for a=1,chestSize do
      list[a] = p.getStackInSlot(a)
      if list[a] ~= nil and list[a].name == "teleporterMKI" then
        if string.find(word,list[a].display_name) ~= nil then return true end
      end
    end
  end
end
 
 
-- descendre plus bas conduit a un crash de l'editeur
 
local tableAccents = {}
    tableAccents["ý"] = "y"
    tableAccents["ÿ"] = "y"
    tableAccents["À"] = "A"
    tableAccents["Á"] = "A"
    tableAccents["Â"] = "A"
    tableAccents["Ã"] = "A"
    tableAccents["Ä"] = "A"
    tableAccents["Ç"] = "C"
    tableAccents["È"] = "E"
    tableAccents["É"] = "E"
    tableAccents["Ê"] = "E"
    tableAccents["Ë"] = "E"
    tableAccents["Ì"] = "I"
    tableAccents["Í"] = "I"
    tableAccents["Î"] = "I"
    tableAccents["Ï"] = "I"
    tableAccents["Ñ"] = "N"
    tableAccents["Ò"] = "O"
    tableAccents["Ó"] = "O"
    tableAccents["Ô"] = "O"
    tableAccents["Õ"] = "O"
    tableAccents["Ö"] = "O"
    tableAccents["Ù"] = "U"
    tableAccents["Ú"] = "U"
    tableAccents["Û"] = "U"
    tableAccents["Ü"] = "U"
    tableAccents["Ý"] = "Y"
 
function normalize(str)
 return (str:gsub("[%z\1-\127\194-\244][\128-\191]*", tableAccents))
end
