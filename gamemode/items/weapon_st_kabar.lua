ITEM.Name = "Kabar";
ITEM.Class = "kabar";
ITEM.Description = "A Stalkers Best Friend";
ITEM.Model = "models/srp/weapons/w_kabar.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 120;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
	ply:Give("kabar");
	self:Remove();
ply:GetTable().ForceGive = false
end
