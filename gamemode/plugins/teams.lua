PLUGIN.Name = "RAD Teams";
PLUGIN.Author = "SilverKnight";
PLUGIN.Description = "Load teh teams.";
function RAD.LoadRADTeams()
	local team = RAD.Class();	
	-- Item Groups
	-- Duty: 18
	-- Freedom: 19
	-- Eco: 17
	-- Military: 20
    -- Mono: 21
	RAD.AddTeam( RAD.Class( ) );
	-- name, color, model_path, default_model, partial_model, weapons, flag_key, door_groups,  sound_groups, item_groups, salary, public, business, broadcast, combine
	-- Main Factions
	RAD.AddTeam( RAD.Class( "DUTY", 0, Color(175, 23, 31, 255), "", false, false, {"kabar"}, "duty", {2}, {1}, {0}, 100, false, false, false, true) );
    RAD.AddTeam( RAD.Class( "Freedom", 0, Color(255, 185, 15, 255), "", false, false, {"kabar"}, "freedom", {0}, {1}, {0}, 100, false, false, false, true) ); 
	RAD.AddTeam( RAD.Class( "Military", 150, Color(0, 139, 0, 255), "models/player/hoodh4.mdl", true, false, {"kabar"}, "military", {0}, {1}, {0}, 150, false, false, true, true) );
	RAD.AddTeam( RAD.Class( "Monolith", 0, Color(0, 139, 0, 255), "", false, false, {"kabar"}, "mono", {0}, {1}, {0}, 100, false, false, true, true) );

    RAD.AddTeam( RAD.Class( "Ecologist Team Leader", 0, Color(255, 255, 255, 255), "", false, false, {"kabar"}, "ecoleader", {0}, {1}, {17}, 600, false, true, true, true) );
    RAD.AddTeam( RAD.Class( "Ecologist Guard", 0, Color(255, 255, 255, 255), "", false, false, {"kabar"}, "ecoguard", {0}, {1}, {0}, 250, false, false, true, true) );
	RAD.AddTeam( RAD.Class( "Ecologist", 0, Color(255, 255, 255, 255), "", false, false, {"kabar"}, "eco", {0}, {1}, {17}, 300, false, true, true, true) );
    RAD.AddTeam( RAD.Class( "Scientist", 0, Color(255, 255, 255, 255), "models/srp/scientist.mdl", true, false, {"kabar"}, "sci", {0}, {1}, {17}, 500, false, true, true, true) );                     
--Other Factions
	RAD.AddTeam( RAD.Class( "Master Merc", 300, Color(50, 200, 31, 255), "", false, false, {"kabar", "F2000", "makarov"}, "mmerc", {0}, {1}, {0}, 0, false, false, true, true) );
    RAD.AddTeam( RAD.Class( "Veteran Merc", 200, Color(50, 200, 31, 255), "", false, false, {"kabar", "lr300"}, "vmerc", {0}, {1}, {0}, 0, false, false, true, true) );
    RAD.AddTeam( RAD.Class( "Experienced Merc", 100, Color(50, 200, 31, 255), "", false, false, {"kabar", "mp5"}, "emerc", {0}, {1}, {0}, 0, false, false, true, true) );
    RAD.AddTeam( RAD.Class( "Military Merc", 100, Color(0, 139, 0, 255), "models/srp/stalker_antigas_killer_uk.mdl", true, false, {"kabar"}, "militarymerc", {0}, {1}, {0}, 0, false, false, true, true) );

    RAD.AddTeam( RAD.Class( "Master Bandit", 100, Color(119, 136, 153, 255), "", false, false, {"kabar","ak74", "p220"}, "mbandit", {0}, {1}, {0}, 0, false, false, true) );
    RAD.AddTeam( RAD.Class( "Veteran Bandit", 100, Color(119, 136, 153, 255), "", false, false, {"kabar", "ak74u"}, "vbandit", {0}, {1}, {0}, 0, false, false, false, true) );
    RAD.AddTeam( RAD.Class( "Experienced Bandit", 100, Color(119, 136, 153, 255), "", false, false, {"kabar", "p220"}, "ebandit", {0}, {1}, {0}, 0, false, false, false, true) );

    RAD.AddTeam( RAD.Class( "Veteran Stalker", 100, Color(200, 100, 0, 255), "models/srp/stalker_bes.mdl", false, false, {"kabar", "ak74u"}, "vstalker", {0}, {1}, {0}, 200, false, true, false, false) );
    RAD.AddTeam( RAD.Class( "Experienced Stalker", 100, Color(200, 100, 0, 255), "models/srp/stalker_hood.mdl", false, false, {"kabar", "makarov"}, "estalker", {0}, {1}, {0}, 200, false, true, false, false) );
--Misc
    RAD.AddTeam( RAD.Class( "Zombified Stalker", 00, Color(120, 80, 160, 200), "models/srp/stalker_hood_corpse.mdl", true, false, {"kabar"}, "zombst", {0}, {10}, {0}, 0, false, false, false, false) );
    RAD.AddTeam( RAD.Class( "Bloodsucker", 00, Color(100, 100, 100, 200), "models/srp/blood_sucker.mdl", true, false, {"claws","cloak"}, "blood", {0}, {8}, {0}, 0, false, false, false, false) );
    RAD.AddTeam( RAD.Class( "Bloodsucker", 00, Color(100, 100, 100, 200), "models/srp/blood_sucker2.mdl", true, false, {"claws","cloak"}, "blood2", {0}, {8}, {0}, 0, false, false, false, false) );
	RAD.AddTeam( RAD.Class( "Snork", 00, Color(100, 100, 100, 200), "models/stalker/srk.mdl", true, false, {"pill_snork"}, "snork", {0}, {9}, {0}, 0, false, false, false, false) );
    RAD.AddTeam( RAD.Class( "Controller", 00, Color(100, 100, 100, 200), "models/srp/stalker_kontroler.mdl", true, false, {"claws","controller"}, "controller", {0}, {0}, {0}, 0, false, true, false, false) );
    RAD.AddTeam( RAD.Class( "Trader", 1000, Color(56, 142, 142, 255), "", false, false, {"kabar"}, "trader", {0}, {7}, {5,3,6}, 600, false, true, true, true) ); 

    RAD.AddTeam( RAD.Class( "DUTY", 00, Color(175, 23, 31, 255), "", false, false, {"kabar"}, "dutyleader", {2}, {1}, {18}, 700, false, true, true, true) );
    RAD.AddTeam( RAD.Class( "DUTY", 00, Color(175, 23, 31, 255), "", false, false, {"kabar"}, "dutyofficer", {2}, {1}, {18}, 200, false, true, true, true) );
    RAD.AddTeam( RAD.Class( "Freedom", 00, Color(255, 185, 15, 255), "", false, false, {"kabar"}, "freedomleader", {0}, {1}, {19}, 700, false, true, true, true) );
	RAD.AddTeam( RAD.Class( "Freedom", 00, Color(255, 185, 15, 255), "", false, false, {"kabar"}, "freedomofficer", {0}, {1}, {19}, 200, false, true, true, true) );
    RAD.AddTeam( RAD.Class( "Military", 200, Color(0, 139, 0, 255), "models/srp/specnaz.mdl", true, false, {"kabar"}, "militaryleader", {0}, {1}, {20}, 800, false, true, false, true) );
    RAD.AddTeam( RAD.Class( "Military", 200, Color(0, 139, 0, 255), "models/srp/specnaz.mdl", true, false, {"kabar"}, "militaryofficer", {0}, {1}, {20}, 450, false, true, false, true) );
    RAD.AddTeam( RAD.Class( "Monolith", 00, Color(0, 255, 255, 255), "", false, false, {"kabar"}, "monoleader", {0}, {1}, {21}, 700, false, true, false, true) );
    RAD.AddTeam( RAD.Class( "Monolith",00, Color(0, 255, 255, 255), "", false, false, {"kabar"}, "monoofficer", {0}, {1}, {21}, 200, false, true, false, true) );
	
	Msg( "StalkerRP Teams loaded.\n" )	
end


