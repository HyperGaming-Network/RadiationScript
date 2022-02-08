ITEM.Name = "M1911A1";
ITEM.Class = "1911";
ITEM.Description = "M1911A1 Pistol\n.45 Caliber\nHigh Stopping Power";
ITEM.Model = "models/srp/weapons/w_1911.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 900;
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
