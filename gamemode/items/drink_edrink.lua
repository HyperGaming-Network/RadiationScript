ITEM.Name = "Energy Drink";
ITEM.Class = "edrink";
ITEM.Description = "Makes you run like a motherfucker!";
ITEM.Model = "models/srp/props/energycan.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 50;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:SetDTFloat( 3, 1 )
	ply:GetTable().StaminaRegen 		= ply:GetTable().StaminaDrain
	timer.Simple(30, function() ply:GetTable().StaminaRegen = ply:GetTable().StaminaDrain / 3.5 end )

	self:Remove();

end
