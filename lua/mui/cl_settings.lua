-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------

hook.Add( "AddToolMenuCategories", "CustomCategory", function()
	spawnmenu.AddToolCategory( "Options", "ModernUI", "#ModernUI" )
end )

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "ModernUI", "Custom_Menu", "#Settings", "", "", function( panel )
		panel:ClearControls()
        panel:Help( "So, which side will you take?" )
        panel:Button( "Light Mode", "mui_darkify", 0 )
        panel:Button( "Dark Mode", "mui_darkify", 1 )
        -- panel:Help( "Do you want MORE FPS!??!?!" )
        -- panel:Button( "Disable FPS Enhance", "fpsenhance", 0 )
        -- panel:Button( "Enable FPS Enhance", "fpsenhance", 1 )
	end )
end )