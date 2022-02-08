PLUGIN.Name = "Tool Trust"; -- What is the plugin name
PLUGIN.Author = "Looter"; -- Author of the plugin
PLUGIN.Description = "Toolgun permissions, as well as physgun ban."; -- The description or purpose of the plugin

function Tooltrust_Give(ply)
ply:GetTable().ForceGive = true;
	if(tostring(RAD.GetPlayerField(ply, "tooltrust")) == "1") then
	
		ply:Give("gmod_tool");
		
	end
	
	if(tostring(RAD.GetPlayerField(ply, "phystrust")) == "1") then
	
		ply:Give("weapon_physgun");
		
	end
	
	if(tostring(RAD.GetPlayerField(ply, "gravtrust")) == "1") then
	
		ply:Give("weapon_physcannon");
		
	end
ply:GetTable().ForceGive = false;
end

function Admin_Tooltrust(ply, cmd, args)

	if(#args != 2) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rp_admin tooltrust \"name\" 1/0 )" );
		return;

	end
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	if(args[2] == "1") then
	target:GetTable().ForceGive = true;
		RAD.SetPlayerField(target, "tooltrust", 1);
		target:Give("gmod_tool");
		RAD.SendChat( target, "You have been given tooltrust by " .. ply:Name() );
		RAD.SendChat( ply, target:Name() .. " has been given tooltrust" );
	target:GetTable().ForceGive = false;
	elseif(args[2] == "0") then
	target:GetTable().ForceGive = true;
		RAD.SetPlayerField(target, "tooltrust", 0);
		target:StripWeapon("gmod_tool");
		RAD.SendChat( target, "Your tooltrust has been removed by " .. ply:Name() );
		RAD.SendChat( ply, target:Name() .. "'s tooltrust has been removed" );
	target:GetTable().ForceGive = false;
	end

end

function Admin_Phystrust(ply, cmd, args)

	if(#args != 2) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rp_admin phystrust \"name\" 1/0 )" );
		return;

	end
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	if(args[2] == "0") then
	target:GetTable().ForceGive = true;
		RAD.SetPlayerField(target, "phystrust", 0);
		target:StripWeapon("weapon_physgun");
		RAD.SendChat( target, "You have been banned from the physics gun by " .. ply:Name());
		RAD.SendChat( ply, target:Name() .. " has been banned from the physics gun" );
	target:GetTable().ForceGive = false;
	elseif(args[2] == "1") then
	target:GetTable().ForceGive = true;
		RAD.SetPlayerField(target, "phystrust", 1);
		target:Give("weapon_physgun");
		RAD.SendChat( target, "You have been given the physgun by " .. ply:Name() );
		RAD.SendChat( ply, target:Name() .. " has been given a physgun" );
	target:GetTable().ForceGive = false;
	end
	
end

function Admin_Gravtrust(ply, cmd, args)

	if(#args != 2) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rp_admin gravtrust \"name\" 1/0 )" );
		return;

	end
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	if(args[2] == "0") then
	
		RAD.SetPlayerField(target, "gravtrust", 0);
		target:StripWeapon("weapon_physcannon");
		RAD.SendChat( target, "You have been banned from the gravity gun by " .. ply:Name());
		RAD.SendChat( ply, target:Name() .. " has been banned from the gravity gun" );
		
	elseif(args[2] == "1") then
	
		RAD.SetPlayerField(target, "gravtrust", 1);
		target:Give("weapon_physcannon");
		RAD.SendChat( target, "You have been given the gravgun by " .. ply:Name() );
		RAD.SendChat( ply, target:Name() .. " has been given a gravgun" );
		
	end
	
end

function PLUGIN.Init()

	RAD.ConVars[ "Default_Tooltrust" ] = "0"; -- Are players allowed to have the toolgun when they first start.
	RAD.ConVars[ "Default_Gravtrust" ] = "1"; -- Are players allowed to have the gravgun when they first start.
	RAD.ConVars[ "Default_Phystrust" ] = "0"; -- Are players allowed to have the physgun when they first start.
	
	RAD.AddDataField( 1, "tooltrust", RAD.ConVars[ "Default_Tooltrust" ] ); -- Is the player allowed to have the toolgun
	RAD.AddDataField( 1, "gravtrust", RAD.ConVars[ "Default_Gravtrust" ] ); -- Is the player allowed to have the gravity gun
	RAD.AddDataField( 1, "phystrust", RAD.ConVars[ "Default_Phystrust" ] ); -- Is the player allowed to have the physics gun
	RAD.AddDataField( 1, "proptrust", RAD.ConVars[ "Default_Proptrust" ] ); -- Is the player allowed to spawn props
	
	RAD.AddHook("PlayerSpawn", "tooltrust_give", Tooltrust_Give);
	
	RAD.AdminCommand( "tooltrust", Admin_Tooltrust, "Change someones tooltrust", true, true, false );
	RAD.AdminCommand( "gravtrust", Admin_Gravtrust, "Change someones gravtrust", true, true, false );
	RAD.AdminCommand( "phystrust", Admin_Phystrust, "Change someones phystrust", true, true, false );
	
end
