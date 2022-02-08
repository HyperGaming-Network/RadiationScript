ITEM.Name = "12x70 Shot Rounds (12x)";
ITEM.Class = "12shot";
ITEM.Description = "12x70 Shot Rounds (12x)";
ITEM.Model = "models/Items/BoxBuckshot.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 25;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)

	ply:GiveAmmo(12,"buckshot");
    self:Remove();
end
