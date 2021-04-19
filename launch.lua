local arg = ...

local str1 = [[

Start setup ?

]]

local str2 = [[

 * chest_side =                     (east,west...)
 * chest_type =                 draconic_chest...)
 * public_settings_access =           (true/false)
 * use_monitor =                      (true/false)
 * use_soundAPI =                     (true/false)
 * group1_color =               (red,lime,gold...)
 * group2_color =               (red,lime,gold...)

]]

local function _read(x,y)
	term.setCursorPos(x,y)
	return read()
end

local function update(path,input)
	local f = fs.open(path,"w")
	f.write(input)
	f.close()
end

if not fs.exists("/portal/config.txt") then
	print(str1)
	e = read()
	if e == "y" then
		term.clear()
		term.setCursorPos(1,1)
		print(str2)
		local i = {}
		i.chest_side = _read(17,2)
		i.chest_type = _read(17,3
		i.public_settings_access = _read(29,4)
		i.use_monitor = _read(18,5)
		i.use_soundAPI = _read(19,6)
		i.group1_color = _read(19,7)
		i.group2_color = _read(19,8)
		update("/portal/config.txt",i)
	end
end

local version = "1.13" --(31/07/2020)
os.loadAPI("/portal/lib/f") -- a monitor API made by myself, it makes my life easier
os.loadAPI("/portal/lib/API") -- search_bar

local p = peripheral.find("draconic_chest") -- can change from "chest" instead of "draconic_chest"
local m = peripheral.find("monitor") -- running on a monitor
local q = peripheral.find("peripheral")
m.setTextScale(1)
local side,rside = "west","east" -- IMPORTANT
local list_items,items,stq = {},{},{}
local a,b,c,volume = 1,1,1,100
local selected,last_dest = 0,"aucun"
local chestSize = p.getInventorySize()
local w,h = m.getSize()
 
local VIP = {"TheBaslez","SesameChocolat","Jaguar","LeChikito","jungleis26","Ertupop","Veine","annelaure1912","Gaetann18",
"GohuSan","boucherreb","Ciliste"}
local GUIDES = {"zorinova","DaikiKaminari","maxou684"}
 
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
        shell.run("/lib/soundAPI","mystcraft:linking.link-disarm",volume,"1","false")
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
                items[b][2] = list_items[a].display_name
                if API.check(VIP,items[b][2]) then items[b][3] = "orange"
                --elseif API.check(GUIDES,items[b][2]) then items[b][3] = "lime"
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
shell.run("/lib/soundAPI","mystcraft:linking.link-following",volume,"1","false")
shell.run("/door","open")
  
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
            shell.run("/lib/soundAPI","mystcraft:linking.link-fissure",volume,"1","false")
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
                shell.run("/door","close")
                m.clear()
                break
            elseif b3.isClicked(xc,yc) then
    word = ""
   end
        end
    end
    if e[1] == "char" then search(e[2]) end
end