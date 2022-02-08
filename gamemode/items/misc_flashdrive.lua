ITEM.Name = "Flash Drive";
ITEM.Class = "flashdrive";
ITEM.Description = "Flash drive - convenient way to store and transfer information.";
ITEM.Model = "models/dean/usb_closed.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 600;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

end
