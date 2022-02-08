ITEM.Name = "Stale Water";
ITEM.Class = "swater";
ITEM.Description = "Seems to have been sitting around for awhile...";
ITEM.Model = "models/props_junk/garbage_plasticbottle003a.mdl";
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
                ply:SetHealth(math.Clamp(ply:Health() - 10, 0, ply:MaxHealth()));

	local function stalewater()
		
	end
	
	timer.Simple(4, stalewater);
	self:Remove();

end
