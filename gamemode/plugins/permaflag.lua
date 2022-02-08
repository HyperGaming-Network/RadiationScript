PLUGIN.Name = "Permaflags"; -- What is the plugin name
PLUGIN.Author = "Nori"; -- Author of the plugin
PLUGIN.Description = "Allows a player to automatically spawn as a certain flag when the character is selected"; -- The description or purpose of the plugin

function SetPermaflag(ply, cmd, args)

	if(#args != 1) then
	
		RAD.SendConsole(ply, "Incorrect number of arguments!");
		return;
		
	end
	
	local flagkey = args[1];
	
	for k, v in pairs(RAD.Teams) do
	
		if(v.flag_key == flagkey and (table.HasValue(RAD.GetCharField(ply, "flags"), flagkey) or v.public == true)) then
			
			RAD.SetCharField(ply, "permaflag", flagkey)
			RAD.SendConsole(ply, "Permaflag set to " .. flagkey);
			
		end
		
	end
	
end
concommand.Add("rp_permaflag", SetPermaflag);

function Permaflag_Set(ply)

	for k, v in pairs(RAD.Teams) do
	
		if(v.flag_key == RAD.GetCharField(ply, "permaflag")) then
		
			if(table.HasValue(RAD.GetCharField(ply, "flags"), RAD.GetCharField(ply, "permaflag")) or v.public == true) then
			

				ply:SetTeam(k)
				
			else
			

				RAD.SetCharField(ply, "permaflag", RAD.ConVars["DefaultPermaflag"]);
			
			end
			
		end
		
	end
	
end

function PLUGIN.Init()
	
	RAD.ConVars["DefaultPermaflag"] = "citizen";
	
	RAD.AddDataField( 2, "permaflag", RAD.ConVars["DefaultPermaflag"] ); -- What is the default permaflag (Citizen by default, shouldn't be changed)
	RAD.AddHook("CharacterSelect_PostSetTeam", "permaflag", Permaflag_Set);
	
end
