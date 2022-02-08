ITEM.Name = "Military Documents";
ITEM.Class = "mdoc";
ITEM.Description = "A fireproof briefcase with documents. Obviously highly illegal.";
ITEM.Model = "models/props_c17/BriefCase001a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 2000;
ITEM.ItemGroup = 51;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

	ply:ConCommand("say /me Looks at the Closed Briefcase");

end
