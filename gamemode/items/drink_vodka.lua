ITEM.Name = "Cossacks Vodka";
ITEM.Class = "vodka";
ITEM.Description = "Vodka made by the GSC company. Goes down easily and significantly reduces the effects of radiation, but for obvious reasons should be enjoyed in moderation.";
ITEM.Model = "models/props_junk/GlassBottle01a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 20;
ITEM.ItemGroup = 6;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetHealth(math.Clamp(ply:Health() + 25, 0, ply:MaxHealth()));
	self:Remove();

end
