ITEM.Name = "FlashLight";
ITEM.Class = "flashlight";
ITEM.Description = "Solar Battery Powered FlashLight";
ITEM.Model = "models/weapons/W_stunbaton.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 250;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

end
