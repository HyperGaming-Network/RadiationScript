ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Whirlgig"
ENT.Author			= "SilverKnight"
ENT.Contact			= "STALKER RP"
ENT.Category 		= "HGN S.T.A.L.K.E.R RP"

ENT.Spawnable			= false
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)

end
