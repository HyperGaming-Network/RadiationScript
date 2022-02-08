ITEM.Name = "Skull";
ITEM.Class = "skull";
ITEM.Description = "A Skull";
ITEM.Model = "models/Gibs/HGIBS.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 10;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	RAD.SendChat(ply, "Seems some poor bastard wasn't very lucky...");

end
