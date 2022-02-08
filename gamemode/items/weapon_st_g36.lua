ITEM.Name = "G36 Scoped-Rifle";
ITEM.Class = "g36";
ITEM.Description = "G36 Scoped-Rifle\nMedium Accuracy\nMedium Stopping Power";
ITEM.Model = "models/srp/weapons/w_g36.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 18000;
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