PLUGIN.Name = "Stalker"; -- What is the pugin name
PLUGIN.Author = "SilverKnight"; -- Author of the plugin
PLUGIN.Description = "A collection of team making functions."; -- The description or purpose of the plugin

function PLUGIN.Init( )
	
end

function CombineDeath(ply)

	util.PrecacheSound( "hgn/stalker/player/death1.mp3" );
	ply:EmitSound( "hgn/stalker/player/death1.mp3" );

end

function RAD.Class(name, armor, color, model_path, default_model, partial_model, weapons, flag_key, door_groups, sound_groups, item_groups, salary, public, business, broadcast, iscombine)

	local team = RAD.TeamObject();
	
	team.name = RAD.NilFix(name, "S.T.A.L.K.E.R");
	team.armor = RAD.NilFix(armor, 0)
	team.color = RAD.NilFix(color, Color(238, 238, 0, 255));
	team.model_path = RAD.NilFix(model_path, "");
	team.default_model = RAD.NilFix(default_model, false);
	team.partial_model = RAD.NilFix(partial_model, false);
	team.weapons = RAD.NilFix(weapons, {});
	team.flag_key = RAD.NilFix(flag_key, "citizen");
	team.door_groups = RAD.NilFix(door_groups, { });
	team.sound_groups = RAD.NilFix(sound_groups, { 1 });
	team.item_groups = RAD.NilFix(item_groups, { 3 , 5 , 6 , 2 , 4 });
	team.salary = RAD.NilFix(salary, 0);
	team.public = RAD.NilFix(public, true);
	team.business = RAD.NilFix(business, false);
	team.broadcast = RAD.NilFix(broadcast, false);
	team.iscombine = RAD.NilFix(iscombine, true);
	
	if(team.iscombine == true) then

		RAD.AddTeamHook("PlayerDeath", team.flag_key .. "_combinedeath", CombineDeath, team.flag_key);
		
	end
	
	return team;
	
end