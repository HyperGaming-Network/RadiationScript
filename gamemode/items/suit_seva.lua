ITEM.Name = "SEVA suit";
ITEM.Class = "suit_seva";
ITEM.Description = "A fantastic suit.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 40000;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/bio_suit.mdl");
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .4
ply:GetTable().BurnScale = .4
ply:GetTable().AcidScale = .4
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = .75
ply:GetTable().RadiationScale = .4
ply:GetTable().ArtifactSlots = 3
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/bio_suit.mdl") );				
end
