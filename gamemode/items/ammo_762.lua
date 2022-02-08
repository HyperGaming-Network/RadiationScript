ITEM.Name = "7.62x54(30x)";
ITEM.Class = "762";
ITEM.Description = "Standard Round for the SVD and SVU.";
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

	ply:GiveAmmo(30,"StriderMinigun");
    self:Remove();
end
