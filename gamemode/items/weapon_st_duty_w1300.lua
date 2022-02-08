ITEM.Name = "Mossberg 500 Shotgun";
ITEM.Class = "w1300DUTY";
ITEM.Description = "Mossberg 500 Shotgun\nStronger/Less Accurate then the SPAS\nPump-Action";
ITEM.Model = "models/srp/weapons/w_w1300.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1000;
ITEM.ItemGroup = 18;
ITEM.ItemTakeOnUse = false
ITEM.IsPrimaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end