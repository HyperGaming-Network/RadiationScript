-------------------------------
-- Radiation Script
-- Author: Silver Knight
-- Project Start: 11/26/2008
-- cl_binds.lua
-- Changes what keys do.
-------------------------------

RAD.ContextEnabled = false;

function GM:PlayerBindPress( ply, bind, pressed )
	if( LocalPlayer( ):GetNWInt( "charactercreate" ) == 1 ) then
	
		if( bind == "+forward" or bind == "+back" or bind == "+moveleft" or bind == "+moveright" or bind == "+jump" or bind == "+duck" ) then return true; end -- Disable ALL movement keys.
	
	end
	
	if( bind == "+use" ) then
	
		local trent = LocalPlayer( ):GetEyeTrace( ).Entity;
		
		if( trent != nil and trent:IsValid( ) and RAD.IsDoor( trent ) ) then
		
			LocalPlayer( ):ConCommand( "rp_opendoor" );
			
		end
		
	end
	if( bind == "slot1" ) then
	
		ply:ConCommand( "rp_pickknife\n" );
	
	end
	
	if( bind == "slot2" ) then
	
		ply:ConCommand( "rp_picksidearm\n" );
	
	end
	
	if( bind == "slot3" ) then
		
		ply:ConCommand( "rp_pickprimarygun\n" );
		
	end
	
	if( bind == "slot4" ) then
	
		ply:ConCommand( "rp_pickunarmed\n" );
	
	end

	if( bind == "slot5" ) then
	
		ply:ConCommand( "rp_pickphysgun\n" );
	
	end

	if( bind == "slot6" ) then
	
		ply:ConCommand( "rp_pickgravgun\n" );
	
	end
	
	if( bind == "slot7" ) then
	
		ply:ConCommand( "rp_picktoolgun\n" );
	
	end
end

function GM:ScoreboardShow( )

	RAD.ContextEnabled = true;
	gui.EnableScreenClicker( true )
	HiddenButton:SetVisible( true );
	
end

function GM:ScoreboardHide( )

	RAD.ContextEnabled = false;
	gui.EnableScreenClicker( false );
	HiddenButton:SetVisible( false );
	
end

function GM:StartChat( )

	LocalPlayer( ):ConCommand( "rp_openedchat" );
	
end

function GM:FinishChat( )

	LocalPlayer( ):ConCommand( "rp_closedchat" );
	
end
