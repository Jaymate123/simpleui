-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------
include("skins/modernui.lua")
include("skins/modernui_dark.lua")

MUI = {}

MUI.Convar = CreateClientConVar("mui_darkify", 0, true, false, "If 1, then UI shall be darkified! Otherwise it will be white theme :)", 0, 1)
MUI.hudbg =  CreateClientConVar("mui_hudbg", 0, true, false, "SUI HUD Background", 0, 1)


MUI.colors = {
       light = {
       main = Color(255, 255, 255),
       second = Color(230, 230, 230),
	   text = Color(35, 35, 35)
    },
    
    dark = {
       main = Color(35, 35, 35),
       second = Color(50, 50, 50),
	   text = Color(255, 255, 255)
    },
}

function MUI.Current()
	return MUI.Convar:GetBool() and "mui_dark" or "mui"
end

function MUI.Get()
    return MUI.Convar:GetBool() and MUI.colors.dark or MUI.colors.light
end

function MUI.GetTextColor()
	return MUI.hudbg:GetBool() and MUI.Get().text or MUI.colors.dark.text
end
    
local chatCommands = {
	["!dark"] = function() 
		RunConsoleCommand("mui_darkify", "1")
	end,
	["!light"] = function()
		RunConsoleCommand("mui_darkify", "0")
	end,
}
hook.Add("OnPlayerChat", "mui_darkify", function( ply, strText, bTeam, bDead )
	if ply == LocalPlayer() then
		strText = string.lower( strText )
		if chatCommands[strText] != nil then
			chatCommands[strText]()
			return true
		end
	end
end)