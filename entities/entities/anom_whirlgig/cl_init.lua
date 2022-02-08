
include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/

local Heatwave = Material("effects/strider_bulge_dudv")
local Size = 100

function ENT:Draw()

        self.Entity:DrawModel()
	
	render.UpdateScreenEffectTexture()
	
	render.SetMaterial(Heatwave)
	
	if (render.GetDXLevel() >= 90) then
		render.DrawSprite(self.Entity:GetPos(), Size, Size, Color(255, 0, 0, 25))
	end
end 
	



/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return false
end

