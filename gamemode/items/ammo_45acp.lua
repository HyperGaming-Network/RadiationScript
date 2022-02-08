ITEM.Name = ".45ACP(16x)";
ITEM.Class = "45acp";
ITEM.Description = "Standard Round for Black Kite, Colt M1911, UDP Compact and SIP-t M200 pistols";
ITEM.Model = "models/Items/BoxMRounds.mdl";
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
	ply:GiveAmmo(16,"AirboatGun");
    self:Remove();
end
