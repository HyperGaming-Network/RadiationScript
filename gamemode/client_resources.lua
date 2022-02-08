-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- client_resources.lua
-------------------------------
function AddResource( res_type, path )

	if( string.lower( res_type ) == "lua" ) then
	
		AddCSLuaFile( path );
		
	end
	
end

AddResource( "lua", "cl_skin.lua" );
AddResource( "lua", "vgui_blackscene.lua" ); 
AddResource( "lua", "shared.lua" );
AddResource( "lua", "cl_binds.lua" ); 
AddResource( "lua", "cl_charactercreate.lua" );
AddResource( "lua", "sh_animations.lua" );
AddResource( "lua", "cl_hud.lua");
AddResource( "lua", "cl_init.lua");
AddResource( "lua", "cl_search.lua");
AddResource( "lua", "cl_view.lua");
AddResource( "lua", "cl_bleed.lua");
AddResource( "lua", "cl_playermenu.lua");
AddResource( "lua", "player_shared.lua");
AddResource( "lua", "resource.lua");
AddResource( "lua", "VGUI/hpanel.lua" );
AddResource( "lua", "VGUI/apanel.lua" ); 
AddResource( "lua", "VGUI/ipanel.lua" );  
