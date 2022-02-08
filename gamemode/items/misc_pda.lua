ITEM.Name = "Personal Digital Assistant";
ITEM.Class = "pda";
ITEM.Description = "Something Every Stalker Needs";
ITEM.Model = "models/props_lab/reciever01d.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 500;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me observes the PDA");

end
