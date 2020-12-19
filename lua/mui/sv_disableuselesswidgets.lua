-- This is by Mohamed RACHID, check him out here!!
-- https://steamcommunity.com/profiles/76561198080131369

hook.Add( "PreGamemodeLoaded", "modernui", function()
	MsgN( "Disabling widgets..." )
	function widgets.PlayerTick()

	end
	hook.Remove( "PlayerTick", "TickWidgets" )
	MsgN( "Widgets disabled!" )
end )