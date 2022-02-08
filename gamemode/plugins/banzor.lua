PLUGIN.Name = "banzor"; -- What is the plugin name
PLUGIN.Author = "HGN"; -- Author of the plugin
PLUGIN.Description = "Keeps The Bad Ones Out!"; -- The description or purpose of the plugin   

function RAD.HandleScriptBans( ply )
			for k, v in pairs( RAD.BanTable ) do
			  if( ply:SteamID() == v.steamid )then
				local UniqueID = ply:UserID( );
				RAD.SendConsole( ply, "Your SteamID is banned, Cya.\n" );
		        game.ConsoleCommand( "kickid " .. UniqueID .. " \"" .. v.reason .. "\"\n" );
		        RAD.AnnounceInformation( ply:Name() .. " was kicked, reason: " .. v.reason )
		      end
			end
end 
RAD.AddHook("Player_Preload", "HandleScriptBans", RAD.HandleScriptBans)

RAD.BanTable = {}

local function AddBanList( steamid, reason )
table.insert( RAD.BanTable, { steamid = steamid, reason = reason } );
end
AddBanList( "STEAM_0:0:15049318", "Leecher." ) -- jerry for being a thief and a fag
AddBanList( "STEAM_0:1:16279839", "Spamming." ) --jerrys Bitch
AddBanList( "STEAM_0:0:9240947", "CannotFly" ) --sugary treat gone bad
AddBanList( "STEAM_0:0:17264910", "snaggedsomepoop" ) --sniggers
AddBanList( "STEAM_0:0:13872882", "fairyrape" ) --cakes on the house
AddBanList( "STEAM_0:1:14952330", "hungryleechers" ) --hippos
AddBanList( "STEAM_0:1:21452466", "hgnelitehatefankid" ) --uptight fag
