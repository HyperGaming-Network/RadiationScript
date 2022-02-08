ITEM.Name = "Mail Jacket";
ITEM.Class = "suit_mail";
ITEM.Description = "An upgraded Bandit Jacket with mail plates sewn into it.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 10000;
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
	ply:SetModel("models/srp/bandit2.mdl");

ply:GetTable().ForceGive = false
ply:GetTable().ElectricScale = .9
ply:GetTable().BurnScale = .9
ply:GetTable().AcidScale = .9
ply:GetTable().PsiScale = .9
ply:GetTable().DmgScale = .75
ply:GetTable().RadiationScale = .9
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/bandit2.mdl") );		
end

