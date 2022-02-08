ITEM.Name = "Dog's Tail";
ITEM.Class = "dogtail";
ITEM.Description = "What happened to the dog?";
ITEM.Model = "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 200;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

RAD.SendChat(ply, "What the fuck did you expect? Animal Killer.");

end
