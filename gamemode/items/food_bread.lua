ITEM.Name = "Bread";
ITEM.Class = "bread";
ITEM.Description = "Hard to say who manages to bake these loaves in the Zone, but the bread isn't contaminated and is perfectly edible. Well, at least none of the stalkers have complained about it.";
ITEM.Model = "models/Bread/bread.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 180;
ITEM.ItemGroup = 6;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetHealth(math.Clamp(ply:Health() + 5, 0, ply:MaxHealth()));
	self:Remove();

end
