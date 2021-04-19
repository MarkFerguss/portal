--[[ Mark_functions v.1.86 (12/08/2020 20:51)
call os.loadAPI("f")
docs available soon
--]]
function progression_bar(m,x,y,length,curVal,bg_color,bar_color)
  drawLine(m,x,y,length,bg_color)
  percent_bar = curVal / 100 * length
  drawLine(m,x,y,percent_bar,bar_color)
end
function drawLine(m,x,y,length,color)
  if length < 0 then
  length = 0
  end
  m.setBackgroundColor(colors[color])
  m.setCursorPos(x,y)
  m.write(string.rep(" ",length))
end
function drawBox(m,x,y,x2,y2,color)
  for a=0,y2-y do
    drawLine(m,x,y+a,x2-x,color)
  end
  return x,y,x2,y2
end
function centerText(m,y,text,color,bg_color)
  w, h = m.getSize()
  m.setCursorPos((math.floor(w/2) - (math.floor(#text/2))) + 1,y)
  if bg_color ~= nil then m.setBackgroundColor(colors[bg_color]) end
  m.setTextColor(colors[color])
  m.write(text)
end
function centerTextRight(m,y,text,color,bg_color)
  w, h = m.getSize()
  m.setCursorPos(w - (math.floor(#text)),y)
  if bg_color ~= nil then m.setBackgroundColor(colors[bg_color]) end
  m.setTextColor(colors[color])
  m.write(text)
end
function print(m,text,color)
  m.setTextColor(colors[color])
  m.write(text.."\n")
  m.setTextColor(colors.white)
  x,y = m.getCursorPos()
  m.setCursorPos(1,y+1)
end
function cprint(m,x,y,text,color,bg_color)
  m.setCursorPos(x,y)
  m.setTextColor(colors[color])
  if bg_color ~= nil then m.setBackgroundColor(colors[bg_color]) end
  m.write(text)
  m.setBackgroundColor(colors.black)
  m.setTextColor(colors.white)
end
function format_int(number)
  if number == nil then number = 0 end
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end
function itrv(x,y,z)
  if x == nil or y == nil or z == nil then
    return false
  else
    return (x >= y and x <= z)
  end
end
function box(x,y,x1,y1,x2,y2)
  return (itrv(x,x1,x2) and itrv(y,y1,y2))
end
function vn(val)
  return (val ~= nil)
end
--[[
    val : a string, table, number or function
    
    The function returns true if the value isn't 'nil' or false if it is.
--]]
function cv(arg,cv1,param,cv2)
  if param == nil then error("No parameter found : usage cv(arg,val1,param,val2)") end
  if param == "or" then return (arg == cv1 or arg == cv2) end
  if param == "and" then return (arg == cv1 and arg == cv2)  end
end
--[[
    arg : the value you want to compare
    cv1 : value1
    cv2 : value2
    param : < or / and >
    
    parameters :
        - 'or' will compare if (arg == cv1 or arg == cv2)
        - 'and' will compare if (arg == cv1 or arg == cv2)
--]]
function check(list,name)
    local check = false
    for i,v in pairs(list) do
        if type(v) == "string" then
            if string.find(name,v) ~= nil then check = true end
            local array = i
        end
    end
    return check, array
end
function addWin(m,x1,y1,x2,y2)
    if m == nil then
        error("No object found")
    end
    local b = window.create(m,x1,y1,x2,y2)
    b.isWindow = true
    b.parent = m
    b.name = name
    function b.update()
        b.pos = {b.getPosition()}
        b.size = {b.getSize()}
        local dX = b.size[1]+b.pos[1]
        local dY = b.size[2]+b.pos[2]
        b.l = {b.pos[1],b.pos[2],dX,dY}
    end
    function b.isClicked(x,y)
        if b.parent.isWindow == true then
            ok, x, y = b.parent.isClicked(x,y)
            x=x+1 y=y+1
        end
        ok = f.box(x,y,b.l[1],b.l[2],b.l[3],b.l[4])
        if ok then tX = x-b.pos[1] tY = y-b.pos[2] end
        return ok, tX, tY
    end
    function b.drag(x,y,args)
        if b.isClicked(x,y) then
            local w,h = b.parent.getSize()
            local prototype = { __index = {
            bX = 1, bY = 1, bW = w, bH = h,
            } }
            local a = args or {}
            setmetatable(a, prototype)
            repeat
                e = {os.pullEvent()}
                local nX,nY = e[3]-x, e[4]-y
                local sX,sY = b.pos[1]+nX, b.pos[2]+nY
                if vn(a["redraw"]) then
                    for i,v in pairs(a["redraw"]) do
                        v[1].apply(v[2])
                    end
                end
                if a.borders == true then
                    if sX < a.bX then sX = a.bX end
                    if sY < a.bY then sY = a.bY end
                    if sX+b.size[1] > a.bW then sX = a.bW-b.size[1]+1 end
                    if sY+b.size[2] > a.bH then sY = a.bH-b.size[2]+1 end
                end
                b.reposition(sX,sY)
            until e[1] == "mouse_up"
            b.update()
            return nX or nY
        else
            return false
        end
    end
    function b.getName() return b.name end
    function b.apply(id)
        local this_color = b[id].bg_color
        b.setBackgroundColor(colors[this_color])
        b.clear()
        if f.vn(b[id].printText) then b[id].printText() end
    end
    b.update()
    return b
end
--[[
    m : parent (window object, term.native(), monitor ...)
    x1, y1 : relative position on the parent (screen)
    x2, y2 : do not confuse with coordinates. Those are length and width of the object
    name : bonus label to the table (not mandatory)
    
    the function returns an object which you can use whenever you want
    
    Object usages :
        - getName() : returns the object label
        - isClicked(x,y) : returns if the mouse_click/monitor_touch position is hovering the button
        - drag(x,y, [args] ) : if the window is clicked, the object will get dragged until the function detects a 'mouse_up' event.accuracy
            + args is a table. See exemple : { redraw = { {window2, "reset"},{} }, borders = true }
            + redraw parameters will automaticly redraw those windows each time the object changes its position.
            + borders will set a border within the object cannot get through. (only boolean true)
        - apply(name) : apply a preset font
        
    Font usages :
        - exemple : window = f.addWin(term.native(),1,1,20,5)
        -           window.reset = {bg_color = "back", printText = function() print("This is a button") end}
        -           window.apply("reset")
        Now, the object background will be filled in black with the printed text 'This is a button'
--]]
--print("WINDOWS = ",os.loadAPI("/lib/WindowAPI"))
--addSwitch = WindowAPI.addSwitch
--addSelector = WindowAPI.addSelector
