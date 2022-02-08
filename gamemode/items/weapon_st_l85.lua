ITEM.Name = "L85 Assault Rifle ";
ITEM.Class = "l85";
ITEM.Description = "L85 Assault Rifle \nHigh Rate of Fire/n Accurate/Strong";
ITEM.Model = "models/srp/weapons/w_l85.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 6000;
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