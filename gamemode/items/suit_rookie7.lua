ITEM.Name = "A rookie jacket";
ITEM.Class = "suit_rookie7";
ITEM.Description = "Offers no protection.";
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
	ply:SetModel("models/srp/rookie7.mdl");

ply:GetTable().ForceGive = false
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/rookie7.mdl") );				
end
