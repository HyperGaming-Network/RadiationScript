-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- teams.lua
-- Holds the team functions.
-------------------------------

RAD.Teams = {  };

function RAD.AddTeam( team )

	local n = #RAD.Teams + 1;
	
	RAD.CallHook("AddTeam", team);
	
	RAD.Teams[ n ] = team;
	
end

function RAD.InitTeams( )

	for k, v in pairs( RAD.Teams ) do
	
		team.SetUp( k, v[ "name" ], v[ "color" ] );
		
		-- Send the team to client
		for k2, ply in pairs(player.GetAll()) do
			umsg.Start( "setupteam", ply );
			
				umsg.Long( k );
				umsg.String( v[ "name" ] );
				umsg.Long( v[ "color" ].r );
				umsg.Long( v[ "color" ].g );
				umsg.Long( v[ "color" ].b );
				umsg.Long( v[ "color" ].a );
				umsg.Bool( v[ "public" ] );
				umsg.Long( v[ "salary" ] );
				umsg.String( v[ "flag_key" ] );
				umsg.Bool( v[ "business" ] );
				
				RAD.CallHook("SendTeamData", ply, v);
				
			umsg.End( );
			
		end
			
	end
	
end

function RAD.TeamObject( )

	local team = {  };
	
	-- Basic team configuration
	team.name = "";
	team.armor = 0;
	team.color = Color( 0, 0, 0, 255 );
	
	-- Model configuration
	team.model_path = "";
	team.default_model = false; -- Does the team have a model to use
	team.partial_model = false; -- Is the regular citizen model's suffix added onto the end of our modelpath ( Ex. male_07.mdl )
	
	-- Weapons Configuration
	team.weapons = {  };
	
	-- Flag Configuration
	team.flag_key = ""; -- What is used with rp_flag
	team.door_groups = {  }; -- What groups of doors can the team open
	team.sound_groups = {  }; -- What voices can the team use
	team.item_groups = {  }; -- What items can the team purchase
	team.salary = 25; -- How many credits does this flag earn every paycheck?
	team.public = true;
	team.business = false;
	team.broadcast = false;
	
	RAD.CallHook("CreateTeamObject", team); -- Hooray, plugins get to throw in their own variables! :3
	
	return team;
	
end
