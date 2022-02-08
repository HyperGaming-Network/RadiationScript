ITEM.Name = "Bandit Jacket 4";
ITEM.Class = "suit_bandit4";
ITEM.Description = "Black Bandit Jacket";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1000;
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
	ply:SetModel("models/srp/bandit4.mdl");

ply:GetTable().ForceGive = false
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/bandit4.mdl") );		
end
