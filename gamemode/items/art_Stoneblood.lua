ITEM.Name = "Stoneblood";
ITEM.Class = "stoneblood";
ITEM.Description = "Health recovery increase at the cost of Damage Protection";
ITEM.Model = "models/srp/items/art_stoneblood.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 5000;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)
for i=1,5 do
	if( ply:GetTable().ArtifactSlot[i] == "stoneblood" ) then
	ply:GetTable().DmgScale = ply:GetTable().DmgScale - .1
		ply:GetTable().HealthRecov = ply:GetTable().HealthRecov - 7
	ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled - 1
	ply:GetTable().ArtifactSlot[i] = "none"
	end
end
end

function ITEM:Pickup(ply)

	self:Remove();

end

function ITEM:UseItem(ply)
local beingheld = false
for i=1,5 do
	if( ply:GetTable().ArtifactSlot[i] == "stoneblood" ) then
	beingheld = true
	ply:GetTable().DmgScale= ply:GetTable().DmgScale - .1
		ply:GetTable().HealthRecov = ply:GetTable().HealthRecov - 7
	ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled - 1
	ply:GetTable().ArtifactSlot[i] = "none"
	end
end
if( beingheld != true ) then
	//local beingheld = false
	//ply:SetRunSpeed(10);
	//ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled - 1
// else
if( ply:GetTable().ArtifactSlots > ply:GetTable().ArtifactSlotsFilled ) then 
	ply:GetTable().DmgScale = ply:GetTable().DmgScale - .1
		ply:GetTable().HealthRecov = ply:GetTable().HealthRecov + 7
	ply:GetTable().ArtifactSlot[ ply:GetTable().ArtifactSlotsFilled + 1 ] = "stoneblood"
	ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled + 1
	
	//local beingheld = true
end
end
end