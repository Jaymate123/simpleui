-----------------------------------
-- ModernUI -- By Jaymate :) ------
-----------------------------------

local fpsenhance = false
local fpsenhanceConvar = CreateClientConVar("fpsenhance", 0, true)

AntiLagHelper = AntiLagHelper or {}

local function fpsenhanceenable()
	for command, value in pairs({
		gmod_mcore_test = 1,
		mat_queue_mode = -1,
		cl_threaded_bone_setup = 1,
		cl_threaded_client_leaf_system = 1,
		r_threaded_client_shadow_manager = 1,
		r_threaded_particles = 1,
		r_threaded_renderables = 1,
		r_queued_ropes = 1,
		cl_show_splashes = 1,
		mat_disable_fancy_blending = 1,
		mat_disable_lightwarp = 1,
		r_lod = 0,
		r_occlusion = 0,
		lod_TransitionDist = 400,
		r_lightaverage = 0,
		mat_compressedtextures = 1,
		cl_forcepreload = 1,
		mat_specular = 0,
		r_WaterDrawReflection = 0,
		r_rootlod = 0,
		r_flex = 0,
		fps_max = 250,
		r_drawmodeldecals = 0,
		r_dynamic = 0
	}) do 
		RunConsoleCommand(command, value)
	end

	AntiLagHelper.Hooks = {}
	
	for name, id in pairs({
		RenderScreenspaceEffects = "RenderColorModify",
		RenderScreenspaceEffects = "RenderBloom",
		RenderScreenspaceEffects = "RenderToyTown",
		RenderScreenspaceEffects = "RenderTexturize",
		RenderScreenspaceEffects = "RenderSunbeams",
		RenderScreenspaceEffects = "RenderSobel",
		RenderScreenspaceEffects = "RenderSharpen",
		RenderScreenspaceEffects = "RenderMaterialOverlay",
		RenderScreenspaceEffects = "RenderMotionBlur",
		RenderScene = "RenderStereoscopy",
		RenderScene = "RenderSuperDoF",
		GUIMousePressed = "SuperDOFMouseDown",
		GUIMouseReleased = "SuperDOFMouseUp",
		PreventScreenClicks = "SuperDOFPreventClicks",
		PostRender = "RenderFrameBlend",
		PreRender = "PreRenderFrameBlend",
		Think = "DOFThink",
		RenderScreenspaceEffects = "RenderBokeh",
		NeedsDepthPass = "NeedsDepthPass_Bokeh",
		PostDrawEffects = "RenderWidgets",
		PostDrawEffects = "RenderHalos",
	}) do 
		AntiLagHelper.Hooks[name] = id 
		hook.Remove(name, id)
	end
end

local function fpsenhancedisable()
	for command, value in pairs({
		gmod_mcore_test = 0,
		mat_queue_mode = 0,
		cl_threaded_bone_setup = 0,
		cl_threaded_client_leaf_system = 0,
		r_threaded_client_shadow_manager = 0,
		r_threaded_particles = 0,
		r_threaded_renderables = 0,
		r_queued_ropes = 0,
		cl_show_splashes = 0,
		mat_disable_fancy_blending = 0,
		mat_disable_lightwarp = 0,
		r_lod = -1,
		r_occlusion = 1,
		lod_TransitionDist = 800,
		r_lightaverage = 1,
		mat_compressedtextures = 0,
		cl_forcepreload = 0,
		mat_specular = 1,
		r_WaterDrawReflection = 1,
		r_rootlod = 0,
		r_flex = 1,
		fps_max = 0,
		r_drawmodeldecals = 1,
		r_dynamic = 1
	}) do 
		RunConsoleCommand(command, value)
	end
	
	for name, id in pairs(AntiLagHelper.Hooks) do
		hook.Add(name, id)
	end
end

local function runWhenValid()
	timer.Simple(1, function()
		print("Thank you so much for using my addon, ModernUI!")
		print("- Jaymate")
		c = MUI.Get()
		chat.AddText(c.main, "[ModernUI] Go to: Spawnmenu (Q) > Options (Top right) to adjust settings.")
		
		if fpsenhanceConvar:GetInt() >= 1 then
			fpsenhanceenable()
			fpsenhance = true
		end
	end)
end

hook.Add("OnEntityCreated","WidgetInit",function(ent)
	if ent:IsWidget() then
		hook.Add( "PlayerTick", "TickWidgets", function( pl, mv ) widgets.PlayerTick( pl, mv ) end ) 
		hook.Remove("OnEntityCreated","WidgetInit")
	end
end)

local function loopUntilValid()
	if !IsValid(LocalPlayer()) then
		timer.Simple(1, loopUntilValid)
	else
		runWhenValid()
	end
end
loopUntilValid()

cvars.RemoveChangeCallback("fpsenhance", "fpsenchance_callback")
cvars.AddChangeCallback("fpsenhance", function(cname, old, new)
	print(new == "1.00")
	print(type(new))
	print(new)
	if new == "1.00" then 
        fpsenhanceenable()
    else 
        fpsenhancedisable()
    end
end, "fpsenchance_callback")