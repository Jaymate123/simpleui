-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------

include( "mui/cl_init.lua" )

function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSuitPower", "CHudSecondaryAmmo", "CHudDeathNotice"})do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideBadHud", hidehud)

surface.CreateFont("muiHUD", {
    font = "Open Sans",
    size = 40,
})

surface.CreateFont("death", {
    font = "Open Sans",
    size = 28,
})

local Health = Color( 235, 73, 75 )
local HealthBG = Color( 173, 55, 57 )
local Armor = Color( 73, 154, 235 )
local ArmorBG = Color( 55, 110, 173 )
local White = Color( 255, 255, 255 )

local w = ScrW()
local h = ScrH()
local x = 90
local y = 70
local a = 25
local b = 35

local janim = 0.5
local janimhealth = 100
local janimarmor = 100

function drawBackground()
    local c = MUI.Get()
    local armor = LocalPlayer():Armor()
    local player = LocalPlayer()
    local wep = player:GetActiveWeapon()

    if wep:IsValid() then
        if wep:GetMaxClip1() > 0 then
            draw.RoundedBox(8, w - 155, h - 70, 140, 55, c.main)
        end
    end
    
    if armor >1 then
        draw.RoundedBox(8, 15, h - 70, 575, 55, c.main)
    else
        draw.RoundedBox(8, 15, h - 70, 300, 55, c.main)
    end
    
end

function drawHealth()
    local c = MUI.Get()
    local health = LocalPlayer():Health()
    local jhealth = math.Clamp(health, 0, 100)
    local hudtext = MUI.GetTextColor()

    if health >9 then
        draw.RoundedBox(6, x, h - 48, 200, 10, HealthBG)
        draw.RoundedBox(6, x, h - 48, janimhealth * 2, 10, Health)
    else
        draw.RoundedBox(6, y, h - 48, 200, 10, HealthBG)
        draw.RoundedBox(6, y, h - 48, janimhealth * 2, 10, Health)
    end

    if health == 100 then
        draw.SimpleText(health, "muiHUD", a, h - 64, hudtext, TEXT_ALIGN_LEFT)
    else
        draw.SimpleText(health, "muiHUD", b, h - 64, hudtext, TEXT_ALIGN_LEFT)
    end

    local player = LocalPlayer()
    local wep = player:GetActiveWeapon() 
	if wep:IsValid() then
		if wep:GetMaxClip1() > 0 then
						
            draw.SimpleText(wep:Clip1() .. " / " .. player:GetAmmoCount(wep:GetPrimaryAmmoType()), "muiHUD", w - 30, h - 65, hudtext, TEXT_ALIGN_RIGHT )
		end
	end
end

function drawArmor()
    local armor = LocalPlayer():Armor()
    local jarmor = math.Clamp(armor, 0, 100)
    local hudtext = MUI.GetTextColor()

    if armor >9 then
        draw.RoundedBox(6, x * 4.15, h - 48, 200, 10, ArmorBG)
        draw.RoundedBox(6, x * 4.15, h - 48, janimarmor * 2, 10, Armor)
    else
        draw.RoundedBox(6, y * 5, h - 48, 200, 10, ArmorBG)
        draw.RoundedBox(6, y * 5, h - 48, janimarmor * 2, 10, Armor)
    end

    if armor == 100 then
        draw.SimpleText(armor, "muiHUD", a * 12.5, h - 64, hudtext, TEXT_ALIGN_LEFT)
    else
        draw.SimpleText(armor, "muiHUD", b * 9, h - 64, hudtext, TEXT_ALIGN_LEFT)
    end
end

function hud()    
        
    local health = LocalPlayer():Health()
    local jhealth = math.Clamp(health, 0, 100)
    local armor = LocalPlayer():Armor()
    local jarmor = math.Clamp(armor, 0, 100)
    
    if MUI.hudbg:GetBool() and health >0 then
        drawBackground()
    else end

    if health >0 then
    drawHealth()
    else end

    if armor >0 then
    drawArmor()
    else end

    if health == 2 then
        deahtnotice()
    end

    if LocalPlayer():Health() > janimhealth and janimhealth < 100 then 
        janimhealth = janimhealth + janim
    elseif LocalPlayer():Health() < janimhealth and janimhealth > 0 then 
            janimhealth = janimhealth - janim
    end

    if LocalPlayer():Armor() > janimarmor and janimarmor < 100 then 
        janimarmor = janimarmor + janim
    elseif LocalPlayer():Armor() < janimarmor and janimarmor > 0 then 
            janimarmor = janimarmor - janim
    end

end
hook.Add("HUDPaint", "muiHUD", hud)
