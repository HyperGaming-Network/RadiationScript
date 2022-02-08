ITEM.Name = "AK-74M";
ITEM.Class = "ak74DUTY";
ITEM.Description = "AK-74M\nMost Well Rounded Rifle in the AK Series\nMedium Stopping power";
ITEM.Model = "models/srp/weapons/w_ak74.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 2500;
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