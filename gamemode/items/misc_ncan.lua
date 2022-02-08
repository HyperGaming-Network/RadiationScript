ITEM.Name = "Nitrogen Canister";
ITEM.Class = "ncan";
ITEM.Description = "Contains Nitrogen...";
ITEM.Model = "models/srp/props/balon_nponah.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 600;
ITEM.ItemGroup = 51;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

end
