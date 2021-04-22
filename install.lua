local install_version = "1.0"

shell.run([[pastebin run Xa4Bucuf]],install_version)

local str1 = [[

	Projet 'portal' doesn't seem to be installed.
	Would you like to install it ? (y/n)

]]

local str2 = [[

	Portal project successfully downloaded!
	type 'launch' to start the program.

]]

local function download(path,rep)
	if fs.exists(path) then fs.remove(path) end
	local content = http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/"..rep)
	f = fs.open(path,"w")
	f.write(content.readAll())
	f.close()
end

if not fs.exists("/portal/lib/f") then
	download("/portal/lib/f","lib/f.lua")
	print("/ /portal/lib/f downloaded")
end
if not fs.exists("/portal/lib/API") then
	download("/portal/lib/API","lib/API.lua")
end
if not fs.exists("/portal/lib/soundAPI") then
	download("/portal/lib/soundAPI","lib/soundAPI.lua")
end
if not fs.exists("/portal/moderator") then
	download("/portal/moderator","moderator.lua")
end
if not fs.exists("/portal/setup") then
	download("/portal/setup","setup.lua")
end

if not fs.exists("/portal/launch") then
	print(str1)
	if read() == "y" then
		download("/portal/launch","launch.lua")
	end
	shell.run([[cd /portal]])
	print(str2)
end
