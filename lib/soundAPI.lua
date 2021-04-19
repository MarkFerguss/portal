local nb = peripheral.find("note_block")

local args = {...}

local sound = args[1]
local pitch = args[3]
local volume = args[2]
local Visible = (args[4] ~= nil and args[4] == "true") --Checks if debug mode is activated

if args == {} then
  print("Usage : soundAPI <sound> <volume> <pitch>")
else
  nb.playSound(sound, pitch, volume) 
  if Visible then print(textutils.serialise(args)) end
end
