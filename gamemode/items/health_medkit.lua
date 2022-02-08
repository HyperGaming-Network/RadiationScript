ITEM.Name = "Medkit";
ITEM.Class = "medkit";
ITEM.Description = "Restores about 75% of your health";
ITEM.Model = "models/Items/HealthKit.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 225;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
if( ply:GetTable().BleedAmt < 10 ) then
	ply:GetTable().BleedAmt = 0
else
ply:GetTable().BleedAmt = ply:GetTable().BleedAmt - 5
end
	ply:SetHealth(math.Clamp(ply:Health() + 75, 0, ply:MaxHealth()));
	ply:ConCommand("say /me heals himself ");
	self:Remove();


end
