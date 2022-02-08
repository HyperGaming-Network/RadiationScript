ITEM.Name = "RPG-7u";
ITEM.Class = "rpg7";
ITEM.Description = "Not For Rocket Jumping...";
ITEM.Model = "models/weapons/w_rocket_launcher.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 16000;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
	ply:Give("RPG7");
	self:Remove();
ply:GetTable().ForceGive = false
end