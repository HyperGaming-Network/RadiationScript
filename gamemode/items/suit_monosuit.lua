ITEM.Name = "Monolith Suit";
ITEM.Class = "suit_monosuit";
ITEM.Description = "A suit resembling that of a Monolith's outfit.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1250;
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
	ply:SetModel("models/srp/stalker_hood_monolith.mdl");

ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .5
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .5
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = .7
ply:GetTable().RadiationScale = .5
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_hood_monolith.mdl") );					
end
