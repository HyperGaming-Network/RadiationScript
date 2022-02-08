ITEM.Name = "LR300 Rifle";
ITEM.Class = "lr300";
ITEM.Description = "LR300 Rifle\nFastest Firing Rate of Any Weapon/n Extremely Accurate";
ITEM.Model = "models/srp/weapons/w_lr300.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 5000;
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