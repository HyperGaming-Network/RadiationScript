ITEM.Name = "Fireball";
ITEM.Class = "fireball";
ITEM.Description = "+20% Radiation Protection, Lose some Run Speed.";
ITEM.Model = "models/srp/items/art_fireball.mdl";
ITEM.Purchaseable = true;
ITEM.Price = 1000;
ITEM.ItemGroup = 1;
ITEM.ItemTakeOnUse = false

function ITEM:Drop(ply)
for i=1,5 do
	if( ply:GetTable().ArtifactSlot[i] == "fireball" ) then
	ply:SetRunSpeed(RAD.ConVars[ "RunSpeed" ]);
	ply:GetTable().RadiationScale = ply:GetTable().RadiationScale + .2
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
	if( ply:GetTable().ArtifactSlot[i] == "fireball" ) then
	beingheld = true
	ply:SetRunSpeed(RAD.ConVars[ "RunSpeed" ]);
	ply:GetTable().RadiationScale = ply:GetTable().RadiationScale + .2
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
	ply:SetRunSpeed(RAD.ConVars[ "RunSpeed" ] - 15);
	ply:GetTable().RadiationScale = ply:GetTable().RadiationScale - .2
	ply:GetTable().ArtifactSlot[ ply:GetTable().ArtifactSlotsFilled + 1 ] = "fireball"
	ply:GetTable().ArtifactSlotsFilled = ply:GetTable().ArtifactSlotsFilled + 1
	
	//local beingheld = true
end
end
end
