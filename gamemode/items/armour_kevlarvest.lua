ITEM.Name = "Kevlar Vest";
ITEM.Class = "kevlar";
ITEM.Description = "Reduces damage the player receives by 50%.";
ITEM.Model = "models/props_c17/suitcase_passenger_physics.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1200;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
    ply:ConCommand("say /me puts on a kevlar vest");
	ply:SetArmor(math.Clamp(ply:Armor() + 400, 0, ply:MaxArmor()));
              self:Remove();

end