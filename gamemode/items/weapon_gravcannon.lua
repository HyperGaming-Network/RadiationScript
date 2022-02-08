ITEM.Name = "Engine Gravcannon";
ITEM.Class = "engine_gravcannon";
ITEM.Description = "To prevent your client from crashing";
ITEM.Model = "models/weapons/w_shotgun.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 1;
ITEM.ItemGroup = 1;

function ITEM:Drop(ply)
	self:Remove();
end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
	self:Remove();
end
