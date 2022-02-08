ITEM.Name = "Boost";
ITEM.Class = "Boost";
ITEM.Description = "Makes BloodSuckers look like fairys!";
ITEM.Model = "models/props_lab/jar01a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 500;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

        ply:ConCommand("say /me Takes Some Boost");
	RAD.DrugPlayer(ply, 1);
	self:Remove();

end
