include('shared.lua')
artifactmodels = {
"models/srp/items/art_battery.mdl",
"models/srp/items/art_crystal.mdl",
"models/srp/items/art_crystalthorn.mdl",
"models/srp/items/art_droplet.mdl",
"models/srp/items/art_fireball.mdl",
"models/srp/items/art_goldfish.mdl",
"models/srp/items/art_flash.mdl",
"models/srp/items/art_goldfish.mdl",
"models/srp/items/art_gravi.mdl",
"models/srp/items/art_jellyfish.mdl",
"models/srp/items/art_mammasbeads.mdl",
"models/srp/items/art_meatchunk.mdl",
"models/srp/items/art_mica.mdl",
"models/srp/items/art_moonlight.mdl",
"models/srp/items/art_nightstar.mdl",
"models/srp/items/art_slime.mdl",
"models/srp/items/art_slug.mdl",
 "models/srp/items/art_soul.mdl",
"models/srp/items/art_spring.mdl",
"models/srp/items/art_sparkler.mdl",
"models/srp/items/art_stoneblood.mdl",
"models/srp/items/art_stoneflower.mdl",
"models/srp/items/art_thorn.mdl",
"models/srp/items/art_urchen.mdl",
"models/srp/items/art_wrenched.mdl"
}

function ENT:Draw()
dist = LocalPlayer():GetPos()

	if( self.Entity:GetTable().isartifact == true ) then
	//	if( HasDetector == True ) then
		if( dist:Distance( self.Entity:GetPos() ) < 100 ) then
			self:DrawEntityOutline(0.0)
			self.Entity:DrawModel()
		else
			return false;
		end
	//	end
	else
		self:DrawEntityOutline(0.0)
		self.Entity:DrawModel()
	end

end


function ENT:Initialize()
self.Entity:GetTable().isartifact = false
 //timer.Simple(5, function()
for k,v in pairs( artifactmodels ) do
	if( self.Entity:GetModel() == v ) then
self.Entity:GetTable().isartifact = true
end
end
end
// , self.Entity ) 
//end

