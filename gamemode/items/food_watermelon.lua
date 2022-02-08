ITEM.Name = "USB data on weapon modifications.";
ITEM.Class = "watermelon";
ITEM.Description = "Take this to the trader...";
ITEM.Model = "models/alyx_EmpTool_prop.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 5000;
ITEM.ItemGroup = 6;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	self:Remove();

end
