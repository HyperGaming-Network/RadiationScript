ITEM.Name = "Flash";
ITEM.Class = "flash1";
ITEM.Description = "Very fast run speed";
ITEM.Model = "models/srp/items/art_flash.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 10000;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)
for i=1,5 do
	if( ply:GetTable().ArtifactSlot[i] == "flash1" ) then
		ply:GetTable().ElectricScale = ply:GetTable().ElectricScale - .1
	ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain + .073
	// ply:GetTable().StaminaRegen 		= ply:GetTable().StaminaDrain / 3.5
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
	if( ply:GetTable().ArtifactSlot[i] == "flash1" ) then
	beingheld = true
	ply:GetTable().ElectricScale = ply:GetTable().ElectricScale - .1
	ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain + .073
	// ply:GetTable().StaminaRegen 		= ply:GetTable().StaminaDrain / 3.5
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
	ply:GetTable().ElectricScale = ply:GetTable().ElectricScale + .1
	ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain - .073
	// ply:GetTable().StaminaRegen 		= ply:GetTable().StaminaDrain / 3.5
	ply:GetTable().ArtifactSlot[ ply:GetTable().ArtifactSlotsFilled + 1 ] = "flash1"
	ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled + 1
	
	//local beingheld = true
end
end
end
