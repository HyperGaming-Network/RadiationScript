ITEM.Name = "Documents";
ITEM.Class = "labdoc";
ITEM.Description = "This could be worth something...";
ITEM.Model = "models/props_lab/clipboard.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1500;
ITEM.ItemGroup = 51;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

end
