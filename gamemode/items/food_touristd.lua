ITEM.Name = "Tourist's Delight";
ITEM.Class = "tourist";
ITEM.Description = "Canned food from an army warehouse raided by stalkers. The best-before period hasn't expired yet.";
ITEM.Model = "models/props_junk/garbage_metalcan001a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 320;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetHealth(math.Clamp(ply:Health() + 15, 0, ply:MaxHealth()));
	self:Remove();

end
