ITEM.Name = "Fort 12";
ITEM.Class = "fort12";
ITEM.Description = "Fort 12 Hand-Gun\nLarger than Norm. Mag. Capacity\nWeak";
ITEM.Model = "models/srp/weapons/w_fort12.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 350;
ITEM.ItemGroup = 19;
ITEM.ItemTakeOnUse = false
ITEM.IsSecondaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end