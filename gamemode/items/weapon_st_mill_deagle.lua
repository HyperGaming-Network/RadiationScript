ITEM.Name = "Desert Eagle";
ITEM.Class = "deagleMILL";
ITEM.Description = "Desert Eagle .50 Calibur Hand-Gun\nStrongest Hand-Gun\nIncredible Stopping Power";
ITEM.Model = "models/srp/weapons/w_deagle.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 2500;
ITEM.ItemGroup = 20;
ITEM.ItemTakeOnUse = false
ITEM.IsSecondaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end