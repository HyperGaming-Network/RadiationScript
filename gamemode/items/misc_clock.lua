ITEM.Name = "Old Clock";
ITEM.Class = "clock";
ITEM.Description = "Doesn't tick anymore.";
ITEM.Model = "models/props_combine/breenclock.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 150;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me looks at the clock");

end
