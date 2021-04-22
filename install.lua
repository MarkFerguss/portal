local default_path = "/portal"
local str1 = [[

	Projet 'portal' doesn't seem to be installed.
	Would you like to install it ? (y/n)

]]

local str2 = [[

	Project 'portal' has been succesfully downloaded.
	Would you like to proceed to the setup now ? (y/n)

]]

if not fs.exists("/portal/launch") then
	print(str1)
	if read() == "y" then
		shell.run("/github","MarkFerguss","portal","/")
		fs.move("/portal/launch.lua","/portal/launch")
        fs.move("/portal/moderator.lua","/portal/moderator")
		fs.move("/portal/lib/f.lua","/portal/lib/f")
		fs.move("/portal/lib/soundAPI.lua","/portal/lib/soundAPI")
		fs.move("/portal/lib/API.lua","/portal/lib/API")
		if fs.exists("/config.txt") then
	    	fs.move("/config.txt","/portal/config.txt")
		end
		term.clear()
		print(str2)
		e = read()
		if e == "y" then
			shell.run("/portal/launch","setup")
		end
		term.clear()
	end
end
