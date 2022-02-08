ITEM.Name = "Dog Meat";
ITEM.Class = "dogmeat";
ITEM.Description = "Not sure what it was...";
ITEM.Model = "models/Gibs/Antlion_gib_small_2.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 15;
ITEM.ItemGroup = 51;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me eats some meat");
	self:Remove();

end
