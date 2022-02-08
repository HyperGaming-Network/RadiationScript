 -------------------------------
-- www.HyperGamer.Net
-- HGNRP
-- Author: Silver Knight
-------------------------------

DeriveGamemode( "sandbox" );
GM.Name = "RadiationScript";

-- Define global variables
RAD = {  };
RAD.Running = false;
readysent = false;

-- Client Includes
include( "VGUI/hpanel.lua" );
include( "VGUI/ipanel.lua" );
include( "cl_skin.lua" );
include( "sh_animations.lua" );
include( "cl_sight.lua" );
include( "shared.lua" );
include( "player_shared.lua" );
include( "cl_hud.lua" );
include( "cl_binds.lua" );
include( "cl_charactercreate.lua" );
include( "cl_playermenu.lua" );
include( "cl_search.lua" );
include( "cl_sight.lua" );
include( "cl_view.lua" );
include( "cl_ragspec.lua" );
include( "cl_bleed.lua" );


-- Initialize the gamemode
function GM:Initialize( )

	RAD.Running = true;

	self.BaseClass:Initialize( );

end

function GM:Think( )

	if( vgui and readysent == false ) then -- VGUI is initalized, tell the server we're ready for character creation.
	
		LocalPlayer( ):ConCommand( "rp_ready\n" );
		readysent = true;
	end
	
end

local meta = FindMetaTable( "Entity" );

local DoorTypes =
{

	"func_door",
	"func_door_rotating",
	"prop_door_rotating"

}

function meta:IsDoor()

	local class = self:GetClass();
	
	for k, v in pairs( DoorTypes ) do
	
		if( v == class ) then return true; end
	
	end
	
	return false;

end

function GM:PostProcessPermitted(element)
	local bannedElement = {"colormod"}
 
	return table.HasValue(bannedElement, element)
end 

	local function Tick( ) 
		for k, v in pairs( player.GetAll( ) ) do 
		 pscalex = v:GetNetworkedFloat("PlScalew")
		 pscaley = v:GetNetworkedFloat("PlScalew")
		 pscalez = v:GetNetworkedFloat("PlScalez")
			if not pscalex then
				pscalex = 1
				pscaley = 1
			end;
				if not pscalez then
				pscalez = 1
			end;
	
		local ScaleVector = Vector( pscalex, pscaley, pscalez )
			v:SetModelScale( ScaleVector )
		//	v:SetRenderBounds( pscale * Sizing.Default.StandingHull.Minimum, pscale * Sizing.Default.StandingHull.Maximum )			
		end				
	end
	hook.Add( "Tick", "PlayerResize", Tick )


EBTab = {}
blue = 0
function Controller()
local conmodel = "models/srp/stalker_kontroler.mdl"
	if( LocalPlayer():GetModel() == conmodel ) then return end;
	for k,v in pairs( player.GetAll() ) do
	local vpos = v:GetPos()
	local vdist = vpos:Distance( LocalPlayer():GetPos() ) 
		if( v:GetModel() == conmodel and vdist < 1000 ) then
		if vdist > 500 then
	blue = math.Approach(blue, .5, .1)
	EBTab[ "$pp_colour_addr" ] = 0
	EBTab[ "$pp_colour_addg" ] = 0
	EBTab[ "$pp_colour_addb" ] = blue
	EBTab[ "$pp_colour_brightness" ] = 0
	EBTab[ "$pp_colour_contrast" ] = 1
	EBTab[ "$pp_colour_colour" ] = 1
	EBTab[ "$pp_colour_mulr" ] = 0
	EBTab[ "$pp_colour_mulg" ] = 0
	EBTab[ "$pp_colour_mulb" ] = 0
	DrawMotionBlur( 0.2, 1, 0)
	DrawColorModify( EBTab )
		elseif vdist > 250 then
	blue = math.Approach(blue, 2, .1)
	EBTab[ "$pp_colour_addr" ] = 0
	EBTab[ "$pp_colour_addg" ] = 0
	EBTab[ "$pp_colour_addb" ] = blue
	EBTab[ "$pp_colour_brightness" ] = 0
	EBTab[ "$pp_colour_contrast" ] = 1
	EBTab[ "$pp_colour_colour" ] = 1
	EBTab[ "$pp_colour_mulr" ] = 0
	EBTab[ "$pp_colour_mulg" ] = 0
	EBTab[ "$pp_colour_mulb" ] = 0
	DrawMotionBlur( 0.1, 1, 0)
	LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y , 0 ) ) 
	LocalPlayer():SetDSP(4, false )
	DrawColorModify( EBTab )
	else 
	EBTab = {}
	EBTab[ "$pp_colour_addr" ] = 0
	EBTab[ "$pp_colour_addg" ] = 0
	EBTab[ "$pp_colour_addb" ] = 4
	EBTab[ "$pp_colour_brightness" ] = 0
	EBTab[ "$pp_colour_contrast" ] = 1
	EBTab[ "$pp_colour_colour" ] = 1
	EBTab[ "$pp_colour_mulr" ] = 0
	EBTab[ "$pp_colour_mulg" ] = 0
	EBTab[ "$pp_colour_mulb" ] = 0
	DrawMotionBlur( 0.07, 1, 0)
	LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p + math.random( -1, 1 ), LocalPlayer():EyeAngles().y + math.random( -1, 1 ), math.Clamp( LocalPlayer():EyeAngles().r + math.random( -.75, .75) , -30, 30 ) ) ) 
	LocalPlayer():SetDSP(37, false )
	DrawColorModify( EBTab )
	end
	else
	EBTab[ "$pp_colour_addb" ] = 0
	LocalPlayer():SetDSP(1, false )
	end
	if( !v:Alive() ) then
		LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y , 0 ) ) 
	end
	end
end
hook.Add( "HUDPaint", "Controller", Controller );


function BlockJump( ply, bind, pressed )
      //To block more commands, you could add another line similar to the one below, just replace the command
      if string.find( bind, "+jump" ) then
	if( ply:GetDTFloat( 3 ) <= .1 ) then
		 return true 
	end
	end
	   if string.find( bind, "+speed" ) and ply:KeyDown( IN_BACK ) then 
		 return true
	   end
	  if string.find( bind, "+speed" ) and ply:KeyDown( IN_MOVELEFT ) then
		 return true
	   end

	  if(   string.find( bind, "+speed" ) and ply:KeyDown( IN_MOVERIGHT )  ) then
		 return true
	   end
	    if (string.find( bind, "+back" ) and  ply:KeyDown( IN_SPEED )) then  
		return true
	    end
	    if(string.find( bind, "+moveleft" ) and  ply:KeyDown( IN_SPEED )) then
		return true
	    end
	   if (string.find( bind, "+moveright" ) and  ply:KeyDown( IN_SPEED )) then
		return true
	    end
end

hook.Add( "PlayerBindPress", "BlockJump", BlockJump )


function BrainScorcher()
 for k,v in pairs( ents.FindInBox( Vector(-11311.968750, -11643.968750,  -428.062500), Vector(-5970.718750, -4058.875000, 141.468750) ) ) do
	if( v == LocalPlayer() ) then

	EBTab[ "$pp_colour_addr" ] = 0
	EBTab[ "$pp_colour_addg" ] = 0
	EBTab[ "$pp_colour_addb" ] = 3
	EBTab[ "$pp_colour_brightness" ] = 0
	EBTab[ "$pp_colour_contrast" ] = 1
	EBTab[ "$pp_colour_colour" ] = 1
	EBTab[ "$pp_colour_mulr" ] = 0
	EBTab[ "$pp_colour_mulg" ] = 0
	EBTab[ "$pp_colour_mulb" ] = 0
	DrawMotionBlur( 0.1, 1, 0)
	LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y , 0 ) ) 
	LocalPlayer():SetDSP(4, false )
	DrawColorModify( EBTab )
	end
end
end
hook.Add( "HUDPaint", "BrainScorcher", BrainScorcher );



