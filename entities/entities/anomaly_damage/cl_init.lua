
ENT.Spawnable			= false
ENT.AdminSpawnable		= true

include('shared.lua')

language.Add( "anomaly_damage", "Anomaly" )
language.Add( "point_hurt", "Anomaly" )


-- I willingly admit I borrowed this from Conna's gmod_anomaly entity, because I don't know jack squat about render binds.

// Material

local Heatwave = Material("effects/strider_bulge_dudv")

// Draw

function ENT:Draw()

	--print(self.PulseMultiplier)
	--print(self.BaseScale)
	local pulse = math.sin(CurTime())*self.PulseMultiplier
	local Size = self.BaseScale+pulse
	--print(Size)
	if Size < 0 then
		Size = 0.01
	end
	--print(newscale)
	
	render.UpdateScreenEffectTexture()
	
	render.SetMaterial(Heatwave)
	
	if (render.GetDXLevel() >= 90) then
		render.DrawSprite(self.Entity:GetPos(), Size, Size, Color(255, 0, 0, 25))
	end
	
	--self.Entity:DrawModel()
end