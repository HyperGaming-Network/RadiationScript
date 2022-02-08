ITEM.Name = "Makarov PM";
ITEM.Class = "makarovDUTY";
ITEM.Description = "Makarov Pistol\nSemi-Automatic\nWeak";
ITEM.Model = "models/srp/weapons/w_makarov.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 350;
ITEM.ItemGroup = 18;
ITEM.ItemTakeOnUse = false
ITEM.IsSecondaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end