ITEM.Name = "Mp5 Sub-Machine Gun";
ITEM.Class = "mp5FRE";
ITEM.Description = "Mp5 Sub-Machine Gun\nHigh Rate of Fire/n Accurate/Weak";
ITEM.Model = "models/srp/weapons/w_mp5.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 800;
ITEM.ItemGroup = 19;
ITEM.ItemTakeOnUse = false
ITEM.IsPrimaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end