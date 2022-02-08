-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- chat.lua
-- Holds the chat commands and functions.
-- A lot of this code was based off of TacoScript's chat.lua - Credits to DarkCybo1
-------------------------------

RAD.ChatCommands = {  };

function RAD.SimpleChatCommand( prefix, range, form )

	-- This is for simple chat commands like /me, /y, /w, etc
	-- This isn't useful for radio, broadcast, etc.

	-- Quite a new feature, you can specify a 'format' for the output.
	-- %1 - IC Name
	-- %2 - OOC Name
	-- %3 - Text Given
	--
	-- So, someone using Local OOC chat, would output this:
	-- Joe Bob | Bobby1337 [ LOCAL OOC ]: WAIT WHAT.
	-- The format would be: "%1 | %2 [ LOCAL OOC ]: %3"
	--
	-- Also, the range is a multiplier based upon the ConVar "TalkRange".
	--
	-- Genius, 'miryt?
	
	local cc = {  };
	cc.simple = true;
	cc.cmd = cmd;
	cc.range = range;
	cc.form = form;
	
	RAD.ChatCommands[ prefix ] = cc;
	
end

function RAD.ChatCommand( prefix, callback )

	local cc = {  }
	cc.simple = false;
	cc.cmd = prefix;
	cc.callback = callback;
	
	RAD.ChatCommands[ prefix ] = cc;
	
end

function GM:PlayerSay( ply, text, toall )

	RAD.DayLog("chat.txt", ply:SteamID() .. " - " .. ply:Nick() .. ": " .. text);
	RAD.CallHook("PlayerSay", ply, text, toall);
	
	if( string.sub( text, 1, 1 ) == "!" ) then -- All rp_ commands can be executed with !
	
		ply:ConCommand("rp_" .. string.sub( text, 2, string.len(text) ));
		return "";
		
	end
	// string.gsub( text, "%", "percent" )
	
	for prefix, cc in pairs( RAD.ChatCommands ) do
	
		local cmd = prefix;
		local cmdlen = string.len( cmd );
		local cmdtxt = string.sub( text, 0, cmdlen );
		
		cmdtxt = string.lower( cmdtxt );
		cmd = string.lower( cmd );
		
		if( cmdtxt == cmd and (string.sub( text, cmdlen + 1, cmdlen + 1 ) == " " or string.len(text) == cmdlen) ) then -- This allows for multiple commands to start with the same thing 
			
			local args = string.sub( text, cmdlen + 2 );
			
			if( args == nil ) then
			
				args = "";
				
			end
			
			if( !cc.simple ) then
			
				return cc.callback( ply, args );
				
			end
			
			
			local range = RAD.ConVars[ "TalkRange" ] * cc.range;
			
			local s = cc.form;
			local s = string.gsub( s, "$1", ply:Nick( ) ); -- IC Name
			local s = string.gsub( s, "$2", ply:Name( ) ); -- OOC Name
			local s = string.gsub( s, "$3", args ); -- Text
			
			for _, pl in pairs( player.GetAll( ) ) do
			
				if( pl:EyePos( ):Distance( ply:EyePos( ) ) <= range ) then
				
					-- RAD.SendChat( pl, s );
					
					umsg.Start( "RAD_Chat_Character_Message", pl );
						umsg.Entity( pl );
						umsg.String( ply:Nick() );
						umsg.String( "ic" );
						umsg.String( s );
					umsg.End( );
				
				end
			
			end
			
			return "";
			
		end
		
	end
	
	if( string.sub( text, 1, 1 ) == "/" ) then
	
		RAD.SendChat( ply, "That is not a valid command" );
		return "";
	
	else
	
		local range = RAD.ConVars[ "TalkRange" ]
		
		for _, pl in pairs( player.GetAll( ) ) do
		
			if( pl:EyePos( ):Distance( ply:EyePos( ) ) <= range ) then
			
				umsg.Start( "RAD_Chat_Character_Message", pl );
					umsg.Entity( pl );
					umsg.String( ply:Nick() );
					umsg.String( "talk" );
					umsg.String( text );
				umsg.End( );
			
			end
		
		end
		
		return "";
		
	end
	
end
		
function SendChatMessage( receiver, filter, text )
	umsg.Start( "RAD_Chat_Character_Message", receiver );
		umsg.Entity( receiver );
		umsg.String( filter );
		umsg.String( text );
	umsg.End( );
end

function SendCharChatMessage( sender, receiver, filter, text )
	umsg.Start( "RAD_Chat_Character_Message", receiver );
		umsg.Entity( receiver );
		umsg.String( sender:Nick() );
		umsg.String( filter );
		umsg.String( text );
	umsg.End( );
end
