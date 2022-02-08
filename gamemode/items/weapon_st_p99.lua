ITEM.Name = "Walther P99";
ITEM.Class = "p99";
ITEM.Description = "Walther P99 Hand-Gun\nAccurate/n Medium-High Stopping Power";
ITEM.Model = "models/srp/weapons/w_p99.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 800;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false
ITEM.IsSecondaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end