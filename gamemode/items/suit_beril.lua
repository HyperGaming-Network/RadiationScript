ITEM.Name = "Berill-5M Armoured Suit";
ITEM.Class = "suit_berill";
ITEM.Description = "A Berill-5M special forces suit modified for the Zone environment.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 30000;
ITEM.ItemGroup = a;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/specnaz.mdl");
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .7
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .7
ply:GetTable().PsiScale = .7
ply:GetTable().DmgScale = .55
ply:GetTable().RadiationScale = .7
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/specnaz.mdl") );				
end

