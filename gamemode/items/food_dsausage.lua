ITEM.Name = "Diet Sausage";
ITEM.Class = "dsausage";
ITEM.Description = "Made from a mix of chicken and soya, the \"diet\" sausage is often, for lack of other options, a stalker's breakfast, lunch and dinner in one.";
ITEM.Model = "models/props_junk/watermelon01_chunk02b.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 180;
ITEM.ItemGroup = 6;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)

local hp = self.Owner:Health();

hp = math.Clamp( hp + 10, 0, 100 );

self.Owner:SetHealth( hp );

end
