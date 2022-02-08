ITEM.Name = "9x39mm Ammo (x25)";
ITEM.Class = "39";
ITEM.Description = "Standard for The VSS Vintorez, AS VAL and Tunder S14 Weapons.";
ITEM.Model = "models/Items/BoxSRounds.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 70;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:GiveAmmo(25,"Slam");
    self:Remove();
end
