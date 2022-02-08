ITEM.Name = "Premium Cigarettes";
ITEM.Class = "cigbox";
ITEM.Description = "One cigarette Left.";
ITEM.Model = "models/closedboxshib.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 70;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me smokes a box of cigarettes");
	self:Remove();

end
