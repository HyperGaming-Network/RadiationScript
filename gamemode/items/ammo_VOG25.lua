ITEM.Name = "VOG-25  Grenade(2x)";
ITEM.Class = "vog25";
ITEM.Description = "Groza Grenade Ammo (2x)";
ITEM.Model = "models/Items/AR2_Grenade.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 160;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)

	ply:GiveAmmo(2,"SMG1_Grenade");
    self:Remove();
end
