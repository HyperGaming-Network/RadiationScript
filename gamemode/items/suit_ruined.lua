ITEM.Name = "Ruined Jacket";
ITEM.Class = "suit_ruined";
ITEM.Description = "A jacket left for FAR to long in a Burnt Fuzz.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = false;
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
	ply:SetModel("models/srpmodels/loner3.mdl");
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .9
ply:GetTable().BurnScale = .9
ply:GetTable().AcidScale = .9
ply:GetTable().PsiScale = .9
ply:GetTable().DmgScale = 2
ply:GetTable().RadiationScale = 0.05
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srpmodels/loner3.mdl") );				
end
