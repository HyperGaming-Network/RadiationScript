ITEM.Name = "9x18mm Ammo (x25)";
ITEM.Class = "918";
ITEM.Description = "Standard for PMm, PB1s and Fort12 Pistols.";
ITEM.Model = "models/Items/BoxSRounds.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 30;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)

	ply:GiveAmmo(25,"pistol");
    self:Remove();
end
