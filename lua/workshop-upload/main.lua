local file   = file
local string = string
local Target = "addons/%s/lua/workshop-upload/main.lua"
local Head   = "ref: refs/heads/(%w+)"

local function GetRootFolder()
    local _, Folders = file.Find("addons/*", "GAME")

    for _, Folder in ipairs(Folders) do
        local File = string.format(Target, Folder)

        if file.Exists(File, "GAME") then
            return "addons/" .. Folder .. "/"
        end
    end
end

local function GetBranch(Path)
    local Content = file.Read(Path .. "/.git/HEAD", "GAME")

    return string.match(Content, Head) -- NOTE: Will fail if the branch has any non-alphanumerical characters!
end

local function GetLatestCommit(Path, Branch)
    return file.Read(Path .. "/.git/refs/heads/" .. Branch, "GAME")
end

local function PrintVersion()
    local Path   = GetRootFolder()
    local Branch = GetBranch(Path)
    local Commit = GetLatestCommit(Path, Branch)

    print(Branch .. "-" .. string.sub(Commit, 1, 6))
end

PrintVersion()
