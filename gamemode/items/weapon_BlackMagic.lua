ITEM.Name = "weapon_BlackMagic";
ITEM.Class = "megamutant12";
ITEM.Description = "A Stalkers Best Friend";
ITEM.Model = "models/srp/weapons/w_kabar.mdl";
ITEM.Purchaseable =false;
ITEM.Price = 80;
ITEM.ItemGroup = 5;

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
	ply:Give("weapon_BlackMagic");
	self:Remove();
ply:GetTable().ForceGive = false
end
