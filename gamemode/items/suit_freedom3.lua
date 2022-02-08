ITEM.Name = "Wind of Freedom Suit Variant 3";
ITEM.Class = "suit_freedom3";
ITEM.Description = "The Standard Freedom Suit.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 250;
ITEM.ItemGroup = 19;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/freedom/freedom.mdl");
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .5
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .5
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = .7
ply:GetTable().RadiationScale = .5
	self:Remove();
RAD.SetCharField(ply, "model",("models/freedom/freedom.mdl") );
end
