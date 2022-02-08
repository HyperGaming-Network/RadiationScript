ITEM.Name = "Coyote Suit";
ITEM.Class = "suit_coyote9521";
ITEM.Description = "A loner suit left in a Vortex and Electro";
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
// ply:SetColor( 220, 220, 120, 255 )
ply:GetTable().ElectricScale = .9
ply:GetTable().BurnScale = .9
ply:GetTable().AcidScale = .9
ply:GetTable().PsiScale = .9
ply:GetTable().DmgScale = .5
ply:GetTable().RadiationScale = .9
ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain - .073
// ply:GetTable().HealthRecov = ply:GetTable().HealthRecov + 9
ply:GetTable().ArtifactSlots = 4
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srpmodels/loner3.mdl") );				
end
