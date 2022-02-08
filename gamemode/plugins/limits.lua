PLUGIN.Name = "Limits"; -- What is the plugin name
PLUGIN.Author = "Looter"; -- Author of the plugin
PLUGIN.Description = "Limit prop, ragdoll, and effect limits on a player by player basis. Useful for donators."; -- The description or purpose of the plugin

local SpawnTable = {};

function RAD.MaxProps(ply)

	return tonumber(RAD.ConVars[ "PropLimit" ]) + tonumber(RAD.GetPlayerField(ply, "extraprops"));
	
end

function RAD.MaxRagdolls(ply)

	return tonumber(RAD.ConVars[ "RagdollLimit" ]) + tonumber(RAD.GetPlayerField(ply, "extraragdolls"));
	
end

function RAD.MaxEffects(ply)

	return tonumber(RAD.ConVars[ "EffectLimit" ]) + tonumber(RAD.GetPlayerField(ply, "extraeffects"));
	
end

function RAD.CreateSpawnTable(ply)
	
	SpawnTable[RAD.FormatSteamID(ply:SteamID())] = {};
	
	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	spawntable.props = {};
	spawntable.ragdolls = {};
	spawntable.effects = {};

end

function GM:PlayerSpawnProp(ply, mdl)

    if( RAD.GetPlayerField(ply, "tooltrust" ) != 1 ) then  
	RAD.SendChat( ply, "[SERVER] Need tooltrust to spawn props, sorry :(." );
	ply:StripWeapon("gmod_tool"); -- How did they even get it.
	return false;
	end

	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	
	if(spawntable != nil) then
	
		local spawned = 0;
		
		for k, v in pairs(spawntable.props) do
		
			if(v != nil and v:IsValid()) then
			
				spawned = spawned + 1;		
			
			else
			
				spawntable.props[k] = nil; -- No longer exists. Wipe it out.
			
			end
			
		end
		
		if(spawned >= RAD.MaxProps(ply)) then
		
			RAD.SendChat(ply, "You have reached your limit! (" .. RAD.MaxProps(ply) .. ")");
			return false;
			
		else
		
			return true;
			
		end
		
	else

		RAD.CreateSpawnTable(ply)
		local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
		return true;
		
	end

end

function GM:PlayerSpawnedProp( ply, mdl, prop )
	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	table.insert(spawntable.props, ent);

if( table.HasValue( Containers, mdl ) ) then

prop.inventory = { };
if( mdl == "models/props_c17/FurnitureDresser001a.mdl" or mdl == "models/props_c17/FurnitureDrawer003a.mdl" ) then
prop:SetNWInt( "limit", 5 )
elseif( mdl == "models/Items/item_item_crate.mdl" or mdl == "models/props_wasteland/controlroom_filecabinet001a.mdl" or mdl == "models/props_c17/oildrum001.mdl" or mdl == "models/props_interiors/Furniture_Couch01a.mdl" or mdl == "models/props_interiors/Furniture_Couch02a.mdl" or mdl == "models/props_borealis/bluebarrel001.mdl" or mdl == "models/props_interiors/Furniture_Desk01a.mdl" ) then
prop:SetNWInt( "limit", 1 )
elseif( mdl == "models/props_c17/FurnitureDrawer002a.mdl" or mdl == "models/props_trainstation/trashcan_indoor001a.mdl" or mdl == "models/props_trainstation/trashcan_indoor001b.mdl" or mdl == "models/props_junk/wood_crate001a.mdl" or mdl == "models/props_junk/TrashBin01a.mdl" or mdl == "models/props_junk/wood_crate001a_damaged.mdl" or mdl == "models/props_wasteland/controlroom_filecabinet002a.mdl" ) then

prop:SetNWInt( "limit", 3 )

elseif( mdl == "models/props_wasteland/controlroom_storagecloset001b.mdl" or mdl == "models/props_junk/wood_crate002a.mdl" or mdl == "models/props_c17/Lockers001a.mdl" or mdl == "models/props_combine/breendesk.mdl" or mdl == "models/zavod_yantar/shkaf.mdl" ) then

prop:SetNWInt( "limit", 4 )

elseif( mdl == "models/props_wasteland/controlroom_storagecloset001a.mdl" or mdl == "models/Items/ammocrate_grenade.mdl" or mdl == "models/Items/ammocrate_ar2.mdl" or mdl == "models/Items/ammocrate_smg1.mdl" or mdl == "models/Items/ammoCrate_Rockets.mdl" ) then

prop:SetNWInt( "limit", 7 )

elseif( mdl == "models/props_junk/TrashDumpster01a.mdl" ) then

prop:SetNWInt( "limit", 15 )

end

prop:SetNWBool( "container", true ) 

end

for k,v in pairs( player.GetAll() ) do
	RAD.SendConsole(v, "\n"..ply:Nick().." Spawned ".. tostring(mdl) )
end

end

function GM:PlayerSpawnRagdoll(ply, mdl)

	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	
	if(spawntable != nil) then
	
		local spawned = 0;
		
		for k, v in pairs(spawntable.ragdolls) do
		
			if(v != nil and v:IsValid()) then  
			
				spawned = spawned + 1;
			
			else
			
				spawntable.ragdolls[k] = nil; -- No longer exists. Wipe it out.
			
			end
			
		end
		
		if(spawned >= RAD.MaxRagdolls(ply)) then
		
			RAD.SendChat(ply, "You have reached your limit! (" .. RAD.MaxRagdolls(ply) .. ")");
			return false;
			
		else
		
			return true;
			
		end
		
	else

		RAD.CreateSpawnTable(ply)
		local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
		return true;
		
	end
	
	for k,v in pairs( player.GetAll ) do
	v:PrintMessage( HUD_PRINTCONSOLE, "\n"..ply:Nick().." Spawned ".. tostring(mdl) )
	end
end

function GM:PlayerSpawnVehicle(ply)
     RAD.SendChat(ply, "There's No Working Vehicles In The Zone, Der!");
	 return false;

end

function GM:PlayerSpawnEffect(ply, mdl)

	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	
	if(spawntable != nil) then
	
		local spawned = 0;
		
		for k, v in pairs(spawntable.effects) do
		
			if(v != nil and v:IsValid()) then
			
				spawned = spawned + 1;
			
			else
			
				spawntable.effects[k] = nil; -- No longer exists. Wipe it out.
			
			end
			
		end
		
		if(spawned >= RAD.MaxEffects(ply)) then
		
			RAD.SendChat(ply, "You have reached your limit! (" .. RAD.MaxEffects(ply) .. ")");
			return false;
			
		else
		
			return true;
			
		end
		
	else

		RAD.CreateSpawnTable(ply)
		local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
		return true;
		
	end
	
end

function GM:PlayerSpawnedRagdoll(ply, mdl, ent)

	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	table.insert(spawntable.ragdolls, ent);
	
end

function GM:PlayerSpawnedEffect(ply, mdl, ent)

	local spawntable = SpawnTable[RAD.FormatSteamID(ply:SteamID())];
	table.insert(spawntable.effects, ent);
	
end

function Admin_ExtraProps(ply, cmd, args)

	if(#args != 2) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rp_admin extraprops \"name\" amount )" );
		return;

	end
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	RAD.SetPlayerField(target, "extraprops", tonumber(args[2]));
	RAD.SendChat( target, "Your extra props has been set to " .. args[2] .. " by " .. ply:Name());
	RAD.SendChat( ply, target:Name() .. "'s extra prop limit has been set to " .. args[2] );
	
end

function Admin_ExtraRagdolls(ply, cmd, args)

	if(#args != 2) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rp_admin extraragdolls \"name\" amount )" );
		return;

	end
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	RAD.SetPlayerField(target, "extraragdolls", tonumber(args[2]));
	RAD.SendChat( target, "Your extra ragdolls has been set to " .. args[2] .. " by " .. ply:Name());
	RAD.SendChat( ply, target:Name() .. "'s extra ragdolls  has been set to " .. args[2] );
	
end

function Admin_ExtraEffects(ply, cmd, args)

	if(#args != 2) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rp_admin extraprops \"name\" amount )" );
		return;

	end
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	RAD.SetPlayerField(target, "extraeffects", tonumber(args[2]));
	RAD.SendChat( target, "Your extra effects has been set to " .. args[2] .. " by " .. ply:Name());
	RAD.SendChat( ply, target:Name() .. "'s extra effects limit has been set to " .. args[2] );
	
end

function PLUGIN.Init()

	RAD.ConVars[ "Default_Extraprops" ] = 0;
	RAD.ConVars[ "Default_Extraragdolls" ] = 0;
	RAD.ConVars[ "Default_Extraeffects" ] = 0;
	
	RAD.ConVars[ "PropLimit" ] = 10;
	RAD.ConVars[ "RagdollLimit" ] = 0;
	RAD.ConVars[ "EffectLimit" ] = 0;
	
	RAD.AddDataField( 1, "extraprops", RAD.ConVars[ "Default_Extraprops" ] );
	RAD.AddDataField( 1, "extraragdolls", RAD.ConVars[ "Default_Extraragdolls" ] );
	RAD.AddDataField( 1, "extraeffects", RAD.ConVars[ "Default_Extraeffects" ] );
	
	RAD.AdminCommand( "extraprops", Admin_ExtraProps, "Change someones extra props limit", true, true, false );
	RAD.AdminCommand( "extraragdolls", Admin_ExtraRagdolls, "Change someones extra ragdolls limit", true, true, false );
	RAD.AdminCommand( "extraeffects", Admin_ExtraEffects, "Change someones extra effects limit", true, true, false );
	
end
