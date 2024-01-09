local file   = file
local string = string
local Target = "addons/%s/lua/workshop-upload/main.lua"

local function GetRootFolder()
    local _, Folders = file.Find("addons/*", "GAME")

    for _, Folder in ipairs(Folders) do
        local File = string.format(Target, Folder)

        if file.Exists(File, "GAME") then
            return "addons/" .. Folder .. "/"
        end
    end
end
