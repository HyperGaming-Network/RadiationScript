AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	
	local ent = ents.Create( "anom_punch" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
		local lamp = ents.Create( "gmod_light" )
		
			if (!lamp:IsValid()) then return end
		
			lamp:SetLightColor( 242, 233, 63 )
			lamp:SetBrightness( brght )
			lamp:SetLightSize( size )
		lamp:Spawn()
		lamp:SetPos( SpawnPos )
		lamp.lightr = 242
		lamp.lightg = 233
		lamp.lightb = 63
		lamp.lighta = 0
		lamp.Brightness  = 1
		lamp.Size = 400
		lamp:SetColor(242, 233, 63,0) 
		lamp:SetMoveType(MOVETYPE_NONE)
	return ent
	
end

function MakeSprite( Entity, fx, color, spritePath, scale, transity)
/*
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
*/
end 

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Entity:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	 
	local phys = self.Entity:GetPhysicsObject()
	
		  if (phys:IsValid()) then
			phys:EnableMotion(false)
		  end
	self.Entity:SetKeyValue("rendercolor", "255 150 150") 
	self.Entity:SetKeyValue("renderamt", "225") 
	//self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:SetNoDraw( true )
//	MakeSprite( self.Entity, "15", "150 100 100", "sprites/glow1.vmt", "10", "255")
	//MakeSprite( self.Entity, "23", "250 250 250", "sprites/glow1.vmt", "5", "150")
	
/*	local fire = ents.Create("env_fire_trail")
	fire:SetKeyValue("firesprite", "sprites/whitepuff.spr" )
	fire:SetKeyValue("spawnrate", "9")
	fire:SetKeyValue("spawnradius", "9999999" )
	fire:SetKeyValue("opacity", "0.5" )
	fire:SetKeyValue("endsize", "9999999" )
	fire:SetKeyValue("startcolor", "100 100 100" )
	fire:SetKeyValue("endcolor", "255 255 255" )
	fire:SetKeyValue("lifetime", "7.0" )
	fire:SetKeyValue("firesprite", "sprites/firetrail.spr" )
	
	fire:SetPos(self.Entity:GetPos())
	fire:Spawn()
	fire:SetParent(self.Entity)
	
	local light = ents.Create("env_lightglow")
	light:SetPos(self.Entity:GetPos())
	light:SetKeyValue("targetname", "moo")
	light:SetKeyValue("rendercolor", "255 255 255")
	light:SetKeyValue("VerticalGlowSize", "25")
	light:SetKeyValue("HorizontalGlowSize", "25")
	light:Spawn()
	light:SetParent(self.Entity)
*/
end

function distort(ent, pos)
/*
local gas = ents.Create("env_smokestack")
gas:SetPos(pos)
gas:SetKeyValue("InitialState", "1")
gas:SetKeyValue("BaseSpread", "1")
gas:SetKeyValue("SpreadSpeed", "5")
gas:SetKeyValue("Speed", "5")
gas:SetKeyValue("StartSize", "100")
gas:SetKeyValue("EndSize", "2500")
gas:SetKeyValue("Rate", "5")
gas:SetKeyValue("JetLength", "50")
gas:SetKeyValue("SmokeMaterial", "sprites/heatwave.vmt")
gas:Spawn()
gas:SetParent(ent)
gas:Fire("turnon", "", 0)
gas:Fire("turnoff", "", 1.5)
gas:Fire("kill", "", 1)
*/
//local vPoint = Vector(0,0,0)
local effectdata = EffectData()
effectdata:SetStart( pos ) // not sure if we need a start and origin (endpoint) for this effect, but whatever
effectdata:SetOrigin( pos )
effectdata:SetScale( 1 )
util.Effect( "anom_punchpart", effectdata )	
end

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

function ENT:Think()

//	local brange = math.random( 64, 128 )
	local b = ents.Create( "point_hurt" )
	b:SetKeyValue("targetname", "fier" ) 
	b:SetKeyValue("DamageRadius", 128 )
	b:SetKeyValue("Damage", "20" )
	b:SetKeyValue("DamageDelay", "5" )
	b:SetKeyValue("DamageType", "1048576" )
	b:SetPos( self.Entity:GetPos() )
	b:Spawn()
	b:Fire("turnon", "", 0)
	b:Fire("turnoff", "", 1)
	b:Fire("kill", "", 1)
	
	distort(self.Entity, self.Entity:GetPos())
	
end

