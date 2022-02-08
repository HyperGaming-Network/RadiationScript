ITEM.Name = "A upgraded ak";
ITEM.Class = "weapon_breachingshotgun";
ITEM.Description = "More ammo,More damage,slower.";
ITEM.Model = "models/srp/weapons/w_ak74.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 25000;
ITEM.ItemGroup = 5;

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
	ply:Give("UpgradedAk");
	self:Remove();
ply:GetTable().ForceGive = false
end
