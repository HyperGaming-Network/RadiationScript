ITEM.Name = "5.56x39(60x)";
ITEM.Class = "556";
ITEM.Description = "Standard for the IL 86, the TRs 301 the SGI 5k, the GP 37 and the FT 200M assault rifles ";
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

	ply:GiveAmmo(60,"ar2");
    self:Remove();
end
