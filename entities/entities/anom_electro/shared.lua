ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Electro Anomoly"
ENT.Author			= "Last.Exile"
ENT.Contact			= "HGN"
ENT.Category 		= "HGN S.T.A.L.K.E.R RP"

ENT.Spawnable			= false
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	self.Entity:DrawModel()
end


/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return false
end

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
