ITEM.Name = "Milk Jug";
ITEM.Class = "milkjug";
ITEM.Description = "I doubt this is cow milk.";
ITEM.Model = "models/props_junk/garbage_milkcarton001a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 4;
ITEM.ItemGroup = 6;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetHealth(math.Clamp(ply:Health() + 10, 0, ply:MaxHealth()));
	self:Remove();

end
