ITEM.Name = "SVD Sniper Rifle";
ITEM.Class = "svd";
ITEM.Description = "SVD Sniper Rilfe\nStrong/Accurate Rifle\nDeadly at Medium-Long Ranges";
ITEM.Model = "models/srp/weapons/w_svd.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 15000;
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