ITEM.Name = "Black Leather Coat";
ITEM.Class = "suit_ban1";
ITEM.Description = "Black leather Coat";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 4500;
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
	ply:SetModel("models/srp/stalker_bandit_veteran2.mdl");

ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .9
ply:GetTable().BurnScale = .9
ply:GetTable().AcidScale = .9
ply:GetTable().PsiScale = .9
ply:GetTable().DmgScale = .9
ply:GetTable().RadiationScale = .9
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_bandit_veteran2.mdl") );
end