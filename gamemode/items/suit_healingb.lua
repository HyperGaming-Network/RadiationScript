ITEM.Name = "Healing Beril";
ITEM.Class = "suit_healingb";
ITEM.Description = "A Berill-5M Armoured Suit whose fabric is saturated with a streptozoidal lotion.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 100000;
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
	ply:SetModel("models/srp/specnaz.mdl");
ply:SetColor( 171, 222, 249, 255 )
ply:GetTable().HealthRecov = ply:GetTable().HealthRecov + 10
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .7
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .7
ply:GetTable().PsiScale = .7
ply:GetTable().DmgScale = .55
ply:GetTable().RadiationScale = 1.25
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/specnaz.mdl") );				
end

