ITEM.Name = "Scientific Medkit";
ITEM.Class = "smedkit";
ITEM.Description = "Medical set, designed especially for work in the Zone. The set includes means of healing wounds as well as means of eliminating radionucleodes from the body. Prevents the development of radiowave sickness and lowers the dose of accumulated radiation.";
ITEM.Model = "models/Items/HealthKit.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 800;
ITEM.ItemGroup = 17;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
	ply:GetTable().BleedAmt = 0
	ply:SetHealth(math.Clamp(ply:Health() + 150, 0, ply:MaxHealth()));
	self:Remove();


end
