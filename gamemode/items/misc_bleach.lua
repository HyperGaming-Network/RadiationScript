ITEM.Name = "Bleach";
ITEM.Class = "bleach";
ITEM.Description = "Has a warning but it's in english...";
ITEM.Model = "models/props_junk/garbage_plasticbottle001a.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 5;
ITEM.ItemGroup = 51;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)


	ply:ConCommand("say /me Drinks some bleach");
	
	local function KillThem()
		ply:ConCommand("say /me throws up and passes out");
		ply:Kill();
	end
	
	timer.Simple(30, KillThem);
	self:Remove();

end
