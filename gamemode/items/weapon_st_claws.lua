ITEM.Name = "Claws";
ITEM.Class = "claws";
ITEM.Description = "A Bloodsuckers Best Friend";
ITEM.Model = "models/srp/weapons/w_kabar.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 80;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)
    self:Remove();
end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
	self:Remove();
end
