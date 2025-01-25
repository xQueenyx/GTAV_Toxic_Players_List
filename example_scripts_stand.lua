util.require_natives("2944a", "g") -- choose native


-- set some paths
local StoreDirStand <const> = filesystem.store_dir() .. "\\" -- this one exists already after launching stand itsel
local MaliciousPlayerStore <const> = StoreDirStand .. "MaliciousPlayerStoring\\"
local filename = "gameinfo.json" -- I'd recommend not changing it since the remote file is called like that too but it's up to you in the end :3


if not filesystem.exists(MaliciousPlayerStore) then
    filesystem.mkdir(MaliciousPlayerStore)
    util.toast("Creating malicious player storing directory")
end

if not filesystem.exists(MaliciousPlayerStore .. filename) then -- check whether it exists or not
    local file = io.open(MaliciousPlayerStore .. filename, "w") -- if not open the file in WRITE mode and close it again
    file:close()
end

-- setup complete

-- download
util.toast("[Scriptname]: Downloading remote gameinfo.json")
async_http.init("https://raw.githubusercontent.com/xQueenyx/GTAV_Toxic_Players_List/refs/heads/main/gameinfo.json", "", function (result, header_fields, status_code)
    local gameinfo = io.open(MaliciousPlayerStore .. filename, "w+")
    if gameinfo == nil then
        util.toast("Could not write file for: " .. MaliciousPlayerStore)
    end
    gameinfo:write(result)
    gameinfo:close()
    util.toast("Retreived gameinfo.json from remote repository :)")
end, function (e)
    util.toast("Could not download the gameinfo.json: " .. e)
end)
async_http.dispatch()
-- end of download

-- load json
local json = require "json" -- import json to use it by using the term require

local function decode_gameinfo_via_json()
    local file = io.open(StoreDirStand .. filename, "r")
    if file then
        local content = file:read("a")
        file:close()
        return json.decode(content) -- return the content in the json by decoding it
    else
        util.toast("Failed to open gameinfo.json. Ensure it's there!")
    end
    -- return your json here
end

local gameinfo = decode_gameinfo_via_json() -- load gameinfo here - call is possible via gameinfo.blacklist then (the blacklist ist called blacklist - that's why :P)

local function CheckBlacklist(rid)
    for _, entry in ipairs(gameinfo.blacklist) do -- call the blacklist
    -- handle your logic here for the blacklist
        if entry.rid == rid then
            -- handle it accordingly (e.g. notifications or something else but not too much!)
            return true -- return true so the player function can call the hostkick
        end
    end
    return false -- nothing detected, return false
end

local function player(pid)
    if players.user() == players.get_host() then -- check whether you're host or not
        if CheckBlacklist(players.get_rockstar_id(pid)) then -- if the 'if' condition is true the player receives a hostkick
            NETWORK_SESSION_KICK_PLAYER(pid) -- no namespace needed since the native we have doesn't support it (look it up yourself. Namespaces are ENTITY. || PLAYER. || PED. [in C++ ENTITY:: || PLAYER:: || etc.])
        end
    end
end

util.on_join(player)

util.keep_running()