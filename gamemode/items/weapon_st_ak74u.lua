ITEM.Name = "AK74u";
ITEM.Class = "ak74u";
ITEM.Description = "AK-74u\nMost Well Rounded Rifle in the AK Series\nMedium Stopping power";
ITEM.Model = "models/srp/weapons/w_ak74u.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1000;
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