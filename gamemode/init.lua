-------------------------------
-- HyperGamer.Net Radiation Script
-- Author: Silver Knight
-------------------------------
DeriveGamemode( "sandbox" );

-- Define global variables
RAD = {};

-- Server Includes
include( "client_resources.lua" ); -- Sends files to the client
include( "shared.lua" ); -- Shared Functions
include( "log.lua" ); -- Logging functions
include( "error_handling.lua" ); -- Error handling functions
include( "hooks.lua" ); -- RadiationScript Hook System
include( "configuration.lua" ); -- Configuration data
include( "player_data.lua" ); -- Player data functions
include( "player_shared.lua" ); -- Shared player functions
include( "player_util.lua" ); -- Player functions
include( "admin.lua" ); -- Admin functions
include( "chat.lua" ); -- Chat Commands
include( "concmd.lua" ); -- Concommands
include( "util.lua" ); -- Functions
include( "charactercreate.lua" ); -- Character Creation functions
include( "items.lua" ); -- Items system
include( "plugins.lua" ); -- Plugin system
include( "teams.lua" ); -- Teams system
include( "sh_animations.lua" ); -- Animations
include( "doors.lua" ); -- Doors
include( "resource.lua" ) --Resource files - God damn it Lost. I said to back this up on your computer so that next time you update the script, I don't have to do this again. Almost friggin' deleted my copy of it.
include( "custom_spawnpoints.lua" ); -- Shared Functions
include( "parse.lua" ); -- Parse file
include( "sucker.lua" );

RAD.LoadData( )
RAD.LoadRADTeams( )
timer.Simple( 2, RAD.CreateThirdPersonCamera );
function GM:ForceDermaSkin()
    return "LS";
end 

function SpawnRandomAnom( entclass )
			local anompos1 = Vector( math.Rand(-14315,14315), math.Rand(-14315,14315), 1000 )
			local randnum = math.Rand(1, 6 )
			local tracedata = {}
			tracedata.start = anompos1
			tracedata.endpos = Vector( anompos1.x, anompos1.y, -1500 )
			tracedata.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_PLAYERCLIP
			local trace = util.TraceLine(tracedata)
			local anompos = trace.HitPos
			local ent1 = ents.Create( entclass ) 
				ent1:SetPos( anompos )
				ent1:Spawn()
				ent1:Activate()
			if  !( ent1:GetPos().z > -1500 ) then ent1:Remove() end
end


damagtable = {
"sparkler",
"sparkler",
"flash1",
"Urchin",
"Goldfish",
"Goldfish",
"Goldfish",
"Goldfish",
"gravi",
"gravi",
"gravi",
"mamasbeads",
"mamasbeads",
"Jellyfish",
"Jellyfish",
"dogtail",
"dogtail",
"dogtail",
"dogtail",
"Jellyfish",
"spring",
"nightstar",
"nightstar",
"nightstar",
"meatchunk",
"stoneblood",
"stoneblood",
"wretched",
"wretched",
"wretched",
"spring"
}

function funcRandomAnoms()
		timer.Adjust("spawnanoms", math.random(7200, 14400 ), 0, funcRandomAnoms )
		for k,v in pairs( ents.FindByClass("anomaly_damage") ) do
			v:Remove()
		end

			for i=1,10 do
				SpawnRandomAnom( "anomaly_damage")
			end
		 if( table.getn( player.GetAll()) > 10 ) then
		timer.Simple( 5, function() 
			local artnum = math.random( 1, table.getn( ents.FindByClass("anom*") ) )
			local artpos = ents.FindByClass("anom*")[artnum]:GetPos()
			RAD.CreateItem( table.Random( damagtable ) , Vector(artpos.x,artpos.y,artpos.z + 100 ), Angle( 0,0,0 ) )
			artpos1234 = Vector(artpos.x,artpos.y,artpos.z + 200 )
		end )		
  end
end
function GM:Initialize( ) 
	
	RAD.InitPlugins( );

	GAMEMODE.Name = "RadiationScript Beta 1.5a";

	RAD.LoadDoors();
	timer.Simple( 5, function() LoadMapItems(); end )
	timer.Simple( 10, function()
			for i=1,10 do
				SpawnRandomAnom( "anomaly_damage")
			end
	end)
	timer.Create( "PeriodicSave", 180, 0, function() SaveItems(); end )
	timer.Create( "spawnanoms",900, 0, funcRandomAnoms )

	timer.Create( "givemoney", RAD.ConVars[ "SalaryInterval" ] * 60, 0, function( )
	CreateConVar("npc_thinknow", "1")
		if( RAD.ConVars[ "SalaryEnabled" ] == "1" ) then
		
			for k, v in pairs( player.GetAll( ) ) do
			
				if( RAD.Teams[ v:Team( ) ] != nil ) then
				
					-- Prevents those 'Paycheck' messages from displaying to salaryless players ever again!
					if( RAD.Teams[ v:Team( ) ][ "salary" ] > 0 ) then
					
						v:ChangeMoney( RAD.Teams[ v:Team( ) ][ "salary" ] );
						RAD.SendChat( v, "Paycheck! " .. RAD.Teams[ v:Team( ) ][ "salary" ] .. " RU earned." );
					
					end
					
				end
				
			end 
			
		end

	end )

	RAD.CallHook("GamemodeInitialize");
	
end

require( "datastream" )
	
function GM:PlayerInitialSpawn( ply )
	
	RAD.CallHook( "Player_Preload", ply );
	ply.Ready = false;
	ply:SetNWInt( "chatopen", 0 );
	ply:SetNWInt( "tiedup", 0 );
	ply:ChangeMaxHealth(RAD.ConVars[ "DefaultHealth" ]);
	ply:ChangeMaxArmor(0);
	ply:ChangeMaxWalkSpeed(RAD.ConVars[ "WalkSpeed" ]);
	ply:ChangeMaxRunSpeed(RAD.ConVars[ "RunSpeed" ]);
    datastream.StreamToClients( ply, "IncomingPDA", PDAPlayers );
	ply:GetTable().ArtifactSlot = {}
	if( table.HasValue( SuperAdmins, ply:SteamID( ) ) ) then ply:SetUserGroup( "superadmin" ); end
	if( table.HasValue( Admins, ply:SteamID( ) ) ) then ply:SetUserGroup( "admin" ); end

	RAD.InitTeams( ply );
	
	RAD.LoadPlayerDataFile( ply );

	RAD.CallHook( "Player_Postload", ply );
	
	self.BaseClass:PlayerInitialSpawn( ply )

end

function GM:PlayerLoadout(ply)
ply:GetTable().ForceGive = true;
RAD.CallHook( "PlayerLoadout", ply );
	if(ply:GetNWInt("charactercreate") != 1) then
		
		if(RAD.Teams[ply:Team()] != nil) then
		
			for k, v in pairs(RAD.Teams[ply:Team()]["weapons"]) do

				ply:Give(v);

			end
			ply:SetArmor(RAD.Teams[ply:Team()]["armor"])
		end
		ply:Give("hands");
			ply:Give("weapon_physcannon");
	 
		local wepp = RAD.GetCharField(ply, "wepitem" )
		if (wepp !=nil) then
             ply:Give(wepp)
        end
		local wepp2 = RAD.GetCharField(ply, "wepitem2" )
		if (wepp !=nil) then
             ply:Give(wepp2)
	    end
		ply:SelectWeapon("hands");
	end
ply:GetTable().ForceGive = false;
		if( ply.PrimaryWeapon == nil ) then
		ply.PrimaryWeapon = ents.Create( "primaryweapon" );
		ply.PrimaryWeapon:SetNewInfo( ply )	
		else
		ply.PrimaryWeapon:SetNewInfo( ply )	
		end 
end
/*
concommand.Add("_kickmes", function( pl )  
         pl:Kick("ScriptEnforcer Bypass")  
     end )  
*/
function GM:PlayerSpawn( ply )
/*
		ply:SendLua( [[
         if GetConVar("sv_scriptenforcer"):GetInt() != 1 then  
             LocalPlayer():ConCommand("_kickmes")  
             LocalPlayer():ConCommand("disconnect") 
         end  
		]] )  */
	if(RAD.PlayerData[RAD.FormatSteamID(ply:SteamID())] == "?") then
		return;
	end
	ply:SetColor( 255, 255, 255, 255 )
	ply:GetTable().ArtifactSlotsFilled = 0	
	ply:GetTable().ArtifactSlots = 0	
	ply:StripWeapons( );
	ply:SetNWInt( "tiedup", 0 );
	ply:SetNWFloat( "PlScalew", 1 );
	ply:SetNWFloat( "PlScalez", 1 );
	ply:SetNWInt( "tiedup", 0 );
	ply:GetTable().HealthRecov = 2
	ply:GetTable().BleedAmt = 0
	ply:GetTable().BurnScale = 1
	ply:GetTable().AcidScale = 1
	ply:GetTable().PsiScale = 1
	ply:GetTable().DmgScale = 1
	ply:GetTable().ElectricScale = 1
	ply:GetTable().RadiationScale = 1
	if( RAD.GetCharField(ply, "suit") != " " ) then
	ply:GiveItem( RAD.GetCharField(ply, "suit") )
	ply:ConCommand( "rp_useinvitem " .. RAD.GetCharField(ply, "suit"))
	end
	if( ply:Team() == 23 or ply:Team() == 22 or ply:Team() == 21 or ply:Team() == 20 or ply:Team() == 19 ) then 

		ply:GetTable().ElectricScale = .1
	ply:GetTable().BurnScale = .1
	ply:GetTable().AcidScale = .1
	ply:GetTable().PsiScale = .1
	ply:GetTable().DmgScale = .1
	ply:GetTable().RadiationScale = 0
	end
	ply:GetTable().ArtifactSlotsFilled = 0 
	self.BaseClass:PlayerSpawn( ply )
	
	GAMEMODE:SetPlayerSpeed( ply, ply:GetTable().JogSpeed, ply:GetTable().RunSpeed );

	if( ply:GetNWInt( "deathmode" ) == 1 ) then
		ply:SetNWInt( "deathmode", 0 );
		ply:SetViewEntity( ply );

	end

	ply:ChangeMaxHealth(RAD.ConVars[ "DefaultHealth" ] - ply:MaxHealth());
	ply:ChangeMaxArmor(0 - ply:MaxArmor());
	ply:ChangeMaxWalkSpeed(RAD.ConVars[ "WalkSpeed" ] - ply:MaxWalkSpeed());
	ply:ChangeMaxRunSpeed(RAD.ConVars[ "RunSpeed" ] - ply:MaxRunSpeed());

	RAD.CallHook( "PlayerSpawn", ply )
	RAD.CallTeamHook( "PlayerSpawn", ply ); -- Change player speeds perhaps?
	
	local radarrp = RecipientFilter()
	radarrp:AddAllPlayers()
	if( ply:HasItem( "pda" ) ) then
        umsg.Start("pda_info", radarrp)
        umsg.Long( ply:EntIndex() )
        umsg.Bool( true )
        umsg.End()
        //local PDAPlayers[ ply:EntIndex() ] = true
    else
        umsg.Start("pda_info", radarrp)
        umsg.Long( ply:EntIndex() )
        umsg.Bool( false )
        umsg.End()
        //local PDAPlayers[ ply:EntIndex() ] = false
end
	local map = game.GetMap(); 
	if( RAD.CustomSpawnPoints[map] ) then
	    for k, v in pairs( RAD.CustomSpawnPoints[map] ) do
	
			--local num = math.random( 1, #RAD.CustomSpawnPoints[map] );
			local sp = RAD.CustomSpawnPoints[map][k];	
			 --this still doesnt work, add the spawn points with flags to tables, etc. sort through them if you have the flag etc.
			if( sp.FlagBool and table.HasValue( sp.Flags, RAD.Teams[ply:Team()].flag_key ) and ply:GetTable().LastSpawnPoint != sp)then 
			    ply:SetPos( sp.Pos );
			    ply:SetEyeAngles( sp.Ang );
				ply:GetTable().LastSpawnPoint = sp
                return				
	        elseif( ply:GetTable().LastSpawnPoint != sp )then
			    ply:SetPos( sp.Pos );
			    ply:SetEyeAngles( sp.Ang );	
				ply:GetTable().LastSpawnPoint = sp
				return
		    end	
        end
    end
end
		
function GM:PlayerSetModel(ply)
	
	if(RAD.Teams[ply:Team()] != nil) then
	
		if(RAD.Teams[ply:Team()].default_model == true) then
		
			if(RAD.Teams[ply:Team()].partial_model == true) then
			
				local m = RAD.Teams[ply:Team()]["model_path"] .. string.sub(ply:GetNWString("model"), 23, string.len(ply:GetNWString("model")));
				ply:SetModel(m);
				RAD.CallHook( "PlayerSetModel", ply, m);
				
			elseif(RAD.Teams[ply:Team()].partial_model == false) then
			
				local m = RAD.Teams[ply:Team()]["model_path"];
				ply:SetModel(m);
				RAD.CallHook( "PlayerSetModel", ply, m);
				
			end
			
		else
		
			m = RAD.GetCharField( ply, "model" )
			ply:SetModel(m);
			RAD.CallHook( "PlayerSetModel", ply, m);

		end
		
	else
		
		m = "models/srp/rookie1.mdl";
		ply:SetModel("models/srp/rookie1.mdl");
		RAD.CallHook( "PlayerSetModel", ply, m);
		
	end
	
	RAD.CallTeamHook( "PlayerSetModel", ply, m);

end

function GM:PlayerDeath(ply)

	RAD.DeathMode(ply);
	RAD.CallHook("PlayerDeath", ply);
	RAD.CallTeamHook("PlayerDeath", ply);
    RAD.SetCharField(ply, "wepitem", "none")
    RAD.SetCharField(ply, "wepitem2", "none")
	ply:GetTable().BleedAmt = 0
end

function GM:PlayerDeathThink(ply)

	ply.nextsecond = RAD.NilFix(ply.nextsecond, CurTime())
	ply.deathtime = RAD.NilFix(ply.deathtime, 120);
	
	if(CurTime() > ply.nextsecond) then
	
		if(ply.deathtime < 120) then
		
			ply.deathtime = ply.deathtime + 1;
			ply.nextsecond = CurTime() + 1;
			ply:SetNWInt("deathmoderemaining", 120 - ply.deathtime);
			
		else
		
			ply.deathtime = nil;
			ply.nextsecond = nil;
			ply:Spawn();
			ply:SetNWInt("deathmode", 0);
			ply:SetNWInt("deathmoderemaining", 0);
			
		end
		
	end
	
end

BannedGuns = { "hands", "claws", "weapon_gravcannon", "weapon_physcannon", "weapon_gravgun", "weapon_physgun", "gmod_tool", "weapon_door_ram" }

function GM:DoPlayerDeath( ply, attacker, dmginfo )

	// print( RAD.GetCharField(ply, "wepitem" ) )
	ply.DropBlood = CurTime()
	//if( attacker:IsPlayer() ) then
		if math.random(1, 50) == 25 then
			ply:ConCommand("rp_dropsuit")
	        RAD.SetCharField(ply, "model", "models/srpmodels/loner1.mdl" );
				ply:GetTable().BleedAmt = 0
			RAD.SendChat( ply, "You Lost Your Suit When You Died" );
       	 end
			local inv = RAD.GetCharField( ply, "inventory" );
			local invamt = table.Count(inv)
			if ( invamt >= 7 ) then
			local randomitem = table.Random(inv)
        		RAD.SendChat( ply, "You Lost An Item When You Died" );		
			ply:TakeItem( randomitem )
			RAD.CreateItem( randomitem, ply:CalcDrop( ), Angle( 0,0,0 ) );
			// table.insert(rag.inventory, randomitem)
		end
	//end
		
    local weap = ply:GetActiveWeapon();

	if(table.HasValue(BannedGuns, RAD.GetCharField(ply, "wepitem" ))) then return false; end
	RAD.CreateItem( RAD.GetCharField(ply, "wepitem" ), ply:CalcDrop( ), Angle( 0,0,0 ) );
	RAD.CreateItem( RAD.GetCharField(ply, "wepitem2" ), ply:CalcDrop( ), Angle( 0,0,0 ) );
	// RAD.CreateItem( weap:GetClass(), ply:GetPos(), ply:GetAngles() )
    RAD.SetCharField(ply, "wepitem", "none")
	RAD.SetCharField(ply, "wepitem2", "none")
	ply:GetTable().BleedAmt = 0
end

function GM:PlayerUse(ply, entity)

	if(RAD.IsDoor(entity)) then
		local doorgroups = RAD.GetDoorGroup(entity)
		for k, v in pairs(doorgroups) do
			if(table.HasValue(RAD.Teams[ply:Team()]["door_groups"], v)) then
				return false;
			end
		end
	end
	return self.BaseClass:PlayerUse(ply, entity);

end

function GM:PlayerDeathSound()

	return true;

end

storm_active = false;

//function AutoWeather()
//	if storm_active then return; end
//		if math.random(1,3)==1 then
//			BeginStorm();
//		end	
//end
//timer.Create( "AutoWeather", 2400, 0, AutoWeather );