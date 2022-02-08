PLUGIN.Name = "Chat Commands"; -- What is the plugin name
PLUGIN.Author = "LastExile"; -- Author of the plugin
PLUGIN.Description = "A set of default chat commands"; -- The description or purpose of the plugin

function OOCChat( ply, text )
	
	if(ply.LastOOC + RAD.ConVars[ "OOCDelay" ] < CurTime() ) then
	
		ply.LastOOC = CurTime();
		for k, v in pairs(player.GetAll()) do
			
			umsg.Start( "RAD_Chat_Character_Message", v );
				umsg.Entity( v );
				umsg.String( ply:Name() );
				umsg.String( "ooc" );
				umsg.String( text );
			umsg.End( );
		
		end
	
	else
	
		local TimeLeft = math.ceil(ply.LastOOC + RAD.ConVars[ "OOCDelay" ] - CurTime());
		RAD.SendChat( ply, "Please wait " .. TimeLeft .. " seconds before using OOC chat again!");
		
	end
	
	return "";
	
end

function Broadcast( ply, text )

	local team = ply:Team( );
	if not ply:HasItem("pda") then ply:PrintMessage( 3, "You Don't Have A PDA, Dummy!" ); return ""; end	
	if( RAD.Teams[ team ][ "broadcast" ] and ply:HasItem("pda") ) then
		for k, v in pairs( player.GetAll( ) ) do
			-- RAD.SendChat( v, ply:Nick( ) .. " [BROADCAST]: " .. text );
			
			umsg.Start( "RAD_Chat_Character_Message", v );
				umsg.Entity( v );
				umsg.String( ply:Nick() );
				umsg.String( "broadcast" );
				umsg.String( text );
			umsg.End( );
		end
	end
	
	return "";
	
end

function Event( ply, text )

	if(ply:IsAdmin()) then
		
		for k, v in pairs( player.GetAll( ) ) do
		
			umsg.Start( "RAD_Chat_Character_Message", v );
				umsg.Entity( v );
				umsg.String( ply:Nick() );
				umsg.String( "event" );
				umsg.String( text );
			umsg.End( );
			
		end
	
	end
	
	return "";
	
end

function ChangeTitle( ply, text )

ply:ConCommand( "rp_title ".. text );

return "";
	
end

function Advertise( ply, text )

	if(RAD.ConVars[ "AdvertiseEnabled" ] == "1") then
	
		if( tonumber( RAD.GetCharField( ply, "money" ) ) >= RAD.ConVars[ "AdvertisePrice" ] ) then
			
			ply:ChangeMoney( 0 - RAD.ConVars[ "AdvertisePrice" ] );
		
			for _, pl in pairs(player.GetAll()) do
				
				umsg.Start( "RAD_Chat_Character_Message", pl );
					umsg.Entity( pl );
					umsg.String( ply:Nick() );
					umsg.String( "advert" );
					umsg.String( text );
				umsg.End( );
		
			end
			
		else
		
			RAD.SendChat(ply, "You do not have enough credits! You need " .. RAD.ConVars[ "AdvertisePrice" ] .. " to send an advertisement.");
			
		end	
		
	else
	
		RAD.ChatPrint(ply, "Advertisements are not enabled");
		
	end
	
	return "";
	
end

local function Radio( ply, text )

	local players = player.GetAll();
	local heardit = {};
	
	for k, v in pairs(players) do
	        if v:HasItem("radio") and v:GetNWInt( "radiofreq" ) == ply:GetNWInt( "radiofreq" ) then
	                    RAD.SendChat(v, "[RADIO] " .. ply:Nick() .. ": " .. text);
						table.insert(heardit, v);
            end
    end
	
	for k, v in pairs(players) do			
		if(!table.HasValue(heardit, v)) then
			local range = RAD.ConVars[ "TalkRange" ]
			
			if( v:EyePos( ):Distance( ply:EyePos( ) ) <= range ) then
			
				RAD.SendChat( v, ply:Nick() .. ": " .. text );
				
			end
		end		
	end
	
	return "";

end

function Chat_ModPlayerVars(ply)

	ply.LastOOC = -100000; -- This is so people can talk for the first time without having to wait.
		
end

local meta = FindMetaTable( "Player" );

function Dropgun(ply)

	if( not ply:GetActiveWeapon():IsValid() ) then
	
		ply:PrintMessage( 3, "Must have a weapon out" );
		return "";
	
	end

	ply:ConCommand("rp_dropweapon");
	return "";

end

function DropSuitChat(ply)

if( not ply:Alive() ) then
	
		ply:PrintMessage( 3, "You Cannot Drop A Suit While Dead..." );
		return "";
	
	end

	ply:ConCommand("rp_dropsuit");
	return "";

end

local function StartPM( ply, args)

	local namepos = string.find(args, " ")
	if not string.find(args, " ") then return "" end

	local name = string.sub(args, 1, namepos - 1)
	local msg = string.sub(args, namepos + 1)

	target = RAD.FindPlayer(name);

	 if !ply:HasItem("pda") then
	 RAD.SendChat(ply, "You Don't Have a PDA, what are you doing?")
      return "" end
	if target then
    if !target:HasItem("pda") then
	 RAD.SendChat(ply, "This person doesn't have a PDA!")
	 return "" end
		RAD.SendChat(target, "[PM] " .. ply:Nick() .. ": " .. msg)
		RAD.SendConsole(target, "[PM] " .. ply:Nick() .. ": " .. msg)
		
		RAD.SendChat(ply, "[PM] " .. ply:Nick() .. ": " .. msg)
		RAD.SendConsole(ply, "[PM] " .. ply:Nick() .. ": " .. msg)
	else
		RAD.SendChat(ply, "Couldn't find player: " .. name)
	end

	return ""
		
end
function GiveWeapon( ply, args )

	if( not ply:GetActiveWeapon():IsValid() ) then
	
		ply:PrintMessage( 3, "Must have a weapon out" );
		return "";
	
	end

	local trace = { }
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 200;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( ValidEntity( tr.Entity ) and tr.Entity:IsPlayer() ) then
	
		if( tr.Entity:EyePos():Distance( ply:EyePos() ) <= 50 ) then
		
			local activeweap = ply:GetActiveWeapon();
			
						tr.Entity:GetTable().ForceGive = true;
			tr.Entity:Give( activeweap:GetClass() );
		    tr.Entity:GetTable().ForceGive = false;
			 if (ply:GetActiveWeapon().WepType) == "wepitem2" then
           		 RAD.SetCharField(ply, "wepitem2", "none")
        		elseif (ply:GetActiveWeapon().WepType) == "wepitem" then
            		RAD.SetCharField(ply, "wepitem", "none")
			ply:StripWeapon( activeweap:GetClass() );

        end
		else
		
			ply:PrintMessage( 3, "Not close enough to player" );
		
		end
		
	else
	
		ply:PrintMessage( 3, "Must be looking at a player" );
	
	end
	
	return "";

end
function StartMotd( ply, text )

ply:ConCommand( "_advmotd".. text );

return "";
	
end

function SitToggle( ply, text )

ply:ConCommand( "cs_sit".. text );

return "";
	
end

function SitChairToggle( ply, text )

ply:ConCommand( "cs_sitchair".. text );

return "";
	
end

function LeanLeftToggle( ply, text )

ply:ConCommand( "cs_leaningleft".. text );

return "";
	
end

function LeanBackToggle( ply, text )

ply:ConCommand( "cs_leanback".. text );

return "";
	
end

function ccAdminChat( ply, text )
	if(!ply:IsAdmin()) then return false; end

	for k,v in pairs( player.GetAll() ) do

		if( v:IsAdmin() ) then
			
			umsg.Start( "RAD_Chat_Character_Message", v );
				umsg.Entity( v );
			    umsg.String( ply:Name() );
				umsg.String( "admin" );
				umsg.String( text );
			umsg.End( );
		end

	end

return "";

end

function ccAdminPChat( ply, text )
if(!ply:IsAdmin()) then return false; end

	for k,v in pairs( player.GetAll() ) do
		umsg.Start( "RAD_Chat_Character_Message", v );
			umsg.Entity( v );
			umsg.String( ply:Name() );
			umsg.String( "adminbc" );
			umsg.String( text );
		umsg.End( );
	end

return "";

end

function ccAdminRequest( ply, text )

for k,v in pairs( player.GetAll() ) do

	if( v:IsAdmin() ) then
	
	-- RAD.SendChat(v, "[Player Request] ".. v:Nick() ..": ".. text )
	
	umsg.Start( "RAD_Chat_Character_Message", v );
		umsg.Entity( v );
		umsg.String( ply:Nick() );
		umsg.String( "request" );
		umsg.String( text );
	umsg.End( );

	end

end

RAD.SendChat(ply, "Request Sent.");
ply.RequestSent = 1;

timer.Simple(60, function()
ply.RequestSent = 0;
end);

return "";

end

function RollDice(ply, text) 

local players = player.GetAll();
local num = math.random(1,100)
			
	for k, v in pairs(players) do
				
			local range = RAD.ConVars[ "TalkRange" ]
			
			if( v:EyePos( ):Distance( ply:EyePos( ) ) <= range ) then
					RAD.SendChat( v, ply:Nick() .. " rolls the dice, getting " .. num )
					RAD.SendConsole( v, ply:Nick() .. " rolls the dice, getting " .. num )
				
			end
					
	end
						
	
	return "";


end

function PLUGIN.Init( ) -- We run this in init, because this is called after the entire gamemode has been loaded.

	RAD.ConVars[ "AdvertiseEnabled" ] = "1"; -- Can players advertise
	RAD.ConVars[ "AdvertisePrice" ] = 100; -- How much do advertisements cost
	RAD.ConVars[ "OOCDelay" ] = 10; -- How long do you have to wait between OOC Chat
	
	RAD.ConVars[ "YellRange" ] = 1.5; -- How much farther will yell chat go
	RAD.ConVars[ "WhisperRange" ] = 0.2; -- How far will whisper chat go
	RAD.ConVars[ "MeRange" ] = 1.0; -- How far will me chat go
	RAD.ConVars[ "LOOCRange" ] = 1.0; -- How far will LOOC chat go
	
	RAD.SimpleChatCommand( "/me", RAD.ConVars[ "MeRange" ], "** $1 $3" ); -- Me chat
	RAD.SimpleChatCommand( "/y", RAD.ConVars[ "YellRange" ], "** $1 yells out, \"$3\"" ); -- Yell chat
	RAD.SimpleChatCommand( "/it", RAD.ConVars[ "YellRange" ], "** $3" ); -- It CMD
	RAD.SimpleChatCommand( "/w", RAD.ConVars[ "WhisperRange" ], "** $1 whispers quietly, \"$3\"" ); -- Whisper chat
	RAD.SimpleChatCommand( ".//", RAD.ConVars[ "LOOCRange" ], "$1 | $2 [LOOC]: $3" ); -- Local OOC Chat
	RAD.SimpleChatCommand( "[[", RAD.ConVars[ "LOOCRange" ], "$1 | $2 [LOOC]: $3" ); -- Local OOC Chat

	RAD.ChatCommand( "/ad", Advertise );
	RAD.ChatCommand( "/adv", Advertise );
	RAD.ChatCommand( "/ooc", OOCChat );
	RAD.ChatCommand( "/o", OOCChat );
	RAD.ChatCommand( "//", OOCChat );
	RAD.ChatCommand( "/bc", Broadcast );
	RAD.ChatCommand( "/ev", Event );
	RAD.ChatCommand( "/radio", Radio )
	RAD.ChatCommand( "/r", Radio );
	RAD.ChatCommand( "/dropgun", Dropgun );
	RAD.ChatCommand( "/dropsuit", DropSuitChat );
	//RAD.ChatCommand( "/givegun", GiveWeapon );
	RAD.ChatCommand( "/a", ccAdminChat );
	RAD.ChatCommand( "/ab", ccAdminPChat );
	RAD.ChatCommand( "/ar", ccAdminRequest );
	RAD.ChatCommand( "/title", ChangeTitle );
	RAD.ChatCommand( "/pm", StartPM );
	RAD.ChatCommand( "/motd", StartMotd );
	RAD.ChatCommand( "/sit", SitToggle );
	RAD.ChatCommand( "/sitchair", SitChairToggle );
	RAD.ChatCommand( "/leanleft", LeanLeftToggle );
	RAD.ChatCommand( "/leanback", LeanBackToggle );
	RAD.ChatCommand( "/roll", RollDice );
	
	RAD.AddHook("Player_Preload", "chat_modplayervars", Chat_ModPlayerVars);

end