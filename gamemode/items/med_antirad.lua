ITEM.Name = "Antiradiation Drugs";
ITEM.Class = "antirad";
ITEM.Description = "Removes all radiation. Antiradiation Drugs are alot more expensive than Vodka, and also weighs less.";
ITEM.Model = "models/Items/battery.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1000;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

end
