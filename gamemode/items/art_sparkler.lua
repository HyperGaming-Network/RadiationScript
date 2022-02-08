ITEM.Name = "sparkler";
ITEM.Class = "sparkler";
ITEM.Description = "fast run speed";
ITEM.Model = "models/srp/items/art_sparkler.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 3000;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)
for i=1,5 do
	if( ply:GetTable().ArtifactSlot[i] == "sparkler" ) then
//	ply:SetRunSpeed(RAD.ConVars[ "RunSpeed" ]);


	ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain + .037
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
	if( ply:GetTable().ArtifactSlot[i] == "sparkler" ) then
	beingheld = true
	ply:GetTable().ElectricScale = ply:GetTable().ElectricScale - .1
	ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain + .037
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
//	ply:SetRunSpeed(300)
	ply:GetTable().StaminaDrain = ply:GetTable().StaminaDrain - .037
	ply:GetTable().ElectricScale = ply:GetTable().ElectricScale + .1
	ply:GetTable().ArtifactSlot[ ply:GetTable().ArtifactSlotsFilled + 1 ] = "sparkler"
	ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled + 1
	
	//local beingheld = true
end
end
end
