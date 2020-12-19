-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------
include( "mui/cl_init.lua" )

local ScreenPos = ScrH() - 400

local Notifications = {}

local function DrawNotification( x, y, w, h, text, col, progress )
	local c = MUI.Get()
	draw.RoundedBoxEx( 8, x, y, w, h, c.main, true, true, true, true )
	draw.SimpleText( text, "muiWeapon", x + 10, y + h / 2, c.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
end

function notification.AddLegacy( text, type, time )
	surface.SetFont( "muiWeapon" )

	local w = surface.GetTextSize( text ) + 20
	local h = 32
	local x = ScrW()
	local y = ScreenPos

	table.insert( Notifications, 1, {
		x = x,
		y = y,
		w = w,
		h = h,

		text = text,
		time = CurTime() + time,

	} )
end

function notification.Kill( id )
	for k, v in ipairs( Notifications ) do
		if v.id == id then v.time = 0 end
	end
end

hook.Add( "HUDPaint", "DrawNotifications", function()
	for k, v in ipairs( Notifications ) do
		DrawNotification( math.floor( v.x ), math.floor( v.y ), v.w, v.h, v.text, v.col, v.progress )

		v.x = Lerp( FrameTime() * 10, v.x, v.time > CurTime() and ScrW() - v.w - 10 or ScrW() + 1 )
		v.y = Lerp( FrameTime() * 10, v.y, ScreenPos - ( k - 1 ) * ( v.h + 5 ) )
	end

	for k, v in ipairs( Notifications ) do
		if v.x >= ScrW() and v.time < CurTime() then
			table.remove( Notifications, k )
		end
	end
end )