-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- shared.lua
-- Some shared functions
-------------------------------

local DoorTypes =
{
	"func_door",
	"func_door_rotating",
	"prop_door_rotating"

}

local BlockedEntities =
{
	"func_door",
	"func_door_rotating",
	"prop_door_rotating",
	"prop_dynamic",
	"func_button",
	"func_breakable",
	"func_brush",
	"func_lod",
	"func_tracktrain",
	"func_physbox",
	"func_breakable_surf",
	"func_movelinear",
	"func_monitor",
	"anom_electro",
    "anom_fire",
    "anom_hydro",
    "anom_punch",
	"anom_whirlgig",
	"anom_hydro",
    "anomaly_damage",
    "stalker_heli",
    "earthquakesent",
	"stalkerradio"
   }
   
function RAD.IsDoor( door )

        if (!ValidEntity(door)) then return false end
	local class = door:GetClass();
	
	for k, v in pairs( DoorTypes ) do
	
		if( v == class ) then return true; end
	
	end
	
	return false;

end

function RAD.IsBlocked( ent )

	local class = ent:GetClass();
	
	for k, v in pairs( BlockedEntities ) do
	
		if( v == class ) then return true; end
	
	end
	
	return false;

end



// omg test


DAYCYCLE = {}

if CLIENT then
WalkTimer = 0
VelSmooth = 0
Sharpen = 0
MotionBlur = 0
ViewWobble = 0
DisorientTime = 0




ColorModify = {}
ColorModify[ "$pp_colour_addr" ] 		= 0
ColorModify[ "$pp_colour_addg" ] 		= 0
ColorModify[ "$pp_colour_addb" ] 		= 0
ColorModify[ "$pp_colour_brightness" ] 	= 0
ColorModify[ "$pp_colour_contrast" ] 	= 1
ColorModify[ "$pp_colour_colour" ] 		= 1
ColorModify[ "$pp_colour_mulr" ] 		= 0
ColorModify[ "$pp_colour_mulg" ] 		= 0
ColorModify[ "$pp_colour_mulb" ] 		= 0

MixedColorMod = {}

local function DrawInternal()
	local traced = {}
	traced.start = LocalPlayer():GetPos()
	traced.endpos = LocalPlayer():GetPos()+Vector(0,0,700)
	traced.mask = MASK_NPCWORLDSTATIC
	local tr=util.TraceLine(traced)
	
	if !tr.HitWorld then
	local approach = FrameTime() * 0.05

	if ( Sharpen > 0 ) then
	
		DrawSharpen( Sharpen, 0.5 )
		
		Sharpen = math.Approach( Sharpen, 0, FrameTime() * 0.5 )
		
	end

	if ( MotionBlur > 0 ) then
	
		DrawMotionBlur( 1 - MotionBlur, 1.0, 0.0 )
		
		MotionBlur = math.Approach( MotionBlur, 0, approach )
		
	end
	
	for k,v in pairs( ColorModify ) do
		
		if k == "$pp_colour_colour" or k == "$pp_colour_contrast" then
		
			ColorModify[k] = math.Approach( ColorModify[k], 1, approach ) 
		
		else
	
			ColorModify[k] = math.Approach( ColorModify[k], 0, approach ) 
		
		end
	
		MixedColorMod[k] = DayColor[k] + ColorModify[k]
	
	end
	
	DrawColorModify( MixedColorMod )
	
	local rad = LocalPlayer():GetNWInt( "Radiation", 0 )
	
	if rad > 0 and LocalPlayer():Alive() then
		
		local scale = rad / 5
			
		MotionBlur = math.Approach( MotionBlur, scale * 0.5, FrameTime() )
		Sharpen = math.Approach( Sharpen, scale * 5, FrameTime() * 3 )
	
		ColorModify[ "$pp_colour_colour" ] = math.Approach( ColorModify[ "$pp_colour_colour" ], 1 - ( scale * 0.8 ), FrameTime() * 0.1 )
		ColorModify[ "$pp_colour_brightness" ] 	= math.Approach( ColorModify[ "$pp_colour_brightness" ], ( scale * -0.2 ), FrameTime() * 0.1 )
		
		//if LocalPlayer():Health() > 50 then
		
		//	ViewWobble = 0.2 - 0.2 * scale
		
	//	end
		
	end
end
end
hook.Add( "RenderScreenspaceEffects", "RenderPostProcessing", DrawInternal )





	DayColor = {}
	DayColor[ "$pp_colour_addr" ] = 0
	DayColor[ "$pp_colour_addg" ] = 0
	DayColor[ "$pp_colour_addb" ] = 0
	DayColor[ "$pp_colour_brightness" ] = 0
	DayColor[ "$pp_colour_contrast" ] = 0
	DayColor[ "$pp_colour_colour" ] = 0
	DayColor[ "$pp_colour_mulr" ] = 0
	DayColor[ "$pp_colour_mulg" ] = 0
	DayColor[ "$pp_colour_mulb" ] = 0

	hook.Add("Initialize", "DAYCYCLE.Initialize",
	
		function()
		
			DAYCYCLE.NextTimeThink = 0
			DAYCYCLE.LastColor = nil
			
		end
		
	)

	hook.Add("Think", "DAYCYCLE.Think",
	
			function()
				
				if DAYCYCLE.NextTimeThink > CurTime() then return end

				DAYCYCLE.NextTimeThink = CurTime() + 0.1
				
				if GetGlobalString( "DAYCYCLE:SkyName" ) == "" then return end
				
				if DAYCYCLE.Materials == nil then
				
					local skyname = GetGlobalString( "DAYCYCLE:SkyName" )
				
					DAYCYCLE.Materials = {}
					DAYCYCLE.Materials[1] = Material("skybox/" .. skyname .. "up")
					DAYCYCLE.Materials[2] = Material("skybox/" .. skyname .. "dn")
					DAYCYCLE.Materials[3] = Material("skybox/" .. skyname .. "lf")
					DAYCYCLE.Materials[4] = Material("skybox/" .. skyname .. "rt")
					DAYCYCLE.Materials[5] = Material("skybox/" .. skyname .. "bk")
					DAYCYCLE.Materials[6] = Material("skybox/" .. skyname .. "ft")
					
				end
				
				local col = GetGlobalVector( "DAYCYCLE:SkyMod" )
				local bright = GetGlobalFloat( "DAYCYCLE:SkyBrightness" )
				local cont = GetGlobalFloat( "DAYCYCLE:SkyContrast" )
				
				DayColor[ "$pp_colour_brightness" ] = bright
				DayColor[ "$pp_colour_contrast" ] = cont
				DayColor[ "$pp_colour_mulr" ] = tonumber( col.x / 5 )
				DayColor[ "$pp_colour_mulg" ] = tonumber( col.y / 5 )
				DayColor[ "$pp_colour_mulb" ] = tonumber( col.z / 5 )
				
				if col != DAYCYCLE.LastColor then
				
					if not DAYCYCLE.LastColor then
					
						DAYCYCLE.LastColor = col
					
					end
				
					DAYCYCLE.LastColor.r = math.Approach( DAYCYCLE.LastColor.r, col.r, FrameTime() )
					DAYCYCLE.LastColor.g = math.Approach( DAYCYCLE.LastColor.g, col.g, FrameTime() )
					DAYCYCLE.LastColor.b = math.Approach( DAYCYCLE.LastColor.b, col.b, FrameTime() )
				
					for k,v in pairs( DAYCYCLE.Materials ) do
					
						v:SetMaterialVector( "$color", DAYCYCLE.LastColor )
						
					end
					
				end
			
			end
		)

	return
	
end

 MINUTE_LENGTH = 10
local DAY_LENGTH	= 60 * 24
local MORNING		= DAY_LENGTH / 4 
local EVENING		= MORNING * 3
local MIDDAY		= DAY_LENGTH / 2
local MORNING_START	= MORNING - 144
local MORNING_END	= MORNING + 144
local EVENING_START	= EVENING - 144
local EVENING_END	= EVENING + 144
local DAY_START		= 5 * 60
local DAY_END		= 18.5 * 60

function DAYCYCLE.SetSunTime( minute )

	local tbl = DAYCYCLE.LightTable[minute]
	
	if DAYCYCLE.ShadowControl then
	
		DAYCYCLE.ShadowControl:Fire( "SetDistance", tbl.ShadowLength , 0 )
		DAYCYCLE.ShadowControl:Fire( "direction", tbl.ShadowAngle , 0 )
		DAYCYCLE.ShadowControl:Fire( "color", tbl.ShadowColor, 0 )
		
	end
	
	if DAYCYCLE.Sun then
	
		DAYCYCLE.Sun:Fire( "addoutput", tbl.SunAngle , 0 )
		DAYCYCLE.Sun:Activate()
		
	end
	if not storm_active then
	if( DAYCYCLE.DayMinute > 300 or  DAYCYCLE.DayMinute > 1250 ) then
	if( DAYCYCLE.DayMinute < 460 or  DAYCYCLE.DayMinute < 1250 ) then
	SetGlobalString("weather","morning")
	end
	elseif( DAYCYCLE.DayMinute < 300 or DAYCYCLE.DayMinute > 1250 ) then
	SetGlobalString("weather","dark")
	elseif( DAYCYCLE.DayMinute > 460 and DAYCYCLE.DayMinute < 1250 ) then
	SetGlobalString("weather","sunny")
	end
	end
	//end
	//end
	SetGlobalVector( "DAYCYCLE:SkyMod", tbl.SkyColor )
	SetGlobalFloat( "DAYCYCLE:SkyContrast", tbl.SkyContrast )
	SetGlobalFloat( "DAYCYCLE:SkyBrightness", tbl.SkyBrightness )
	
end

function DAYCYCLE.CalculateTimeColor( dayminute )
	// default color to white.
	local red = 1
	local blue = 1
	local green = 1
	
	//pp values
	local brightness = 0
	local contrast = 0
	
	// golden sunrise calculations
	if dayminute >= 1 and dayminute < MORNING_END then
		
		if dayminute < MORNING_START then

			red = 0.25
			green = 0.25
			blue = 0.35
			
			brightness = -0.1
			contrast = -0.5
			
		else
		
			local frac = ( dayminute - MORNING_START ) / ( MORNING_END - MORNING_START )

			red = math.Clamp( frac * 1.5, 0, 0.25 )
			green = math.Clamp( frac * 1.2, 0, 0.25 )
			blue = math.Clamp( frac, 0, 0.35 )
			
			brightness = -0.1 + frac * 0.1
			contrast = -0.5 + frac * 0.5 

		end
		
	end
	
	// red dusk
	if dayminute > EVENING_START and dayminute <= DAY_LENGTH then
	
		local frac = 1 - ( ( dayminute - EVENING_START ) / ( EVENING_END - EVENING_START ) )
		
		if dayminute > EVENING_END then
		
			red = 0.25
			green = 0.25
			blue = 0.35
			
			brightness = -0.1
			contrast = -0.5
			
		else
		
			red = math.Clamp( frac, 0, 0.25 )
			green = math.Clamp( frac * 0.7, 0, 0.25 )
			blue = math.Clamp( frac * 0.8, 0, 0.35 )
			
			brightness = -0.1 + frac * 0.1
			contrast = -0.5 + frac * 0.5 

		end
		
	end

	red = math.Clamp( red, 0, 1 )
	blue = math.Clamp( blue, 0, 1 )
	green = math.Clamp( green, 0, 1 )
	brightness = math.Clamp( brightness, -1, 1 )
	contrast = math.Clamp( contrast, -1, 1 )

	return Vector( red, green, blue ), brightness, contrast
	
end

function DAYCYCLE.CalculateShadowColor( dayminute )

	local shadowcolor = 255
	
	if dayminute > MORNING and dayminute < EVENING then
	
		local frac = 0
		
		if dayminute < MIDDAY then
		
			local a = dayminute - MORNING
			local b = MIDDAY - MORNING
			local frac = ( a / b )
			shadowcolor = math.floor( 255 - ( frac * 127 ) )
			
		else
		
			local a = dayminute - MIDDAY
			local b = EVENING - MIDDAY
			local frac = ( a / b )
			shadowcolor = math.floor( 128 + ( frac * 127 ) )
			
		end
		
	end
	
	return shadowcolor .. " " .. shadowcolor .. " " .. shadowcolor
	
end
	
function DAYCYCLE.InitLightTable()

	DAYCYCLE.LightTable = {}
	
	for n=1, DAY_LENGTH do
	
		DAYCYCLE.LightTable[n] = {}
		
		// calculate the percentage of "night sky" or in other words, the amount of
		// alpha to apply to the sky overlay.
		DAYCYCLE.LightTable[n].Night = math.Clamp( math.abs( ( n - MIDDAY ) / MIDDAY ) , 0 , 0.7 );
		DAYCYCLE.LightTable[n].SunAngle = (n / DAY_LENGTH) * 360
		DAYCYCLE.LightTable[n].SunAngle = DAYCYCLE.LightTable[n].SunAngle + 90
		
		if DAYCYCLE.LightTable[n].SunAngle > 360 then
		
			DAYCYCLE.LightTable[n].SunAngle = DAYCYCLE.LightTable[n].SunAngle - 360
			
		end
		
		DAYCYCLE.LightTable[n].SunAngle = "pitch " .. DAYCYCLE.LightTable[n].SunAngle
		
		DAYCYCLE.LightTable[n].ShadowLength = tostring( DAYCYCLE.LightTable[n].Night * 300 )
		DAYCYCLE.LightTable[n].ShadowAngle = math.Approach( -1 , 1 , ( MIDDAY / n ) ) .. " 0 -1"
		DAYCYCLE.LightTable[n].ShadowColor = DAYCYCLE.CalculateShadowColor( n )
		
		local col, bright, cont = DAYCYCLE.CalculateTimeColor( n )
		
		DAYCYCLE.LightTable[n].SkyColor = col
		DAYCYCLE.LightTable[n].SkyBrightness = bright
		DAYCYCLE.LightTable[n].SkyContrast = cont
		
	end
	
end

hook.Add( "EntityKeyValue", "DAYCYCLE.KeyValue",

	function( ent, key, val )
			
		if ent:GetClass() == "worldspawn" and key == "skyname" then
			
			SetGlobalString( "DAYCYCLE:SkyName", val )
				
		end
			
	end
)

hook.Add( "Initialize", "DAYCYCLE.Initialize",

	function()
	
		DAYCYCLE.InitDone = false
		DAYCYCLE.InitLightTable()
		DAYCYCLE.NextTimeThink = 0
		DAYCYCLE.DayMinute = 450
		DAYCYCLE.LastBrightness = nil
		
	end
)
	
hook.Add( "InitPostEntity", "DAYCYCLE.PostEntInit",

	function()
			
		DAYCYCLE.ShadowControl = ents.FindByClass( "shadow_control" )[1]
			
		if !DAYCYCLE.ShadowControl then
			
			DAYCYCLE.ShadowControl = ents.Create( "shadow_control" )
				
		end
			
		DAYCYCLE.Sun = ents.FindByClass( "env_sun" )[1] 
			
		if DAYCYCLE.Sun then
			
			DAYCYCLE.Sun:SetKeyValue( "material", "sprites/light_glow02_add_noz.vmt" )
			DAYCYCLE.Sun:SetKeyValue( "overlaymaterial", "sprites/light_glow02_add_noz.vmt" )
				
		end
			
		DAYCYCLE.InitDone = true
			
	end
)
	
hook.Add( "Think", "DAYCYCLE.Think",

	function()
		
		if !DAYCYCLE.InitDone then return end
			
		if DAYCYCLE.NextTimeThink > CurTime() then return end

		DAYCYCLE.NextTimeThink = CurTime() + MINUTE_LENGTH
		DAYCYCLE.DayMinute = DAYCYCLE.DayMinute + 1
			
		if DAYCYCLE.DayMinute > DAY_LENGTH then 
			
			DAYCYCLE.DayMinute = 1 
				
		end
			
		DAYCYCLE.SetSunTime( DAYCYCLE.DayMinute )
			
	end
)



