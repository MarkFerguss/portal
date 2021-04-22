local arg = ...
local version = "1.13" --(31/07/2020)
os.loadAPI("/portal/lib/f") 
os.loadAPI("/portal/lib/API") 

local _ts = tostring
local _tn = tonumber
local function _tb(_t) return _t == "true" end

if not fs.exists("/portal/config.txt") then shell.run("/portal/setup") end
local index = f.load("/portal/config.txt")

function _getp()
    p = peripheral.find(index.chest_type) 
    q = peripheral.find("peripheral")
    if (_tb(index.use_monitor) and peripheral.find("monitor") ~= nil) then
        m = peripheral.find("monitor")
        m.setTextScale(_tn(index.monitor_scale))
    else
        m = term.current()
    end
    chestSize = p.getInventorySize()
    w,h = m.getSize()
end

local list_items,items,stq = {},{},{}
local a,b,c,volume = 1,1,1,100
local selected = index.selected
local side,rside = index.chest_side,f.rvdir(index.chest_side)
 
-- TOOLS

function vn(arg) return arg ~= nil end
 
function setWindows()
    bg = f.addWin(m,1,1,w,h) bg.reset = {bg_color="black"}
    list = f.addWin(m,1,2,w*3/5-1,chestSize) list.reset = {bg_color="black"}
    up_bar = f.addWin(m,1,1,w,1) up_bar.reset = {bg_color="lightGray",printText = function()
        f.centerText(up_bar,1,"Select a destination","black","lightGray") end}
    down_bar = f.addWin(m,1,h,w,h) down_bar.reset = {bg_color="lightGray",printText = function()
        f.centerTextRight(down_bar,1,"v"..version,"black","lightGray")
        f.cprint(down_bar,1,1,"Last destination: ","black","lightGray") end}
    scroll_bar = f.addWin(m,w*(3/5),2,1,h-1) scroll_bar.reset = {bg_color="white"}
    bg2 = f.addWin(m,w*0.6+1,2,w*0.4+1,h-1) bg2.reset = {bg_color="gray",printText = function()
        f.cprint(bg2,2,1,"Status: ","white","gray")
        f.cprint(bg2,2,7,"Search:","white","gray")
        f.drawLine(bg2,2,9,bg2.size[1]-2.4,"lightGray") end}
    b1 = f.addWin(bg2,2,3,bg2.size[1]-2,3) b1.reset = {bg_color="red",printText = function()
        f.centerText(b1,2,"close","gray","red") end}
    b2 = f.addWin(bg2,2,15,bg2.size[1]-2,3) b2.reset = {bg_color="red",printText = function()
        f.centerText(b2,2,"leave","gray","red") end}
    b3 = f.addWin(bg2,bg2.size[1]-1,9,1,1) b3.reset = {bg_color="white",printText = function()
        f.cprint(b3,1,1,"x","lightGray","white") end}
    bs = f.addWin(bg2,2,11,bg2.size[1]-2,3) bs.reset = {bg_color="red",printText = function()
        f.centerText(bs,2,"options","gray","red") end}
    bg3 = f.addWin(m,w*0.6+1,2,w*0.4+1,h-1,false) bg3.reset = {bg_color="gray",printText = function()
        f.cprint(bg2,2,1,"Name: ","white","gray") end}
    b4 = f.addWin(bg3,2,3,bg2.size[1]-2,3,false) b4.reset = {bg_color=c_grp1,printText = function()
        f.centerText(b4,2,"Add to group","gray",c_grp1) end}
    b5 = f.addWin(bg3,2,18,bg2.size[1]-2,3,false) b5.reset = {bg_color=c_grp2,printText = function()
        f.centerText(b5,2,"Add to groupe","gray",c_grp2) end}
end
 
function reset()
    bg.apply("reset") bg2.apply("reset") list.apply("reset")
    up_bar.apply("reset") down_bar.apply("reset") scroll_bar.apply("reset")
    bs.apply("reset") b1.apply("reset") b2.apply("reset") b3.apply("reset")
    if vn(q) then
        local stq = q.getAllStacks()
        if stq[1] ~= nil then f.cprint(bg2,10,1,"opened","green","gray")
        else f.cprint(bg2,10,1,"closed","yellow","gray") end
    end
    if word ~= nil then f.cprint(bg2,2,9,word,"gray","lightGray") end
    f.cprint(down_bar,19,1,_ts(index.last_dest),"blue","lightGray")
end
 
function pulse()
    stq = q.getAllStacks()
    if stq[1] ~= nil then
        if _tb(index.use_soundAPI) then shell.run("/portal/lib/soundAPI","mystcraft:linking.link-disarm",volume,"1","false") end
        q.pushItem(rside,1)
    end
end
 
function getItems()
    local b = 1
    items = {}
    if chestSize ~= nil then
        for a=1,chestSize do
            list_items[a] = p.getStackInSlot(a)
            if list_items[a] ~= nil and list_items[a].name == "teleporterMKI" then
                items[b] = {}
                items[b][1] = a
                items[b][2] = API.normalize(list_items[a].display_name)
                if f.check(index.grp1,items[b][2]) then items[b][3] = _ts(index.group1_color)
                elseif f.check(index.grp2,items[b][2]) then items[b][3] = _ts(index.group2_color)
                else items[b][3] = "gray" end
                b = b + 1
            end
        end
    end
    table.sort(items, function(a, b) return a[2] < b[2] end)
    if display == nil then display = items end
end
 
function list_display()
  for c=1,#display do
    if c == selected then
      f.drawLine(list,1,c,w,"red")
      f.centerTextRight(list,c,"ouvrir","white")
    else
      list.setBackgroundColor(colors.black)
    end
    f.cprint(list,1,c,display[c][2],display[c][3])
  end
end
 
function scroll(direction)
  local x,y = list.getPosition()
  if direction == "up" and y <=1 then
    list.reposition(1,y+2)
  elseif direction == "down" and y+#items > h then
    list.reposition(1,y-2)
  end
end
 
function search(entry)
    bg2.setCursorPos(2,9)
    word = API.read(bg2,30,"lightGray",entry)
    display = {}
    for i,v in pairs(items) do
        if string.find(v[2],word) ~= nil then
            table.insert(display,v)
        end
    end
end
 
_getp() setWindows() reset() pulse()
if _tb(index.use_soundAPI) then shell.run("/portal/lib/soundAPI","mystcraft:linking.link-following",volume,"1","false") end
shell.run(index.launch_event)
if _tb(index.moderator_chest) then shell.run("bg","/portal/moderator") end
  
while true do
    reset()
    getItems()
    list_display()
    down_bar.redraw()
    up_bar.redraw()
    x,y = list.getPosition()
    j,k = scroll_bar.getPosition()
    local e = {os.pullEvent()}
    if e[1] == "peripheral_detach" or e[1] == "peripheral" then _getp() setWindows() end
    if e[1] == "monitor_resize" then _getp() setWindows() end
    if e[1] == "monitor_touch" or e[1] == "mouse_click" then
        if e[4]-y+1 == selected and display[selected] ~= nil and e[3] < j-1 then
            up_bar.clear()
            f.centerText(up_bar,1,"opening...","black")
            pulse()
            sleep(0.5)
            p.pushItem(side,display[selected][1])
            if _tb(index.use_soundAPI) then shell.run("/portal/lib/soundAPI","mystcraft:linking.link-fissure",volume,"1","false") end
            index.last_dest = display[selected][2]
            getItems()
        elseif e[4] > 1 and e[3] < j-1 then
            selected = e[4]-y+1
        elseif (e[3] == j and e[4] == 2) then
            scroll("up")
        elseif (e[3] == j and e[4] == h-1) then
            scroll("down")
        elseif bg2.isClicked(e[3],e[4]) then
            xc = e[3]-bg2.pos[1]+1 yc = e[4]-bg2.pos[2]+1
            if b1.isClicked(xc,yc) then
                up_bar.clear()
                f.centerText(up_bar,1,"closing...","black")
                pulse()
                sleep(0.4)
            elseif f.itrv(xc,2,bg2.size[1]-3) and f.itrv(yc,6,9) then
                search()
            elseif b2.isClicked(xc,yc) then
                pulse()
                shell.run(index.leave_event)
                shell.run("clear")
                m.clear()
                break
            elseif b3.isClicked(xc,yc) then
                word = ""
            end
        end
    end
    index.selected = selected
    f.update("/portal/config.txt",index)
    if e[1] == "char" then search(e[2]) end
    if e[1] == "mouse_scroll" and e[2] == 1 then scroll("down") end
    if e[1] == "mouse_scroll" and e[2] == -1 then scroll("up") end
    x,y = list.getPosition()
    local b_l = ((h-2)/#items)*h
    local sY = math.abs(y-2)
    local nY = ((sY / ( #items - h )) * (h-b_l-2)) +2
    scroll_bar.reposition(j,nY,1,b_l)
end
