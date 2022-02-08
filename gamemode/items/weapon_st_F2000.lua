ITEM.Name = "F2000 Scoped-Rifle";
ITEM.Class = "f2000";
ITEM.Description = "F2000 Scoped-Rifle\nMedium Long Range Accuracy/High Rate of Fire\nLow-Meduim Stopping Power";
ITEM.Model = "models/srp/weapons/w_fn2000.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 17000;
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