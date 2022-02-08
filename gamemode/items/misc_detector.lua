ITEM.Name = "Night Vision Goggles";
ITEM.Class = "nightvision";
ITEM.Description = "It detects night. And dicks.";
ITEM.Model = "models/props/cs_office/computer_mouse.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 500;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
umsg.Start("RecNVum", ply)
umsg.End()
end