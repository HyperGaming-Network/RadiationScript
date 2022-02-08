ITEM.Name = "Radio";
ITEM.Class = "radiobox";
ITEM.Description = "It's a Music radio..";
ITEM.Model = "models/props_lab/citizenradio.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 2500;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me stares at the Radio");

end
