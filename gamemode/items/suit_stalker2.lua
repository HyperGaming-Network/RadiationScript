ITEM.Name = "Stalker Suit";
ITEM.Class = "suit_stalker";
ITEM.Description = "Stalker suit manufactured by folk craftsmen. It is an effective combination of a light military bulletproof vest and of a rubberized fabric suit.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 20000;
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
	ply:SetModel("models/srp/stalker_bes.mdl");
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .5
ply:GetTable().BurnScale = .5
ply:GetTable().AcidScale = .5
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = .65
ply:GetTable().RadiationScale = .5
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_bes.mdl") );			
end
