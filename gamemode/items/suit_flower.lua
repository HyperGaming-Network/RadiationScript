ITEM.Name = "Flower Suit";
ITEM.Class = "suit_flower";
ITEM.Description = "An experimental Exo that was put through the same process used to create Stone Flowers.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 250000;
ITEM.ItemGroup = 50;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/mastermercenary.mdl");
ply:SetColor( 247, 242, 164, 255 )
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = 1.5
ply:GetTable().BurnScale = 1.24
ply:GetTable().AcidScale = 1.24
ply:GetTable().PsiScale = 1.24
ply:GetTable().DmgScale = .25
ply:GetTable().RadiationScale = .3
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/mastermercenary.mdl") );				
end
