ITEM.Name = "VSS Vintorez Sniper Rifle";
ITEM.Class = "vintorez";
ITEM.Description = "Vintovka Snayperskaya Spetsialnaya";
ITEM.Model = "models/srp/weapons/w_vintorez.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 12000;
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