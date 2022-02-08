
local function DroppingBlood()
if CurTime() >= DropBlood then
hook.Remove( "HUDPaint", "DroppingBlood" )
end
end

DropBlood = 0

function NewBleed( um )

    BleedAmt = um:ReadLong()
hook.Add("HUDPaint", "DroppingBlood", DroppingBlood)
 DropBlood = CurTime() + 5
end
usermessage.Hook("bleed_info", NewBleed )

Bleed = surface.GetTextureID( "hgn/srp/ui/bleed" );
function BleedMat()
	if( BleedAmt ) then
	local BleedColor = BleedAmt * 31
	if( 255 - BleedColor < 0 ) then
	BleedColor = 255
	end
	if( BleedAmt <= 0 ) then
	return
	end
	surface.SetDrawColor( 255,255 - BleedColor, 255 - BleedColor, 255 );
	surface.SetTexture( Bleed );
	surface.DrawTexturedRect( ScrW() - 64,ScrH() * 4/5 ,64,64)
	end
end

hook.Add( "HUDPaint", "BleedMat", BleedMat ) 