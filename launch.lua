local arg = ...

local str1 = [[
Start setup ?
]]

local str2 = [[
 * chest_side =                     (east,west...)
 * chest_type =                (draconic_chest...)
 * public_settings_access =           (true/false)
 * moderator_chest =                  (true/false)
 * use_soundAPI =                     (true/false)
 * use_monitor =                      (true/false)
 * monitor_scale =                 (0.5/1/2/3/4/5)
 * group1_color =               (red,lime,gold...)
 * group2_color =               (red,lime,gold...)
Documentation for each parameters available on the
github page ;)
]]

local function _read(x,y)
    term.setCursorPos(x,y)
    return read()
end

local _ts = tostring
local _tn = tonumber
local function _tb(_t) return _t == "true" end

local function update(path,input)
    local f = fs.open(path,"w")
    f.write(textutils.serialise(input))
    f.close()
end

local function _load(path)
    local f = fs.open(path,"r")
    output = textutils.unserialise(f.readAll())
    f.close()
    return output
end

local function _setup()
    term.clear()
    term.setCursorPos(1,1)
    print(str2)
    local i = {}
    i.chest_side = _ts(_read(17,2))
    i.chest_type = _ts(_read(17,3))
    i.public_settings_access = _read(29,4)
    i.checks_entry = _read(22,5)
    i.use_soundAPI = _read(19,6)
    i.use_monitor = _read(18,7)
    i.monitor_scale = _read(20,8)
    i.group1_color = _ts(_read(19,9))
    i.group2_color = _ts(_read(19,10))
    i.checks_entry_chest_name = "chest"
    i.selected = 0
    i.last_dest = ""
    i.launch_event = [[/door open]]
    i.leave_event = [[/door close]]
    update("/portal/config.txt",i)
    term.clear()
end

if not fs.exists("/portal/config.txt") then
    if arg == "setup" then
        _setup()
    else
        print(str1)
        e = read()
        if e == "y" then
            _setup()
        end
    end
end

-- DEBUT DU PROGRAMME

local version = "1.13" --(31/07/2020)
os.loadAPI("/portal/lib/f") 
os.loadAPI("/portal/lib/API") 

local index = _load("/portal/config.txt")

local p = peripheral.find(index.chest_type) 
local q = peripheral.find("peripheral")

if _tb(index.use_monitor) then
    m = peripheral.find("monitor")
    m.setTextScale(_tn(index.monitor_scale))
else
    m = term.current()
end

local list_items,items,stq = {},{},{}
local a,b,c,volume = 1,1,1,100
local chestSize,selected = p.getInventorySize(),index.selected
local side,rside = index.chest_side,f._rvdir(index.chest_side)
local w,h = m.getSize()
 
function vn(arg) return arg ~= nil end
 
function setWindows()
    bg = f.addWin(m,1,1,w,h) bg.reset = {bg_color="black"}
    list = f.addWin(m,1,2,w*3/5-1,chestSize) list.reset = {bg_color="black"}
    up_bar = f.addWin(m,1,1,w,1) up_bar.reset = {bg_color="lightGray",printText = function()
        f.centerText(up_bar,1,"selectionner une destination","black","lightGray") end}
    down_bar = f.addWin(m,1,h,w,h) down_bar.reset = {bg_color="lightGray",printText = function()
        f.centerTextRight(down_bar,1,"v"..version,"black","lightGray") end}
    scroll_bar = f.addWin(m,w*(3/5),2,1,h-1) scroll_bar.reset = {bg_color="lightGray",printText = function()
        f.cprint(scroll_bar,1,1,"^","black","gray")
        f.cprint(scroll_bar,1,h-2,"v","black","gray") end}
    bg2 = f.addWin(m,w*0.6+1,2,w*0.4+1,h-1) bg2.reset = {bg_color="gray",printText = function()
        f.cprint(bg2,2,1,"Status: ","white","gray")
        f.cprint(bg2,2,7,"Rechercher:","white","gray")
        f.drawLine(bg2,2,9,bg2.size[1]-2.4,"lightGray")
        f.cprint(bg2,2,11,"Taper dans le","white","gray")
        f.cprint(bg2,2,12," computer une ","white","gray")
        f.cprint(bg2,2,13," recherche.","white","gray")
        f.cprint(bg2,2,14,"Double-cliquer sur","white","gray")
        f.cprint(bg2,2,15," un nom pour se","white","gray")
        f.cprint(bg2,2,16," teleporter.","white","gray") end}
    b1 = f.addWin(bg2,2,3,bg2.size[1]-2,3) b1.reset = {bg_color="red",printText = function()
        f.centerText(b1,2,"fermer","black","red") end}
    b2 = f.addWin(bg2,2,18,bg2.size[1]-2,3) b2.reset = {bg_color="red",printText = function()
        f.centerText(b2,2,"quitter le module","black","red") end}
    b3 = f.addWin(bg2,bg2.size[1]-1,9,1,1) b3.reset = {bg_color="white",printText = function()
        f.cprint(b3,1,1,"x","lightGray","white") end}
end
 
function reset()
    bg.apply("reset") bg2.apply("reset") list.apply("reset")
    up_bar.apply("reset") down_bar.apply("reset") scroll_bar.apply("reset")
    b1.apply("reset") b2.apply("reset") b3.apply("reset")
    if vn(q) then
        local stq = q.getAllStacks()
        if stq[1] ~= nil then f.cprint(bg2,10,1,"ouvert","green","gray")
        else f.cprint(bg2,10,1,"en veille","yellow","gray") end
    end
    if word ~= nil then f.cprint(bg2,2,9,word,"gray","lightGray") end
end
 
function pulse()
    stq = q.getAllStacks()
    if stq[1] ~= nil then
        shell.run("/portal/lib/soundAPI","mystcraft:linking.link-disarm",volume,"1","false")
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
                --if API.check(VIP,items[b][2]) then items[b][3] = "orange"
                --elseif API.check(GUIDES,items[b][2]) then items[b][3] = "lime"
                --else items[b][3] = "gray" end
                items[b][3] = "gray"
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
  elseif direction == "down" and y+#items > h-1 then
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
 
setWindows() reset()
pulse()
shell.run("/portal/lib/soundAPI","mystcraft:linking.link-following",volume,"1","false")
shell.run(index.launch_event)
if _tb(index.moderator.chest) then shell.run("bg","/portal/moderator") end
  
while true do
    reset()
    getItems()
    list_display()
    down_bar.redraw()
    up_bar.redraw()
    x,y = list.getPosition()
    j,k = scroll_bar.getPosition()
    local e = {os.pullEvent()}
    if e[1] == "monitor_touch" then
        if e[4]-y+1 == selected and display[selected] ~= nil and e[3] < j-1 then
            up_bar.clear()
            f.centerText(up_bar,1,"ouverture...","black")
            pulse()
            sleep(0.5)
            p.pushItem(side,display[selected][1])
            shell.run("/portal/lib/soundAPI","mystcraft:linking.link-fissure",volume,"1","false")
            last_dest = display[selected][2]
            getItems()
        elseif e[4] > 1 and e[3] < j-1 then
            selected = e[4]-y+1
        elseif e[4] == 2 and e[3] == j then
            scroll("up")
        elseif e[4] == h-1 and e[3] == j then
            scroll("down")
        elseif bg2.isClicked(e[3],e[4]) then
            xc = e[3]-bg2.pos[1]+1 yc = e[4]-bg2.pos[2]+1
            if b1.isClicked(xc,yc) then
                up_bar.clear()
                f.centerText(up_bar,1,"fermeture...","black")
                pulse()
                sleep(0.4)
            elseif f.itrv(xc,2,bg2.size[1]-3) and f.itrv(yc,6,9) then
                search()
            elseif b2.isClicked(xc,yc) then
                pulse()
                shell.run(index.leave_event)
                m.clear()
                break
            elseif b3.isClicked(xc,yc) then
                word = ""
            end
        end
    end
    index.selected = selected
    update("/portal/config.txt",index)
    if e[1] == "char" then search(e[2]) end
end
