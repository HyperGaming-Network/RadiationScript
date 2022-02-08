ITEM.Name = "AN-94 Abakan";
ITEM.Class = "abakanMILL";
ITEM.Description = "AN-94 Abakan Rifle\nBest Accuracy of AK series\nMedium Stopping Power";
ITEM.Model = "models/srp/weapons/w_abakan.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 3000;
ITEM.ItemGroup = 20;
ITEM.ItemTakeOnUse = false
ITEM.IsPrimaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end