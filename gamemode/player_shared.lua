-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- player_shared.lua
-- This is a shared file that contains functions for the players, of which is loaded on client and server.
-------------------------------

local meta = FindMetaTable( "Player" );

function meta:CanTraceTo( ent ) -- Can the player and the entity "see" eachother?

	local trace = {  }
	trace.start = self:EyePos( );
	trace.endpos = ent:EyePos( );
	trace.filter = self;
	
	local tr = util.TraceLine( trace );
	
	if( tr.Entity:IsValid( ) and tr.Entity:EntIndex( ) == ent:EntIndex( ) ) then return true; end
	
	return false;

end

function meta:Nick( )
	
	return self:GetNWString( "name" );

end

function meta:CalcDrop( )

	local pos = self:GetShootPos( );
	local ang = self:GetAimVector( );
	local tracedata = {  };
	tracedata.start = pos;
	tracedata.endpos = pos+( ang*80 );
	tracedata.filter = self;
	local trace = util.TraceLine( tracedata );
	
	return trace.HitPos;
	
end

function meta:CanTraceToSky() -- Perform the trace 

	local tr = {} 
	tr.start = self:GetPos() 
	tr.endpos = self:GetPos() + Vector(0, 0, 10000) 
	tr.filter = self
	trace = util.TraceLine(tr) -- Return result 
   
	return trace.HitSky   --If it hits skybox, then he is outside

end 


	
