ITEM.Name = "TOZ 34 Hunting rifle";
ITEM.Class = "huntingrifle";
ITEM.Description = "The TOZ 34 Hunting rifle is a smoothbore break-top rifle that chambers ,buckshot rounds, this weapon is popular among rookie loners and bandits.";
ITEM.Model = "models/weapons/w_shot_remington.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 450;
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