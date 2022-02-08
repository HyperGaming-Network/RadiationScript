ITEM.Name = "Sig 550 Scoped-Rifle";
ITEM.Class = "sig550";
ITEM.Description = "Sig 550 Scoped-Rifle\nA step below the G36";
ITEM.Model = "models/srp/weapons/w_sig550.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 6500;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false
ITEM.IsPrimaryWeapon = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply, cmd, args)

end