ITEM.Name = "Radio";
ITEM.Class = "radio";
ITEM.Description = "It's a Hand Held radio..";
ITEM.Model = "models/Items/combine_rifle_cartridge01.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1000;
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
