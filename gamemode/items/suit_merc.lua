ITEM.Name = "Merc Suit";
ITEM.Class = "suit_merc";
ITEM.Description = "Stalker suit from the Merc faction. Its design is based on the suit used by the special forces of the Western armies.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 13000;
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
	ply:SetModel("models/srp/stalker_antigas_killer.mdl");

ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .8
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .7
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = .75
ply:GetTable().RadiationScale = .7
ply:GetTable().ArtifactSlots = 3
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_antigas_killer.mdl") );			
end
