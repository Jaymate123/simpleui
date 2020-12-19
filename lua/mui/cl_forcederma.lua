-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------
if SERVER then
	AddCSLuaFile("skins/modernui.lua")
	AddCSLuaFile("skins/modernui_dark.lua")
	AddCSLuaFile()

	resource.AddSingleFile("materials/gwenskin/modernui.png")
	resource.AddSingleFile("materials/gwenskin/modernui_dark.png")
else
	include("skins/modernui.lua")

	timer.Simple(0.1, function()
		hook.Add("ForceDermaSkin", "skinforcehook", function()
			derma.RefreshSkins()
			return MUI.Current()
		end)
		derma.RefreshSkins()  
	end)
end
