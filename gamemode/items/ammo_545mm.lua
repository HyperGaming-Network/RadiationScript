ITEM.Name = "5.45x39(60x)";
ITEM.Class = "545";
ITEM.Description = "Standard Round for Ak74 and Obokan Assualt Rifle";
ITEM.Model = "models/Items/BoxMRounds.mdl";
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

	ply:GiveAmmo(60,"smg1");
    self:Remove();
end
