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
tableAccents["åA0"] = "a"
tableAccents["åA1"] = "a"
tableAccents["åA2"] = "a"
tableAccents["åA3"] = "a"
tableAccents["åA4"] = "a"
tableAccents["åA7"] = "c"
tableAccents["åA8"] = "e"
tableAccents["åA9"] = "e"
tableAccents["ê"] = "e"
tableAccents["åAB"] = "e"
tableAccents["åAC"] = "i"
tableAccents["åAD"] = "i"
tableAccents["åAE"] = "i"
tableAccents["åAF"] = "i"
tableAccents["åB1"] = "n"
tableAccents["åB2"] = "o"
tableAccents["åB3"] = "o"
tableAccents["åB4"] = "o"
tableAccents["õ"] = "o"
tableAccents["åB6"] = "o"
tableAccents["åB9"] = "u"
tableAccents["ú"] = "u"
tableAccents["åBB"] = "u"
tableAccents["åBC"] = "u"
tableAccents["åBD"] = "y"
tableAccents["åBF"] = "y"
tableAccents["å80"] = "A"
tableAccents["å81"] = "A"
tableAccents["å82"] = "A"
tableAccents["å83"] = "A"
tableAccents["å84"] = "A"
tableAccents["å87"] = "C"
tableAccents["å88"] = "E"
tableAccents["å89"] = "E"
tableAccents["å8A"] = "E"
tableAccents["å8B"] = "E"
tableAccents["å8C"] = "I"
tableAccents["å8D"] = "I"
tableAccents["å8E"] = "I"
tableAccents["å8F"] = "I"
tableAccents["å91"] = "N"
tableAccents["å92"] = "O"
tableAccents["å93"] = "O"
tableAccents["å94"] = "O"
tableAccents["å95"] = "O"
tableAccents["å96"] = "O"
tableAccents["å99"] = "U"
tableAccents["å9A"] = "U"
tableAccents["å9B"] = "U"
tableAccents["å9C"] = "U"
tableAccents["å9D"] = "Y"
 
function normalize(str)
 return (str:gsub("[%z\1-\127\194-\244][\128-\191]*", tableAccents))
end
