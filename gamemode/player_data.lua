-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- player_data.lua
-- Handles player data and such.
-------------------------------
require("glon")

-- Define the table of player information.
RAD.PlayerData = {  };

-- This is to be used only by the main player table.
RAD.PlayerDataFields = {  };

-- This is to be used only by the characters table.
RAD.CharacterDataFields = {  };

local meta = FindMetaTable( "Player" );

function RAD.FormatCharString( ply )
	
	return ply:SteamID() .. "-" .. ply:GetNWString( "uid" );
	
end

-- This formats a player's SteamID for things such as data file names
-- For example, STEAM_0:1:5947214 would turn into 015947214
function RAD.FormatSteamID( SteamID )

	local SteamID = RAD.NilFix(SteamID, "STEAM_0:0:0");

	s = string.gsub( SteamID,"STEAM","" );
	s = string.gsub( s,":","" );
	s = string.gsub( s,"_","" );
	
	return s;
	
end

-- When fieldtype is 1, it adds it to the player table.
-- When it is 2, it adds it to the character table.
function RAD.AddDataField( fieldtype, fieldname, default )
   
	if( fieldtype == 1 ) then
	
		--RAD.DayLog( "script.txt", "Adding player data field " .. fieldname .. " with default value of " .. tostring( default ) );
		RAD.PlayerDataFields[ fieldname ] = RAD.ReferenceFix(default);
	
	elseif( fieldtype == 2 ) then
	
		--RAD.DayLog( "script.txt", "Adding character data field " .. fieldname .. " with default value of " .. tostring( default ) );
		RAD.CharacterDataFields[ fieldname ] = RAD.ReferenceFix(default);
		
	end
	
end

-- Load a player's data
function RAD.LoadPlayerDataFile( ply )

	local SteamID = RAD.FormatSteamID( ply:SteamID() );
	
	RAD.PlayerData[ SteamID ]  = {  };
	
	if( file.Exists( "RadiationScript/PlayerData/" .. SteamID .. ".txt" ) ) then
	
		RAD.CallHook( "LoadPlayerDataFile", ply );
		
		RAD.DayLog( "script.txt", "Loading player data file for " .. ply:SteamID( ) );
		
		-- Read the data from their data file
		local Data_Raw = file.Read( "RadiationScript/PlayerData/" .. SteamID .. ".txt" );
		
		-- Convert the data into a table
		local Data_Table = RAD.NilFix( glon.decode(Data_Raw), { });
		
		-- Insert the table into the data table
		RAD.PlayerData[ SteamID ] = Data_Table;
		
		-- Retrieve the data table for easier access
		local PlayerTable = RAD.PlayerData[ SteamID ];
		local CharTable = RAD.PlayerData[ SteamID ][ "characters" ];

		-- If any values were loaded and they aren't in the DataFields table, delete them from the player.
		for _, v in pairs( PlayerTable ) do
			
			if( RAD.PlayerDataFields[ _ ] == nil ) then
			
				RAD.DayLog( "script.txt", "Invalid player data field '" .. tostring( _ ) .. "' in " .. ply:SteamID( ) .. ", removing." );
				RAD.PlayerData[ SteamID ][ _ ] = nil;
				
			end
			
		end
		
		-- If any fields were not loaded and they are in the DataFields table, add them.
		for fieldname, default in pairs( RAD.PlayerDataFields ) do
			
			if( PlayerTable[ fieldname ] == nil ) then
			
				--RAD.DayLog( "script.txt", "Missing player data field '" .. tostring( fieldname ) .. "' in " .. ply:SteamID( ) .. ", inserting with default value of '" .. tostring(default) .. "'" );
				RAD.PlayerData[ SteamID ][ fieldname ] = RAD.ReferenceFix(default);
				
			end
			
		end
		
		-- If any values were loaded and they aren't in the DataFields table, delete them from the character.
		for _, char in pairs( CharTable ) do
		
			for k, v in pairs( char ) do 
			
				if( RAD.CharacterDataFields[ k ] == nil ) then
				
					--RAD.DayLog( "script.txt", "Invalid character data field '" .. tostring( _ ) .. "' in character " .. ply:SteamID( ) .. "-" .. _ .. ", removing." );
					RAD.PlayerData[ SteamID ][ "characters" ][ _ ][ k ] = nil;
					
				end
				
			end
			
		end
		
		-- If any fields were not loaded and they are in the DataFields table, add them.
		for _, char in pairs( CharTable ) do
			
			for fieldname, default in pairs( RAD.CharacterDataFields ) do
			
				if( char[ fieldname ] == nil ) then
				
				    RAD.DayLog( "script.txt", "Missing character data field '" .. tostring( fieldname ) .. "' in character " .. ply:SteamID( ) .. "-" .. _ .. ", inserting with default value of '" .. tostring(default) .. "'" );
					RAD.PlayerData[ SteamID ][ "characters" ][ _ ][ fieldname ] = RAD.ReferenceFix(default);
					
				end
				
			end
			
		end
		
		RAD.SavePlayerData(ply);
		
			
		RAD.CallHook( "LoadedPlayerDataFile", ply, Data_Table );
		
	else
		
		-- Seems they don't have a player table. Let's create a default one for them.
		
		RAD.DayLog( "script.txt", "Creating new data file for " .. ply:SteamID( ) );
		
		RAD.PlayerData[ SteamID ] = {  };
		
		-- Let's get the default fields and add them to the table.
		for fieldname, default in pairs( RAD.PlayerDataFields ) do
			
			if( RAD.PlayerData[ fieldname ] == nil ) then
			
				RAD.PlayerData[ SteamID ][ fieldname ] = RAD.ReferenceFix(default);
				
			end
			
		end
		ply:PrintMessage( 2, "created a player data file" ) 
		
		-- We won't make a character, obviously. That is done later.
		
		RAD.SavePlayerData(ply);
		
		-- Technically, we didn't load it, but the data is now there.
		RAD.CallHook( "LoadedPlayerDataFile", ply, Data_Table );
		
	end
	
end

function RAD.ResendCharData( ply ) -- Network all of the player's character data

	local SteamID = RAD.FormatSteamID( ply:SteamID() );
	
	if( RAD.PlayerData[ SteamID ][ "characters" ][ ply:GetNWString( "uid" ) ] == nil ) then
		return;
	end

	for fieldname, data in pairs( RAD.PlayerData[ SteamID ][ "characters" ][ ply:GetNWString( "uid" ) ] ) do
		
		if( type( data ) != "table" ) then
			
			ply:SetNWString( fieldname, tostring( data ) );
			
		end

	end
	
end

function RAD.SetPlayerField( ply, fieldname, data )

	local SteamID = RAD.FormatSteamID( ply:SteamID() );
	
	-- Check to see if this is a valid field
	if( RAD.PlayerDataFields[ fieldname ] ) then
	
		
		RAD.PlayerData[ SteamID ][ fieldname ] = data;
		RAD.SavePlayerData(ply);
		
	else
	    RAD.DayLog( "dataerrors.txt", "(Player Data Save Error) Invalid field name " .. fieldname .. " for " .. SteamID );
		return "";
		
	end
	
end
	
function RAD.GetPlayerField( ply, fieldname )

	local SteamID = RAD.FormatSteamID( ply:SteamID() );

	-- Check to see if this is a valid field
	if( RAD.PlayerDataFields[ fieldname ] ) then
		
		return RAD.NilFix(RAD.PlayerData[ SteamID ][ fieldname ], "");
		
	else
	
		return "";
		
	end
	
end

function RAD.GetCharField( ply, fieldname )

	local SteamID = RAD.NilFix( RAD.FormatSteamID( ply:SteamID() ), "11111111")

	if( RAD.CharacterDataFields[ fieldname ] ) then
	//if( ply ) then
	return RAD.NilFix(RAD.PlayerData[ SteamID ][ "characters" ][ ply:GetNWString( "uid" ) ][ fieldname ], "");
	//end
	else

	return "";

	end
	
end

function RAD.SetCharField( ply, fieldname, data )

	local SteamID = RAD.FormatSteamID( ply:SteamID() );

	if( !RAD.CharacterDataFields[ fieldname ] ) then RAD.DayLog( "dataerrors.txt", "(Char Data Save Error) Invalid field name " .. fieldname .. " for " .. SteamID .. " : " .. ply:Name());
		return "";	
	end
	
		RAD.PlayerData[ SteamID ][ "characters" ][ ply:GetNWString( "uid" ) ][ fieldname ] = data;
		RAD.SavePlayerData(ply) 


end
	
function RAD.SavePlayerData( ply )
    local SteamID = RAD.FormatSteamID( ply:SteamID() );
    RAD.DayLog( "script.txt", "Saved Data for " .. SteamID );
    local savestuff = glon.encode( RAD.PlayerData[ SteamID ] )
	file.Write( "RadiationScript/PlayerData/" .. SteamID .. ".txt" , savestuff);
	
end

Msg( "Gamemode file; player_data.lua loaded\n" )


function DelPlayerData( ply, cmd, args )

	local count = table.Count(RAD.PlayerData[RAD.FormatSteamID( ply:SteamID())]["characters"])
	if( count <= 2 ) then RAD.SendChat( ply, "You have to have more than two characters!" ); return; end
 
	 	 table.Merge( RAD.PlayerData[RAD.FormatSteamID( ply:SteamID())]["characters"][args[1]] , RAD.PlayerData[RAD.FormatSteamID( ply:SteamID())]["characters"][tostring(count)] )

	RAD.PlayerData[RAD.FormatSteamID( ply:SteamID())]["characters"][tostring(count)] = nil
	RAD.SavePlayerData( ply )
		umsg.Start( "RemoveChar", ply );
			umsg.Long( args[1]);
		umsg.End( );

		

end
concommand.Add( "dev_DelCharNum", DelPlayerData ) 