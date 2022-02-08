ITEM.Name = "AK-47";
ITEM.Class = "ak47";
ITEM.Description = "AK-47M\nMost Well Rounded Rifle in the AK Series\nMedium Stopping power";
ITEM.Model = "models/weapons/w_rif_ak47.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 4000;
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