PLUGIN.Name = "Admin Commands";
PLUGIN.Author = "SilverKnight";
PLUGIN.Description = "A set of default admin commands";

function Admin_AddDoor(ply, cmd, args)
	
	local tr = ply:GetEyeTrace()
	local trent = tr.Entity;
	
	if(!RAD.IsDoor(trent)) then ply:PrintMessage(3, "You must be looking at a door!"); return; end

	if(table.getn(args) < 1) then ply:PrintMessage(3, "Specify a doorgroup!"); return; end
	
	local pos = trent:GetPos()
	local Door = {}
	Door["x"] = math.ceil(pos.x);
	Door["y"] = math.ceil(pos.y);
	Door["z"] = math.ceil(pos.z);
	Door["group"] = args[1];
	
	table.insert(RAD.Doors, Door);
	
	RAD.SendChat(ply, "Door added");
	
	local keys = util.TableToKeyValues(RAD.Doors);
	file.Write("RadiationScript/MapData/" .. game.GetMap() .. ".txt", keys);
	
end

function Admin_Goto( ply, cmd, args )
if(!ply:IsAdmin()) then return false; end

local target = RAD.FindPlayer(args[1]);

if(target:Alive() and target:IsPlayer()) then
ply:SetPos(target:GetPos());
else
RAD.SendChat( ply, "Player is either dead or doesn't exist!" );
end

end
concommand.Add( "rp_goto", Admin_Goto )

function Admin_Bring( ply, cmd, args )
if(!ply:IsAdmin()) then return false; end

local target = RAD.FindPlayer(args[1]);

if(target:Alive() and target:IsPlayer()) then
target:SetPos(ply:GetPos());
RAD.SendChat( target, ply:GetName() .. " Brought you to him." );
else
RAD.SendChat( ply, "Player is either dead or doesn't exist!" );
end

end
concommand.Add( "rp_bring", Admin_Bring )

function Admin_LocalSound( ply, cmd, args )
if(!ply:IsAdmin()) then return false; end

util.PrecacheSound( args[1] );
ply:EmitSound( args[1] );

end

function Admin_GlobalSound( ply, cmd, args )
if(!ply:IsAdmin()) then return false; end

util.PrecacheSound( args[1] );

for k,v in pairs( player.GetAll() ) do

v:ConCommand("play ".. args[1] );

end
end

function Admin_SetModel( ply, cmd, args )

if(!ply:IsSuperAdmin()) then return false; end

local target = RAD.FindPlayer(args[1])

if(target:Alive() and target:IsPlayer()) then

target:SetModel( args[2] );
RAD.SetCharField(target, "model", args[2] );

else

RAD.SendChat( ply, "Player is either dead or doesn't exist!" );

end

end

function Admin_GiveMoney( ply, cmd, args )
if(!ply:IsSuperAdmin()) then return false; end
	if( #args != 2 ) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rpa givemoney \"name\" \"amount\" )" );
		return;
		
	end

	local amt = tonumber(args[2]);
	local target = RAD.FindPlayer(args[1]);
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end

    target:ChangeMoney( amt );
	RAD.SendChat( ply, "Gave ".. target:Name() .." ".. amt .." RU." );
	RAD.DayLog( "admincheck.txt", "Player: " .. ply:SteamID() .." ".. ply:Name() .. "Gave ".. target:Name() .." ".. amt .." RU.")

end

function Admin_Kick( ply, cmd, args )

	if( #args != 2 ) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rpa kick \"name\" \"reason\" )" );
		return;
		
	end
	
	local plyname = args[ 1 ];
	local reason = args[ 2 ];
	
	local pl = RAD.FindPlayer( plyname );
	
	if( pl:IsValid( ) and pl:IsPlayer( ) ) then
	
		local UniqueID = pl:UserID( );
		
		game.ConsoleCommand( "kickid " .. UniqueID .. " \"" .. reason .. "\"\n" );
		
		RAD.AnnounceAction( ply, "kicked " .. pl:Name( ) );
		
	else
	
		RAD.SendChat( ply, "Cannot find " .. plyname .. "!" );
		
	end
	
end


function Admin_Observe( ply, cmd, args )
	
	if( not ply:IsSuperAdmin() ) then return; end

	if( not ply:GetTable().Observe ) then
		ply:SetColor( 255, 255, 255, 0 )
		ply:GodEnable();
	//	ply:SetNoDraw( true );
		
		if( ply:GetActiveWeapon():IsValid() ) then
			ply:GetActiveWeapon():SetNoDraw( true );
		end
		
		ply:SetNotSolid( true );
		ply:SetMoveType( 8 );
		
		ply:GetTable().Observe = true;
		
	else

		ply:GodDisable();
	//	ply:SetNoDraw( false );
		ply:SetColor( 255, 255, 255, 255 )
		if( ply:GetActiveWeapon() ) then
			ply:GetActiveWeapon():SetNoDraw( false );
		end
		
		ply:SetNotSolid( false );
		ply:SetMoveType( 2 );
		
		ply:GetTable().Observe = false;
		
	end

end

function Admin_Ban( ply, cmd, args )

	if( #args != 3 ) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rpa ban \"name\" \"reason\" minutes )" );
		return;
		
	end
	
	local plyname = args[ 1 ];
	local reason = args[ 2 ];
	local mins = tonumber( args[ 3 ] );
	
	if(mins > RAD.ConVars[ "MaxBan" ]) then
	
		RAD.SendChat( ply, "Max minutes is " .. RAD.ConVars[ "MaxBan" ] .. " for regular ban. Use superban.");
		return;
	
	end
	
	local pl = RAD.FindPlayer( plyname );
	
	if( pl != nil and pl:IsValid( ) and pl:IsPlayer( ) ) then
	
		local UniqueID = pl:UserID( );
		
		-- This bans, then kicks, then writes their ID to the file.
		game.ConsoleCommand( "banid " .. mins .. " " .. UniqueID .. "\n" );
		game.ConsoleCommand( "kickid " .. UniqueID .. " \"Banned for " .. mins .. " mins ( " .. reason .. " )\"\n" );
		game.ConsoleCommand( "writeid\n" );
		
		RAD.AnnounceAction( ply, "banned " .. pl:Name( ) );
		
	else
		RAD.SendChat( ply, "Cannot find " .. plyname .. "!" );
		
	end
	
end

function Admin_SuperBan( ply, cmd, args )

	if( not ply:IsSuperAdmin() ) then return; end

	if( #args != 3 ) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rpa superban \"name\" \"reason\" minutes )" );
		return;
		
	end
	
	local plyname = args[ 1 ];
	local reason = args[ 2 ];
	local mins = tonumber( args[ 3 ] );
	
	local pl = RAD.FindPlayer( plyname );
	
	if( pl != nil and pl:IsValid( ) and pl:IsPlayer( ) ) then
	
		local UniqueID = pl:UserID( );
		
		game.ConsoleCommand( "banid " .. mins .. " " .. UniqueID .. "\n" );
		
		if( mins == 0 ) then
		
			game.ConsoleCommand( "kickid " .. UniqueID .. " \"Permanently banned ( " .. reason .. " )\"\n" );
			RAD.AnnounceAction( ply, "permabanned " .. pl:Name( ) );
	
		else
		
			game.ConsoleCommand( "kickid " .. UniqueID .. " \"Banned for " .. mins .. " mins ( " .. reason .. " )\"\n" );
			RAD.AnnounceAction( ply, "banned " .. pl:Name( ) );
			
		end
		
		game.ConsoleCommand( "writeid\n" );
		
	else
	
		RAD.SendChat( ply, "Cannot find " .. plyname .. "!" );
		
	end
	
end

function Admin_SetConVar( ply, cmd, args )

	if( not ply:IsSuperAdmin() ) then return; end

	if( #args != 2 ) then
	
		RAD.SendChat( ply, "Invalid number of arguments! ( rpa setvar \"varname\" \"value\" )" );
		return;
		
	end
	
	if( RAD.ConVars[ args[ 1 ] ] ) then
	
		local vartype = type( RAD.ConVars[ args [ 1 ] ] );
		
		if( vartype == "string" ) then
		
			RAD.ConVars[ args[ 1 ] ] = tostring(args[ 2 ]);
			
		elseif( vartype == "number" ) then
		
			RAD.ConVars[ args[ 1 ] ] = RAD.NilFix(tonumber(args[ 2 ]), 0); -- Don't set a fkn string for a number, dumbass! >:<
		
		elseif( vartype == "table" ) then
		
			RAD.SendChat( ply, args[ 1 ] .. " cannot be changed, it is a table." ); -- This is kind of like.. impossible.. kinda. (Or I'm just a lazy fuck)
			return;
			
		end
		
		RAD.SendChat( ply, args[ 1 ] .. " set to " .. args[ 2 ] );
		RAD.CallHook( "SetConVar", ply, args[ 1 ], args[ 2 ] );
		
	else
	
		RAD.SendChat( ply, args[ 1 ] .. " is not a valid convar! Use rpa listvars" );
		
	end
	
end

function Admin_ListVars( ply, cmd, args )

	RAD.SendChat( ply, "---List of RadiationScript 1.5 ConVars---" );
	
	for k, v in pairs( RAD.ConVars ) do
		
		RAD.SendChat( ply, k .. " - " .. tostring(v) );
		
	end
	
end

function Admin_SetFlags( ply, cmd, args)
	
	if( #args < 2 )then RAD.SendChat( ply, "Not enough arguments supplied!" ) return; end
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	table.remove(args, 1); -- Get rid of the name
	
	RAD.SetCharField(target, "flags", args); -- KLOL!
	target:ConCommand( "rp_permaflag ".. args[1] ); --:D
	
	RAD.SendChat( ply, target:Name() .. "'s flags were set to \"" .. table.concat(args, " ") .. "\"" );
	RAD.SendChat( target, "Your flags were set to \"" .. table.concat(args, " ") .. "\" by " .. ply:Name());
	
end

function Admin_Help( ply, cmd, args )

	RAD.SendConsole( ply, "---List of RadiationScript 1.5 Admin Commands---" );
	
	for cmdname, cmd in pairs( RAD.AdminCommands ) do
	
		local s = cmdname .. " \"" .. cmd.desc .. "\"";
		
		if(cmd.CanRunFromConsole) then
		
			s = s .. " console";

		else
		
			s = s .. " noconsole";
			
		end
		
		if(cmd.CanRunFromAdmin) then
		
			s = s .. " admin";
			
		end
		
		if(cmd.SuperOnly) then
		
			s = s .. " superonly";
			
		end
		
		RAD.SendConsole( ply, s );
		
	end
end

function Admin_SetHealth( ply, cmd, args)
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
		
	target:SetHealth( args[2] );
	target:ChangeMaxHealth( args[2] )
	
	RAD.SendChat( ply, target:Name() .. "'s health was set to " .. tonumber( args[2] ));
	RAD.SendChat( target, ply:Name() .. "set your health to " ..  tonumber( args[2] ) );
	
end


function Admin_SetArmor( ply, cmd, args)
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
		
	target:SetArmor( args[2] );
	target:ChangeMaxArmor( args[2] )
	
	RAD.SendChat( ply, target:Name() .. "'s armor was set to " .. tonumber( args[2] ));
	RAD.SendChat( target, ply:Name() .. "set your armor to " ..  tonumber( args[2] ) );
	
end

function Admin_GiveSwep( ply, cmd, args)
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
		
	target:Give( args[2] );
	
	RAD.SendChat( ply, target:Name() .. " was given a " .. args[2] );
	RAD.SendChat( target, ply:Name() .. " gave you a " ..  args[2]  );
	
end

function Admin_ToggleFreeze( ply, cmd, args)
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
	if( target:GetTable().Froze ) then
	target:GetTable().Froze = false
	target:Freeze( false );
	else
	target:GetTable().Froze = true
	target:Freeze( true );
	end
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
		
	RAD.SendChat( ply, target:Name() .. " has been toggled frozen." );
	RAD.SendChat( target, "You have been frozen by an admin.");
	
end

function Admin_StripWeapons( ply, cmd, args)
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
	
	local GoodWeapons = { "hands", "gmod_tool", "weapon_physgun", "weapon_physcannon" }
	local wep = ply:GetActiveWeapon()	
	
	  for k, v in pairs(target:GetWeapons()) do
	    for _, wep in pairs(GoodWeapons) do
		if v != wep then
		 target:StripWeapon( v )
        end
		end
      end 
	
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
		
	RAD.SendChat( ply, target:Name() .. " has his weapons stripped." );
	RAD.SendChat( target, "You have had your weapons stripped from you." );
end

function Admin_SetRunSpeed( ply, cmd, args)
		
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
	
	target:GetTable().RunSpeed = args[2]

	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end

	RAD.SendChat( ply, target:Name() .. "'s run speed was set to " .. args[2] );
	RAD.SendChat( target, ply:Name() .. " set your run speed to " ..  args[2]  );
	
end

function Admin_SetMaterial( ply, cmd, args)
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
	
	target:SetMaterial(args[2]) 
		-- klol
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	
	RAD.SendChat( ply, target:Name() .. "'s material was set to " .. args[2] );
	RAD.SendChat( target, ply:Name() .. " set your material to " ..  args[2]  );
	
end

function Admin_ForceHands( ply, cmd, args)
	
	if( not ply:IsAdmin() ) then return; end 
	
	local target = RAD.FindPlayer(args[1])
	
	if(target != nil and target:IsValid() and target:IsPlayer()) then
	target:SelectWeapon("hands")
	else
		RAD.SendChat( ply, "Target not found!" );
		return;
	end
	RAD.SendChat( ply, "Forced The Player To Use Hands" );
	RAD.SendChat( target, "You were forced to use your hand SWEP" );
	
end

function Admin_ResetMap(ply, cmd, args)
	if( not ply:IsSuperAdmin() ) then return; end
	    PrintMessage( HUD_PRINTCENTER, "(" .. ply:Name() .. ") Restarting The Map In 10 Seconds...!" )
	    timer.Simple(10, RunConsoleCommand, "changelevel", "srp_redemption_b1c_day")
end

function Admin_OpenDoor( ply, cmd, args)
	
	local entity = ply:GetEyeTrace().Entity;
	if(entity != nil and entity:IsValid( ) and RAD.IsDoor( entity ) ) then
	        entity:Fire( "unlock", "", 0 );
			entity:Fire( "toggle", "", 0 );
	end	
	RAD.SendChat( ply, "Unlocked the door.");
	
end

function Admin_ClearDecals( ply )
	
	for k,v in pairs( player.GetAll() ) do

		v:ConCommand( "r_cleardecals" );
		RAD.SendChat( v, "All Decals on the map have been cleared." );
	end
	
end

function ccSeeAll( ply, cmd, arg )

if( not ply:IsAdmin() ) then return; end
	
	umsg.Start( "SeeAll", ply ); umsg.End();
	RAD.SendChat( ply, "Watching The Zone's STALKERS" );
end

function ccDay( ply, cmd, arg )

if( not ply:IsAdmin() ) then return; end
	if not storm_active then
		SetGlobalString("weather","sunny")
	end
end

function ccNight( ply, cmd, arg )

if( not ply:IsAdmin() ) then return; end
	if not storm_active then
		SetGlobalString("weather","dark")
	end
end

function ccPromptStorm( ply, cmd, arg )

	if( not ply:IsAdmin() ) then return; end

	if not storm_active then
		RAD.SendChat( ply, "Promoted a storm" );
		BeginStorm();
	else 
		RAD.SendChat( ply, "A storm is already in progress!" );
	end
	
end

function ccForceStopStorm( ply, cmd, arg )

	if( not ply:IsAdmin() ) then return; end

	if( not storm_active ) then
		RAD.SendChat( ply, "There isn't a storm in progress!" );
	else 
		storm_active = false
	//	SetGlobalString("weather","sunny")
		RAD.SendChat( ply, "Storm has been stopped" );
	end
	
end

function ccTime( ply, cmd, arg )
	if( not ply:IsAdmin() ) then return; end
	DAYCYCLE.DayMinute = arg[1]
end

function ccRandomAnoms( ply, cmd, arg )
			for k,v in pairs( ents.FindByClass("anomaly_damage") ) do
			v:Remove()
			end

			for i=1,10 do
				SpawnRandomAnom( "anomaly_damage")
			end
end

function PLUGIN.Init( )
	RAD.ConVars[ "MaxBan" ] = 600;
	RAD.AdminCommand( "help", Admin_Help, "List of all admin commands", true, true, false );
	RAD.AdminCommand( "kick", Admin_Kick, "Kick someone on the server", true, true, false );
	RAD.AdminCommand( "ban", Admin_Ban, "Ban someone on the server", true, true, false );
	RAD.AdminCommand( "superban", Admin_SuperBan, "Ban someone on the server ( Permanent allowed )", true, true, true );
	RAD.AdminCommand( "setconvar", Admin_SetConVar, "Set a Convar", true, true, true );
	RAD.AdminCommand( "listvars", Admin_ListVars, "List convars", true, true, true );
	RAD.AdminCommand( "setflags", Admin_SetFlags, "Set a players flags", true, true, false );
	RAD.AdminCommand( "adddoor", Admin_AddDoor, "Add a door to a doorgroup", true, true, true );
	RAD.AdminCommand( "observe", Admin_Observe, "Observe mode.", false, true, false );
	RAD.AdminCommand( "givemoney", Admin_GiveMoney, "Give a player money.", true, true, true );
	RAD.AdminCommand( "setmodel", Admin_SetModel, "Set a players model.", true, true, true );
	RAD.AdminCommand( "gsound", Admin_GlobalSound, "Play a sound everyone can here.", true, true, true );
	RAD.AdminCommand( "lsound", Admin_LocalSound, "Emit a sound.", true, true, true );
	RAD.AdminCommand( "sethealth", Admin_SetHealth, "Set a players health", true, true, true );
	RAD.AdminCommand( "setarmor", Admin_SetArmor, "Set a players armor", true, true, true )
    RAD.AdminCommand( "giveswep", Admin_GiveSwep, "Give a player a swep", true, true, true )
    RAD.AdminCommand( "freezeplayer", ToggleFreeze, "Freeze a player", true, true, true )
    RAD.AdminCommand( "stripweapons", Admin_StripWeapons, "strip a players weapons.", true, true, true )
	RAD.AdminCommand( "runspeed", Admin_SetRunSpeed, "Set a players run speed.", true, true, true )
    RAD.AdminCommand( "setmaterial", Admin_SetMaterial, "Set a players material texture.", true, true, true )
	RAD.AdminCommand( "unlockdoor", Admin_OpenDoor, "Unlock the door infront of you.", true, true, true )
	RAD.AdminCommand( "forcehands", Admin_ForceHands, "Force hands on a player", true, true, true )
	RAD.AdminCommand( "cleardecals", Admin_ClearDecals, "Removes All Decals on the map.", true, true, true )
	RAD.AdminCommand( "resetmap", Admin_ResetMap, "Reset The Map.", true, true, true );
    RAD.AdminCommand( "seeall", ccSeeAll, "See Players", true, true, false );	
	//RAD.AdminCommand( "w_day", ccDay, "Set the weather to day", true, true, true );	
	//RAD.AdminCommand( "w_night", ccNight, "Set the weather to night", true, true, true );	
	RAD.AdminCommand( "w_startstorm", ccPromptStorm, "Set the weather to day", true, true, true );	
	RAD.AdminCommand( "w_time", ccTime, "Set the time of day", true, true, true );	
	RAD.AdminCommand( "w_stopstorm", ccForceStopStorm, "Set the weather to night", true, true, true );		
	RAD.AdminCommand( "SpawnAnoms", ccRandomAnoms, "Spawn ten random Damage anomalies.", true, true, true );		
end
