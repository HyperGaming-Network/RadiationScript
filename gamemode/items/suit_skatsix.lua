ITEM.Name = "Skat 6 Military suit";
ITEM.Class = "suit_skat";
ITEM.Description = "The skat6 Suit used by military.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 75000;
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
	ply:SetModel("models/srp/stalker_mili.mdl");
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .7
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .7
ply:GetTable().PsiScale = .7
ply:GetTable().DmgScale = .3
ply:GetTable().RadiationScale = .7
ply:GetTable().ArtifactSlots = 3
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_mili.mdl") );				
end
