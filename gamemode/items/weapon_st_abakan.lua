ITEM.Name = "AN-94 Abakan";
ITEM.Class = "abakan";
ITEM.Description = "AN-94 Abakan Rifle\nBest Accuracy of AK series\nMedium Stopping Power";
ITEM.Model = "models/srp/weapons/w_abakan.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 2500;
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