ITEM.Name = "Vial";
ITEM.Class = "vial";
ITEM.Description = "Restores about 25% of your health";
ITEM.Model = "models/healthvial.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 45;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetHealth(math.Clamp(ply:Health() + 25, 0, ply:MaxHealth()));
	ply:ConCommand("say /me heals himself ");
	self:Remove();

end
