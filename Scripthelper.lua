local owner = "Upbolt"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/eo-eo-eo/extras/refs/heads/main/Remote.Bind%20fire%20tool%20open%20source.lua"))()
