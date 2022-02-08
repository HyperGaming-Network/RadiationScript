ITEM.Name = "SSP-99 Chemical Protection Suit";
ITEM.Class = "suit_chem";
ITEM.Description = "Used by Ecologists and Eco-Stalkers, offers almost no bullet protection.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 15000;
ITEM.ItemGroup = 17;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/bio_mono.mdl");
ply:SetColor( 255, 82, 0, 255 )
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .1
ply:GetTable().BurnScale = .1
ply:GetTable().AcidScale = .1
ply:GetTable().PsiScale = .1
ply:GetTable().DmgScale = .8
ply:GetTable().RadiationScale = .3
ply:GetTable().ArtifactSlots = 1
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/bio_mono.mdl") );				
end

