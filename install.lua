local default_path = "/portal"
local str1 = [[

	Projet 'portal' doesn't seem to be installed.
	Would you like to install it ? (y/n)

]]

local str2 = [[

	Portal project successfully downloaded!
	type 'launch' to start the program.

]]

local function download(path,content)
	if fs.exists(path) then fs.remove(path) end
	f = fs.open(path,"w")
	f.write(content)
	f.close()
end

if not fs.exists("/portal/lib/f") then
	download("/portal/lib/f",http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/lib/f.lua")
end
if not fs.exists("/portal/lib/API") then
	download("/portal/lib/API",http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/lib/API.lua")
end
if not fs.exists("/portal/lib/soundAPI") then
	download("/portal/lib/soundAPI",http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/lib/soundAPI.lua")
end
if not fs.exists("/portal/moderator") then
	download("/portal/moderator",http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/moderator.lua")
end
if not fs.exists("/portal/setup") then
	download("/portal/setup",http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/setup.lua")
end

if not fs.exists("/portal/launch") then
	print(str1)
	if read() == "y" then
		download("/portal/launch",http.get("https://raw.githubusercontent.com/MarkFerguss/portal/main/launch.lua"))
	end
	shell.run([[cd /portal]])
	print(str2)
end

