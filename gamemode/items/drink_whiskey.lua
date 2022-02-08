ITEM.Name = "Box'o'cigs";
ITEM.Class = "cigarettes";
ITEM.Description = "Some old cigarettes.";
ITEM.Model = "models/props_lab/box01a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 70;
ITEM.ItemGroup = 6;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me smokes a cigarette");
	self:Remove();

end
