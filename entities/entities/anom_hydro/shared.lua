ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Hydro"
ENT.Author			= "Last.Exile"

ENT.Spawnable			= false
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Color = Color( 255, 255, 255, 0 )
	
end


/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	self:DrawEntityOutline( 1 )
	self.Entity:DrawModel()

end

