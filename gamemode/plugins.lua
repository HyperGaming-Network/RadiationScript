-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- plugins.lua
-- Loads and handles the plugins.
-------------------------------

function RAD.LoadData()

	local list = file.FindInLua( "RadiationScript/gamemode/plugins/*.lua" );

	for k, v in pairs( list ) do
	  
		RAD.LoadPlugin( v );
		
	end
	
	-- Load the items
	local list = file.FindInLua( "RadiationScript/gamemode/items/*.lua" );
	
	for k, v in pairs( list ) do

		RAD.LoadItem( v );
		
	end
	
end	

RAD.Plugins = {  };

function RAD.LoadPlugin( filename )
	
	RAD.CallHook( "LoadPlugin", filename );
	
	local path = "plugins/" .. filename;
	
	PLUGIN = {  };
	
	include( path );
	
	Msg( "Plugin " .. PLUGIN.Name .. " loaded.\n" )
	
	table.insert( RAD.Plugins, PLUGIN );
	
end

function RAD.ReRoute( )

	for k, v in pairs( RAD ) do
	
		if( type( v ) == "function" ) then
		
			GM[ k ] = RAD[ k ];
			
		end
		
	end
	
end

function RAD.InitPlugins( )

	for _, PLUGIN in pairs( RAD.Plugins ) do
		
		RAD.CallHook( "InitPlugin", _, PLUGIN );
		--RAD.DayLog("script.txt", "Initializing " .. PLUGIN.Name);
		
		if(PLUGIN.Init) then
			PLUGIN.Init( );
		end
		
	end
	
end
