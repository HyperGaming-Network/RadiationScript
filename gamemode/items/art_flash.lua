ITEM.Name = "flash";
ITEM.Class = "flash";
ITEM.Description = "I am bugged";
ITEM.Model = "models/srp/items/art_flash.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 0;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
end
