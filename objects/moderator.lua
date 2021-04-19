local f = fs.open("/portal/config.txt","r")
local i = textutils.unserialise(f.readAll())
f.close()

local c = peripheral.find(i.moderator_chest_name)

local chestSize = c.getInventorySize()
local accept = i.moderator_chest_accepts
local deny = i.moderator_chest_denies
 
function note() end
 
while true do
  items = {}
  if chestSize ~= nil and c.getAllStacks() ~= nil then
    for a=1,chestSize do
      items[a] = c.getStackInSlot(a)
      if items[a] ~= nil then
        if items[a].name == "teleporterMKI" and items[a].nbt_hash ~= nil and items[a].display_name ~= "Charm of Dislocation" then
          c.pushItem(accept,a) note()
        else c.pushItem(deny,a) end
      end
    end
  end
  sleep(1)
end
