ITEM.Name = "PSZ-9d Duty Armor Variant2";
ITEM.Class = "suit_duty3";
ITEM.Description = "The Standard Duty Suit.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 250;
ITEM.ItemGroup = 18;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/stalker_hood_duty.mdl");
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .75
ply:GetTable().BurnScale = .75
ply:GetTable().AcidScale = .75
ply:GetTable().PsiScale = .75
ply:GetTable().DmgScale = .4
ply:GetTable().RadiationScale = .75
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_hood_duty.mdl") );			
end
