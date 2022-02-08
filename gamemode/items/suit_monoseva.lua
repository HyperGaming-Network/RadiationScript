ITEM.Name = "Monolith SEVA suit";
ITEM.Class = "suit_monoseva";
ITEM.Description = "A fantastic suit.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 40000;
ITEM.ItemGroup = 21;
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
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .1
ply:GetTable().BurnScale = .2
ply:GetTable().AcidScale = .3
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = .4
ply:GetTable().RadiationScale = .1
ply:GetTable().ArtifactSlots = 3
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/bio_mono.mdl") );				
end
