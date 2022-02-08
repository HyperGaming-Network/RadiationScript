ITEM.Name = "Hidden Suit";
ITEM.Class = "suit_hidden";
ITEM.Description = "An experiment Merc Suit with the ability to slightly hide you, at the cost of Protection. Does not work on Weaponry.";
ITEM.Model = "models/weapons/w_package.mdl";
ITEM.Purchaseable = false;
ITEM.Price = 60000;
ITEM.ItemGroup = 5;
ITEM.ItemTakeOnUse = true

function ITEM:Drop(ply)

end

function ITEM:Pickup(ply)
	self:Remove();
end

function ITEM:UseItem(ply)
ply:GetTable().ForceGive = true
ply:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
	ply:SetModel("models/srp/stalker_antigas_killer3.mdl");

ply:GetTable().ForceGive = false
ply:SetColor( 255, 255, 255, 50 )
ply:GetTable().ElectricScale = .8
ply:GetTable().BurnScale = .7
ply:GetTable().AcidScale = .7
ply:GetTable().PsiScale = .5
ply:GetTable().DmgScale = 1.5
ply:GetTable().RadiationScale = .5
ply:GetTable().ArtifactSlots = 3
ply:GetTable().ArtifactSlotsFilled = 0
	self:Remove();
RAD.SetCharField(ply, "model",("models/srp/stalker_antigas_killer3.mdl") );			
end
