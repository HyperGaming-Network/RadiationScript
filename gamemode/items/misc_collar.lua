ITEM.Name = "Collar";
ITEM.Class = "Collar";
ITEM.Description = "Can be put on something...";
ITEM.Model = "models/Gibs/metal_gib1.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 150;
ITEM.ItemGroup = 51;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me stares at the Collar");

end
