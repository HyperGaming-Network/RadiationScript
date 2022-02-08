ITEM.Name = "SPAS 12 Shotgun";
ITEM.Class = "spas12";
ITEM.Description = "SPAS 12 Shotgun\nStrong/Accurate Boomstick\nCertain Death at Close Range";
ITEM.Model = "models/srp/weapons/w_spas12.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 2000;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false
ITEM.IsPrimaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end