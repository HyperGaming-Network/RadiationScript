ITEM.Name = "Petrol Can";
ITEM.Class = "pcan";
ITEM.Description = "Contains Petrol...";
ITEM.Model = "models/srp/props/kahuctpa.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 400;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

end
