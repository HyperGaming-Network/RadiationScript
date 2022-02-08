ITEM.Name = "OC-14 Groza Rifle";
ITEM.Class = "groza";
ITEM.Description = "OC-14 Groza Rifle\Multiple Rates of Fire/Low/Meduim Accuracy\nHigh Stopping Power";
ITEM.Model = "models/srp/weapons/w_groza.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 10000;
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