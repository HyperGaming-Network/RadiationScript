-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- charactercreate.lua
-- Contains the character creation concommands.
-------------------------------	
function ccSetModel( ply, cmd, args )

	local mdl = ply:GetNWString("ChosenModel");
	
	if( ply:GetNWInt( "charactercreate" ) == 1 ) then
			
			RAD.CallHook( "CharacterCreation_SetModel", ply, mdl );
			RAD.SetCharField(ply, "model", mdl );

	end
	
	return;
end
concommand.Add( "rp_setmodel", ccSetModel );

-- Start Creation
function ccStartCreate( ply, cmd, args )
	
	local PlyCharTable = RAD.PlayerData[ RAD.FormatSteamID( ply:SteamID() ) ][ "characters" ]
	
	-- Find the highest Unique ID
	local high = 0;
	
	for k, v in pairs( PlyCharTable ) do
	
		k = tonumber( k );
		high = tonumber( high );
		
		if( k > high ) then 
		
			high = k;
			
		end
		
	end
	

		high = high + 1
	ply:SetNWString( "uid", tostring(high) );
	
	ply:SetNWInt( "charactercreate", 1 );
	RAD.PlayerData[ RAD.FormatSteamID( ply:SteamID() ) ][ "characters" ][ tostring(high) ] = {  }
	RAD.CallHook( "CharacterCreation_Start", ply );
	
end
concommand.Add( "rp_startcreate", ccStartCreate );

-- Finish Creation
function ccFinishCreate( ply, cmd, args )

	if( ply:GetNWInt( "charactercreate" ) == 1 ) then
		
		ply:SetNWInt( "charactercreate", 0 )
		ply:SetModel( "models/srpmodels/loner1.mdl" );
		local SteamID = RAD.FormatSteamID( ply:SteamID() );
		
		for fieldname, default in pairs( RAD.CharacterDataFields ) do
		
			if( RAD.PlayerData[ SteamID ][ "characters" ][ ply:GetNWString( "uid" ) ][ fieldname ] == nil) then

				RAD.PlayerData[ SteamID ][ "characters" ][ ply:GetNWString( "uid" ) ][ fieldname ] = RAD.ReferenceFix(default);
		
			end
			
		end
		
		RAD.ResendCharData( ply );
		ply:RefreshInventory( )
		ply:RefreshBusiness( )
		
		ply:SetTeam( 1 );
		
		ply:Spawn( );
				
		RAD.CallHook( "CharacterCreation_Finished", ply, ply:GetNWString( "uid" ) );
		
	end
	
end
concommand.Add( "rp_finishcreate", ccFinishCreate );

function ccSelectChar( ply, cmd, args )

	local uid = args[ 1 ];
	local SteamID = RAD.FormatSteamID(ply:SteamID());
	
	if( RAD.PlayerData[ SteamID ][ "characters" ][ uid ] != nil ) then
	
		ply:SetNWString( "uid", uid );
		RAD.ResendCharData( ply );
		
		ply:SetNWInt( "charactercreate", 0 );
	
		ply:SetTeam( 1 );
		RAD.CallHook( "CharacterSelect_PostSetTeam", ply, RAD.PlayerData[ SteamID ][ "characters" ][ uid ] );
		
		ply:RefreshInventory( )
		ply:RefreshBusiness( )
		
		ply:Spawn( );
		
		RAD.CallHook( "CharacterSelected", ply, RAD.PlayerData[ SteamID ][ "characters" ][ uid ] );
		if( ply.PrimaryWeapon == nil ) then
		ply.PrimaryWeapon = ents.Create( "primaryweapon" );
		ply.PrimaryWeapon:SetNewInfo( ply )
		else
		ply.PrimaryWeapon:Remove()
		ply.PrimaryWeapon = ents.Create( "primaryweapon" );
		ply.PrimaryWeapon:SetNewInfo( ply )	
		end 
	else
		
		return;
		
	end

end
concommand.Add( "rp_selectchar", ccSelectChar );

function ccReady( ply, cmd, args )

	if( ply.Ready == false ) then

		ply.Ready = true;
	
		-- Find the highest Unique ID and set it - just in case they want to create a character.
		local high = 0;
		
		local PlyCharTable = RAD.PlayerData[ RAD.FormatSteamID( ply:SteamID() ) ]["characters"];
		
		for k, v in pairs( PlyCharTable ) do
		
			k = tonumber( k );
			high = tonumber( high );
			
			if( k > high ) then 
			
				high = k;
				
			end
			
		end
		
		high = high + 1;
		ply:SetNWString( "uid", tostring(high) );
		
		for k, v in pairs( PlyCharTable ) do -- Send them all their characters for selection

			umsg.Start( "ReceiveChar", ply );
				umsg.Long( tonumber(k) );
				umsg.String( v[ "name" ] );
				umsg.String( v[ "model" ] );
			umsg.End( );

		end
		
		ply:SetNWInt( "charactercreate", 1 )
		
		umsg.Start( "charactercreate", ply );
		umsg.End( );
		
		RAD.CallHook( "PlayerReady", ply );
		
	end
	
end
concommand.Add( "rp_ready", ccReady );