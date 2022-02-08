ITEM.Name = "Beretta M92FS";
ITEM.Class = "beretta";
ITEM.Description = "Beretta M92FS Hand-Gun\nHigh Magizine Capacity\nWeak";
ITEM.Model = "models/srp/weapons/w_beretta.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 450;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false
ITEM.IsSecondaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end