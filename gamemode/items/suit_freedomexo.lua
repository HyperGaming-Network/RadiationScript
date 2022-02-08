ITEM.Name = "Freedom Exoskeleton";
ITEM.Class = "suit_freedomexo";
ITEM.Description = "The exoskeleton used by the faction FREEDOM.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 100000;
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
	ply:SetModel("models/srp/masterfreedom.mdl");

ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .77
ply:GetTable().BurnScale = .77
ply:GetTable().AcidScale = .77
ply:GetTable().PsiScale = .77
ply:GetTable().DmgScale = .25
ply:GetTable().RadiationScale = .77
ply:GetTable().ArtifactSlots = 3
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/masterfreedom.mdl") );	
end
