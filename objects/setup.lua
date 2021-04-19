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

local function update(path,input)
    local f = fs.open(path,"w")
    f.write(textutils.serialise(input))
    f.close()
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
    i.launch_event = ""
    i.leave_event = ""
    update("/portal/config.txt",i)
    term.clear()
end

_setup()
