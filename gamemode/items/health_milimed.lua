ITEM.Name = "Army First Aid Kit";
ITEM.Class = "mmedkit";
ITEM.Description = "A specialized medical set to fight against physical damage and blood loss. In it is included a component for blood coagulation, antibiotics, immunal stimulators, and painkillers..";
ITEM.Model = "models/Items/HealthKit.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 650;
ITEM.ItemGroup = 20;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetHealth(math.Clamp(ply:Health() + 125, 0, ply:MaxHealth()));
	ply:ConCommand("say /me heals himself with the Mili first aid kit");
	ply:GetTable().BleedAmt = 0
	self:Remove();
	


end
