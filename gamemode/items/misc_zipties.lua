ITEM.Name = "Rope";
ITEM.Class = "zipties";
ITEM.Description = "Simple Rope, used for Hanging, Tieing and Knoting.";
ITEM.Model = "models/weapons/w_defuser.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 50;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
	ply:ConCommand("say /it looks like i could Tie someone up with this...");
end