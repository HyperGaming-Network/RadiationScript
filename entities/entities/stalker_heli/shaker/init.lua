AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self.MaxMagnitude = 70
	util.PrecacheModel("models/props_junk/watermelon01.mdl")
    self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )
    self.Entity:PhysicsInit( SOLID_VPHYSICS )
    self.Entity:SetMoveType(  MOVETYPE_VPHYSICS )   
    self.Entity:SetSolid( SOLID_VPHYSICS )
 
    self.PhysObj = self.Entity:GetPhysicsObject()
    if (self.PhysObj:IsValid()) then
		self.PhysObj:EnableGravity( true )
		self.PhysObj:EnableDrag( true ) 
		self.PhysObj:SetMass(30)
        self.PhysObj:Wake()

    end  
end
 
function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "shaker" )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:Activate()
		ent:SetColor(255, 255, 255, 255)
	return ent
end

function ENT:Think() 
local maxmag = self.MaxMagnitude
local magnitude = math.random(5, maxmag)
		local shake = ents.Create("env_shake")
		shake:SetKeyValue("amplitude", magnitude)
		shake:SetKeyValue("duration", 1)
		shake:SetKeyValue("radius", 60000) 
		shake:SetKeyValue("frequency", 230)
		shake:SetPos(self:GetPos())
		shake:Spawn()
		shake:Fire("StartShake","","0.6")
end

function ENT:OnRemove()

end

