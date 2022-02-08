PLUGIN.Name = "Player Voices"; -- What is the plugin name
PLUGIN.Author = "SilverKnight"; -- Author of the plugin
PLUGIN.Description = "Enables players to say things"; -- The description or purpose of the plugin

RAD.Voices = { }; -- I hear voices D:>

function ccVoice( ply, cmd, args ) -- People near you will hear the voice

	local id = args[ 1 ];
	
	if( RAD.Voices[ id ] == nil ) then

		RAD.SendConsole( ply, "This sound does not exist. Use rp_listvoices" );
		return;
		
	end
	
	if( not ply:Alive() ) then return; end

	local voice = RAD.Voices[ id ];
	local team = ply:Team( );
	
	if( table.HasValue( RAD.Teams[ team ][ "sound_groups" ], voice.soundgroup ) ) then
		
		local path = voice.path;
		
		if((string.find(string.lower(ply:GetModel()), "female") or string.lower(ply:GetModel()) == "models/alyx.mdl") and voice.femalealt != "") then
			path = voice.femalealt;
		end
		
		if(RAD.Teams[ team ].iscombine == true) then
		
			local function EmitThatShitz()
			end
			
			local function EmitThatShit()
				ply:EmitSound(path);
				timer.Simple(1, EmitThatShitz);
			end

			timer.Simple(1, EmitThatShit);
			
			
			return "";
			
		end
			
		util.PrecacheSound( path );
		ply:EmitSound( path );
		ply:ConCommand( "say " .. voice.line .. "\n" );
		
	end
	
end
concommand.Add( "rp_voice", ccVoice );

function ccListVoice( ply, cmd, args ) -- LIST DA FUKKEN VOICES

	RAD.SendConsole( ply, "---List of RadiationScript Voices---" );
	RAD.SendConsole( ply, "Please note, these are only for your current flag" );
	
	for _, voice in pairs(RAD.Voices) do

		if(table.HasValue(RAD.Teams[ply:Team()]["sound_groups"], voice.soundgroup)) then
		
			RAD.SendConsole( ply, _ .. " - " .. voice.line .. " - " .. voice.path );
			
		end
		
	end
	
end
concommand.Add( "rp_listvoices", ccListVoice );

function RAD.AddVoice( id, path, soundgroup, text, fa)

	local voice = { };
	voice.path = path;
	voice.soundgroup = RAD.NilFix(soundgroup, 0);
	voice.line = RAD.NilFix(text, "");
	voice.femalealt = RAD.NilFix(fa, "");
	
	RAD.Voices[ id ] = voice;
	
end