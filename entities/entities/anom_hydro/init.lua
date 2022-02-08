AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 64
	
	local ent = ents.Create( "anom_hydro" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( Angle(0,0,-180) )
	ent:Spawn()
	ent:Activate()

	return ent
	
end

function MakeSprite( Entity, fx, color, spritePath, scale, transity)
local Sprite = ents.Create("env_sprite");
Sprite:SetPos( Entity:GetPos() );
Sprite:SetKeyValue( "renderfx", fx )
Sprite:SetKeyValue( "model", spritePath)
Sprite:SetKeyValue( "scale", scale)
Sprite:SetKeyValue( "spawnflags", "1")
Sprite:SetKeyValue( "angles", "0 0 0")
Sprite:SetKeyValue( "rendermode", "9")
Sprite:SetKeyValue( "renderamt", transity)
Sprite:SetKeyValue( "rendercolor", color )

Sprite:Spawn()
Sprite:Activate()
Sprite:SetParent( Entity )

end 

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Entity:SetModel( "models/props_borealis/bluebarrel001.mdl" )
	self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	 
	local phys = self.Entity:GetPhysicsObject()
	
		  if (phys:IsValid()) then
			phys:EnableMotion(false)
		  end
	self.Entity:SetKeyValue("rendercolor", "150 150 255") 
	self.Entity:SetKeyValue("renderamt", "0") 
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	MakeSprite( self.Entity, "15", "100 100 240", "sprites/glow1.vmt", "10", "255")
	MakeSprite( self.Entity, "23", "250 250 250", "sprites/glow1.vmt", "5", "150")
	distort(self.Entity, self.Entity:GetPos())
end

--function distort(ent, pos)
--local gas = ents.Create("env_smokestack")
--gas:SetPos(pos)
--gas:SetKeyValue("InitialState", "1")
--gas:SetKeyValue("BaseSpread", "1")
--gas:SetKeyValue("SpreadSpeed", "5")
--gas:SetKeyValue("Speed", "5")
--gas:SetKeyValue("StartSize", "100")
--gas:SetKeyValue("EndSize", "2500")
--gas:SetKeyValue("Rate", "5")
--gas:SetKeyValue("JetLength", "50")
--gas:SetKeyValue("SmokeMaterial", "sprites/heatwave.vmt")
--gas:Spawn()
--gas:SetParent(ent)
--gas:Fire("turnon", "", 0)
--end

/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )

	// React physically when shot/getting blown
	self.Entity:TakePhysicsDamage( dmginfo )
	
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use( activator, caller )

	self.Entity:Remove()
	
	if ( activator:IsPlayer() ) then
	

	end

end

function ENT:Think( )
	
	local harange = math.random( 64, 1024 )
	local b = ents.Create( "point_hurt" )
	b:SetKeyValue("targetname", "fier" ) 
	b:SetKeyValue("DamageRadius", harange )
	b:SetKeyValue("Damage", "5" )
	b:SetKeyValue("DamageDelay", "10" )
	b:SetKeyValue("DamageType", "0" ) // general, being used for radiation
	b:SetPos( self.Entity:GetPos() )
	b:Spawn()
	b:Fire("turnon", "", 0)
	b:Fire("turnoff", "", 1)
	b:Fire("kill", "", 1)
	
end


