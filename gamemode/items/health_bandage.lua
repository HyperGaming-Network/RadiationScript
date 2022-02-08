ITEM.Name = "Basic Bandage Kit";
ITEM.Class = "bbandage";
ITEM.Description = "Helps to slow down bleeding";
ITEM.Model = "models/props/cs_office/Paper_towels.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 10;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

if( ply:GetTable().BleedAmt < 7 ) then
	ply:GetTable().BleedAmt = 0
else
ply:GetTable().BleedAmt = ply:GetTable().BleedAmt - 7
end
self:Remove();
end
