ITEM.Name = "Rusty Crowbar";
ITEM.Class = "weapon_crowbar";
ITEM.Description = "Used often by zombies";
ITEM.Model = "models/weapons/w_crowbar.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 50;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
	ply:Give("weapon_crowbar");
	self:Remove();
ply:GetTable().ForceGive = false
end
