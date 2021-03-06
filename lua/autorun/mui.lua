-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------
if SERVER then
    resource.AddWorkshop( '2321664841' )
end

local function includ(name)
	if SERVER then
        AddCSLuaFile("mui/" .. name)
	else 
		include("mui/" .. name)
	end
end

for k, v in ipairs ({
	"cl_init.lua",
    "cl_hud.lua",
    "cl_notifications.lua",
    "cl_fpsenhance.lua",
    "cl_scoreboard.lua",
    "cl_weaponselector.lua",
    "cl_forcederma.lua",
    "cl_settings.lua",
    "sv_disableuselesswidgets.lua"
}) do
    includ(v)
end
