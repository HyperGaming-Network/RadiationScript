AddCSLuaFile( "shared.lua" )
include('shared.lua')

/*---------------------------------------------------------
   Name: Spawn Function
---------------------------------------------------------*/

function ENT:SpawnFunction( ply, tr )
    --If it didn't hit something...
 	if ( !tr.Hit ) then return end 
 	 
 	local Pos = tr.HitPos + tr.HitNormal * 90 
 	 
 	local ent = ents.Create( "anom_electro" )
	ent:SetPos( Pos ) 
 	ent:Spawn()
 	ent:Activate() 	 
	return ent 
 	 
end

/*---------------------------------------------------------
   Name: Int
---------------------------------------------------------*/

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_VPHYSICS ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150") 
	self.Entity:SetKeyValue("renderamt", "0") 
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")

        local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end


/*---------------------------------------------------------
   Name: Think
---------------------------------------------------------*/

function ENT:Think()

local brange = math.random( 64, 350 )
	local b = ents.Create( "point_hurt" )
	b:SetKeyValue("targetname", "pointhurtfire" ) 
	b:SetKeyValue("DamageRadius", brange )
	b:SetKeyValue("Damage",  math.random( 11, 19 ) )
	b:SetKeyValue("DamageDelay", "5" )
	b:SetKeyValue("DamageType", "256" ) // shock
	b:SetPos( self.Entity:GetPos() )
	b:Spawn()
	b:Fire("turnon", "", 0)
	b:Fire("turnoff", "", 1)
	b:Fire("kill", "", 1)
	
	local tesla = ents.Create( "point_tesla" )
	--Set the tesla's pos
	tesla:SetPos( self.Entity:GetPos() )
	--Own it and stuff.
	--Set key values
	tesla:SetKeyValue("targetname", "electroanom" ) 
	tesla:SetKeyValue("m_flRadius", "300" )
	tesla:SetKeyValue("m_SourceEntityName", "electroanom" )
	tesla:SetKeyValue("m_Color", "255 255 255" )
	tesla:SetKeyValue("beamcount_min", "4" )
	tesla:SetKeyValue("beamcount_max", "8" ) 
	tesla:SetKeyValue("texture", "sprites/physbeam.vmt" )
	tesla:SetKeyValue("thick_min", "6" )
	tesla:SetKeyValue("thick_max", "8" )
	tesla:SetKeyValue("lifetime_min", "0.3" )
	tesla:SetKeyValue("lifetime_max", "1" )
	tesla:SetKeyValue("interval_min", "0" )
	tesla:SetKeyValue("interval_max", "2" )
	
	--Spawn and activate it.
	tesla:Spawn()
	tesla:Activate()
	
	tesla:SetParent(self.Entity)
	tesla:SetOwner(self.Entity);
	--Turn it on.
	tesla:Fire("turnon", "", 0)
	self:EmitSound("hgn/stalker/anom/electra_idle1.wav", 80, 50)
	--Remove it after a second
	tesla:Fire("turnoff", "", 1)
	tesla:Fire("kill", "", 1)
	    for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 300 ) ) do	
	  	if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 400 ) then
	        if math.random(1,3)==3 then		
			self:EmitSound("hgn/stalker/anom/electra_blast1.mp3")
	

end	
end
end
end
/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


function ENT:KeyValue( key, value )

end

/*---------------------------------------------------------
   Name: OnTakeDamage
   Desc: Entity takes damage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )

end


/*---------------------------------------------------------
   Name: StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
   Name: EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
   Name: Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
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
