ITEM.Name = "Dead Man's Suit";
ITEM.Class = "suit_dead";
ITEM.Description = "A suit found in a springboard. Wonder how it got there?";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 30000;
ITEM.ItemGroup = 17;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/stalker_hood_ecologist2.mdl");
ply:SetColor( 191, 252, 178, 255 )
ply:GetTable().ForceGive = false
ply:GetTable().ArtifactSlots = 2
ply:GetTable().ArtifactSlotsFilled = 0
ply:GetTable().ElectricScale = .75
ply:GetTable().BurnScale = .75
ply:GetTable().AcidScale = .75
ply:GetTable().PsiScale = .75
ply:GetTable().DmgScale = .2
ply:GetTable().RadiationScale = 1.5
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_hood_ecologist2.mdl") );			
end
