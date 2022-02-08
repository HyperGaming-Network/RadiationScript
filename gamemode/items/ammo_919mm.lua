ITEM.Name = "9x19mm Ammo (x25)";
ITEM.Class = "919";
ITEM.Description = "A standard round for the Walker P9m Pistol and the Viper 5 Submachine Gun";
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

	ply:GiveAmmo(25,"XBowBolt");
    self:Remove();
end
