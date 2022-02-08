ITEM.Name = "Sig P220";
ITEM.Class = "p220";
ITEM.Description = "Sig P220 Hand-Gun\n.45 Caliber/Accurate/n High Stopping Power";
ITEM.Model = "models/srp/weapons/w_p220.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1200;
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