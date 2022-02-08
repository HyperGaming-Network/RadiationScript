
CreateClientConVar( "rp_headbob", "1", true, false );

HeadBobX = 0;
HeadBobY = 0;
HeadBobAng = 0;

function RADCalcView( ply, origin, angle, fov )
if( ValidEntity( LocalPlayer() ) ) then
	if( HeadBobAng > 360 ) then HeadBobAng = 0; end

	if( CrackDrug and CurTime() - DrugTime > 4 ) then
	
		local view = { }
	
		CrackDrugAng = CrackDrugAng or Angle( 0, 0, 0 );		
		CrackDrugAng.y = CrackDrugAng.y + 180 * FrameTime();
		
		view.origin = origin;
		view.angles = ply:GetAimVector():Angle() + CrackDrugAng;
		
		return view;
		
	end

	if( ply:GetNWInt( "thirdperson" ) == 1 ) then

		local view = { }
		
		local mul = 1;
		
		if( ply:GetNWInt( "inversethirdperson" ) == 1 ) then
			
			mul = -1;
			view.angles = ply:GetAimVector():Angle() + Angle( 0, 180, 0 );
			
		else
		
			view.angles = ply:GetAimVector():Angle();
		
		end
		
		local tr = { }
		tr.start = ply:EyePos();
		tr.endpos = ply:EyePos() - ply:GetAimVector() * 100 * mul;
		tr.filter = ply;
		
		local trace = util.TraceLine( tr );
		
		view.origin = trace.HitPos + 10 * ply:GetAimVector() * mul;	
	  	
	  	return view;

	end
	
	if( LocalPlayer():GetInfo( "rp_headbob" ) == "1" ) then
		
		if( ( ply:KeyDown( IN_FORWARD ) or
			ply:KeyDown( IN_BACK ) or
			ply:KeyDown( IN_MOVERIGHT ) or
			ply:KeyDown( IN_MOVELEFT ) ) and ply:IsOnGround() ) then
			
			local view = { }
			view.origin = origin;
			view.angles = angles;
			
			if( ply:GetVelocity():Length() > 150 ) then
				
				HeadBobAng = HeadBobAng + 10 * FrameTime();
				
				view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng ) * .5;
				view.angles.yaw = view.angles.yaw + math.cos( HeadBobAng ) * .2;
						
			else
			
				HeadBobAng = HeadBobAng + 6 * FrameTime();
				
				view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng ) * .5;
				view.angles.yaw = view.angles.yaw + math.cos( HeadBobAng ) * .3;
				
			end
					
			return view;
			
		end
			
		local view = { }
		view.origin = origin;
		view.angles = angles;
		
		view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng );
		view.angles.yaw = view.angles.yaw + math.cos( HeadBobAng );

		return view;

	end
  	end
end
hook.Add( "CalcView", "RADCalcView", RADCalcView );

//////////////////////////////////////////////////////////

require( "datastream" )
PDAPlayers = {}
for i=1,100 do 
PDAPlayers[ i ] = false
end

if( PDAPlayers == nil ) then
PDAPlayers = {}
end
function RecPDAData( um )
    PDAPlayers[ um:ReadLong() ] = um:ReadBool()
end
usermessage.Hook("pda_info", RecPDAData )



function IncomingPDA( handler, id, encoded, decoded )
PDAPlayers = {}
table.Merge(PDAPlayers,decoded)
end

datastream.Hook( "IncomingPDA", IncomingPDA );
 local convar = CreateClientConVar("rp_pdascale", "240")
 convar1 = CreateClientConVar("rp_pdamatscale", "320")
 local convar2 = CreateClientConVar("rp_radar", "1")
--RADAR
 placement = ScrH() / 51.2
 placement1 = ScrH() / 25
local radar = {}
Radarmatw = convar1:GetFloat()
 placement = ScrH() / 51.2

--Default values
radar.w = convar:GetFloat()
radar.h = convar:GetFloat()
radar.x = placement1
radar.y = placement1
radar.alphascale = 0.6
radar.bgcolor = Color(150,150,150,255)
radar.fgcolor = Color(100,100,100,255)
radar.dangercolour = Color(220,0,0,255)
radar.dangerblipcolour = Color(255,255,0,255)
radar.screendetail = 64 -- Ooh, purty.
radar.screenrotation = 0
radar.hazardmode = true 	-- If the radar finds any hazardous ents in its radius, should it bitch about it?

radar.radius = 2000

radar.player_show = true
radar.player_color = Color(255,255,30,255)
//radar.mutant_color = Color(255,30,30,255)
radar.mutantmodels = 
{
"models/srp/blood_sucker.mdl",
"models/srp/blood_sucker2.mdl",
"models/srp/stalker_kontroler.mdl",
"models/stalker_pseudodog.mdl",
"models/regenerator.mdl"
}


radar.scanfor = {"player", "npc_"}	
radar.dangerous = {"sent_nuke_missile", "sent_nuke_detpack"}		-- What should the radar consider extremely hazardous? ("Hazard Mode")  Only accepts full names.
	-- What should the radar look for?  Accepts partial names.
-- The danger table relies on the scan table, make sure your dangerous ent is in both tables.


------------------------------------------------------------------
-- Don't edit under here unless you're the trigonometry GOD. D: --
------------------------------------------------------------------


radar.bgcolorbak = radar.bgcolor
radar.fgcolorbak = radar.fgcolor
radar.player_colorbak = radar.player_color


local color_ascale = function(col,scale) return Color(col.r,col.g,col.b,col.a*scale) end

-- Without further ado, let's rock.

Compass12 = surface.GetTextureID( "hgn/srp/ui/Compass" );
Radar = surface.GetTextureID( "hgn/srp/ui/radarCoP" );
function CD_DrawRadar ()

if( convar2:GetFloat() == 1) then
	local lpl = LocalPlayer()
if( PDAPlayers[ lpl:EntIndex() ] == true ) then
radar.w = convar:GetFloat()
radar.h = convar:GetFloat()	
//	if( LocalPlayer():HasItem( "pda" ) ) then
	local ETable = {}
	local PulseRadar = false


	if ( not lpl:Alive() ) then return end
	
	
	if ( radar.player_show ) then
	
	--draw.RoundedBox( radar.w/2, radar.x, radar.y, radar.w, radar.h, radar.bgcolor ) --Looks like shit
	local vertices = {}
	for i=1,radar.screendetail do
		local shift = math.fmod(CurTime()*radar.screenrotation,360)
		local sizescale = 1 --+ math.sin(CurTime())/10
		local tab = {}
		tab.x = radar.x+radar.w/2 + math.cos(math.Deg2Rad((360/radar.screendetail)*i+shift)) * radar.w/2 * sizescale
		tab.y = radar.y+radar.h/2 + math.sin(math.Deg2Rad((360/radar.screendetail)*i+shift)) * radar.h/2 * sizescale
		tab.u = 0
		tab.v = 0
		table.insert(vertices,tab)
	end
	surface.SetTexture(surface.GetTextureID("vgui/white"))
	surface.SetDrawColor(radar.bgcolor.r,radar.bgcolor.g,radar.bgcolor.b,radar.bgcolor.a*radar.alphascale)
	surface.DrawPoly(vertices)
    draw.RoundedBox( 0, radar.x+radar.w/2, radar.y, 1, radar.h, color_ascale(radar.fgcolor,radar.alphascale) )
	draw.RoundedBox( 0, radar.x, radar.y+radar.h/2, radar.w, 1, color_ascale(radar.fgcolor,radar.alphascale) )
		
	local players = {}

	for i = 1, 1000 do -- Because running a loop 1000 times per frame ensures major luls.  Also ents.GetInSphere is serverside. (which sucks major donkey balls.)

			local ent = ents.GetByIndex(i)

			if ent:IsValid() then
				local type = ent:GetClass()

				for k, v in ipairs(radar.scanfor) do
					if string.find(type,v) then
						table.insert(players,ent)
					end
				end
			end
		end

		for i, pl in ipairs(players) do
			local cx = radar.x+radar.w/2
			local cy = radar.y+radar.h/2
			local vdiff = pl:GetPos()-lpl:GetPos()
			local dummy = nil   -- Because I'm lazy.


	-- Player Check.
			if (vdiff:Length() > radar.radius) then dummy = nil else -- In soviet russia, code badly you!
				if pl:IsPlayer() then
				if( PDAPlayers[ pl:EntIndex() ] == true ) then
			//	print( pl:GetModel() )
			//	if pl:GetModel() != radar.mutantmodels then
				local r,g,b,a = pl:GetColor();
				if a != 0 then
					--if( pl:HasItem( "pda" ) )  then
					if ( pl:Alive() and lpl~=pl ) then
						local px = (vdiff.x/radar.radius)
						local py = (vdiff.y/radar.radius)
						local z = math.sqrt( px*px + py*py )
						local phi = math.Deg2Rad( math.Rad2Deg( math.atan2( px, py ) ) - math.Rad2Deg( math.atan2( lpl:GetAimVector().x, lpl:GetAimVector().y ) ) - 90 )
						px = math.cos(phi)*z
						py = math.sin(phi)*z
					local tracedata = {}
					tracedata.start = lpl:GetShootPos()
					tracedata.endpos = pl:EyePos()
					tracedata.filter = lpl
					tracedata.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_PLAYERCLIP			
					local trace = util.TraceLine(tracedata)
					
					


					

						if( !trace.Hit )  then
						draw.RoundedBox( 4, cx+px*radar.w/2-4, cy+py*radar.h/2-4, 8, 8, color_ascale(radar.player_color,radar.alphascale) )
						end	
					end	
					end
				 end
			end
end


	-- Ent Check.
				if ((not pl:IsPlayer()) and pl:IsValid() ) then

				if( PDAPlayers[ pl:EntIndex() ] == true ) then
					
					local px = (vdiff.x/radar.radius)
					local py = (vdiff.y/radar.radius)
					local z = math.sqrt( px*px + py*py )
					local phi = math.Deg2Rad( math.Rad2Deg( math.atan2( px, py ) ) - math.Rad2Deg( math.atan2( lpl:GetAimVector().x, lpl:GetAimVector().y ) ) - 90 )
					px = math.cos(phi)*z
					py = math.sin(phi)*z
					local tracedata = {}
					tracedata.start = lpl:GetShootPos()
					tracedata.endpos = pl:EyePos()
					tracedata.filter = lpl
					tracedata.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER
					local trace = util.TraceLine(tracedata)
					
					


					

						if( !trace.Hit )  then
							
							draw.RoundedBox( 4, cx+px*radar.w/2-4, cy+py*radar.h/2-4, 8, 8, color_ascale(radar.player_color,radar.alphascale) )
						end
					end
				//end
				
   			end
	 	end
	 	

   -- This is where things get hacky.  Well, more hacky.
   
   		local count = table.Count(ETable)
   		
   		if ( count > 0 ) then 	-- Oooooh shit.
   		for k,pl in ipairs(ETable) do
   			local cx = radar.x+radar.w/2
			local cy = radar.y+radar.h/2
			local vdiff = pl:GetPos()-lpl:GetPos()
			
   			local px = (vdiff.x/radar.radius)
			local py = (vdiff.y/radar.radius)
			local z = math.sqrt( px*px + py*py )
			local phi = math.Deg2Rad( math.Rad2Deg( math.atan2( px, py ) ) - math.Rad2Deg( math.atan2( lpl:GetAimVector().x, lpl:GetAimVector().y ) ) - 90 )
			px = math.cos(phi)*z
			py = math.sin(phi)*z
			
			draw.RoundedBox( 8, (cx+px*radar.w/2-8), (cy+py*radar.h/2-8), 16, 16, color_ascale(radar.dangerblipcolour,radar.alphascale) ) -- M-M-MONSTER DOT.
		end
			
			radar.bgcolor = Color(255,255,255,0)
			radar.fgcolor = Color(60,60,60,100)
			
			PulseRadar = true
			
			
 			
		end
		
		
		CD_Radar_pulse(PulseRadar)
		
	end
/*	local client = LocalPlayer()
	local hea1 = client:Health() / 10
	local hea1 = math.Round(hea1)
	 healthtext = " "
	for i=1,hea1 do 
		healthtext = string.Implode("", {healthtext, "|" })
	end 

	local struc = {}
	struc.pos = {}
	struc.pos[1] = 100 -- x pos
	struc.pos[2] = 200 -- y pos
	struc.color = Color(255,0,0,255) -- Red
	struc.text = healthtext
	struc.font = "DefaultFixed" -- Font
	struc.xalign = TEXT_ALIGN_CENTER -- Horizontal Alignment
	struc.yalign = TEXT_ALIGN_CENTER -- Vertical Alignment
	draw.Text( struc )
	lplpos = LocalPlayer():GetPos()
	local CamData = {}
	CamData.angles = Angle(90, 0, 0 )
	CamData.origin = Vector( lplpos.x, lplpos.y,lplpos.z + 500)
	CamData.x = 0
	CamData.y = 0
	CamData.orthotop = 1
	CamData.w = ScrW() * 0.3
	CamData.h = ScrH() * 0.3

	render.RenderView( CamData )*/

	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetTexture( Radar );
	surface.DrawTexturedRect( placement,placement , convar1:GetFloat(), convar1:GetFloat() );
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetTexture( Compass12 );
	surface.DrawTexturedRectRotated( placement + ( convar1:GetFloat() / 9.3) ,placement + ( convar1:GetFloat() / 9.3) , convar1:GetFloat() / 4, convar1:GetFloat() / 4, LocalPlayer():GetAngles().y );
end
end
  end
 healthtext = " "

function CD_Radar_pulse(var)

	if ( var ) then

	-- Let's figure out the colour shift.
		local diff = {}
		diff.r = radar.dangercolour.r - radar.bgcolorbak.r
		diff.g = radar.dangercolour.g - radar.bgcolorbak.g
		diff.b = radar.dangercolour.b - radar.bgcolorbak.b

	
	-- Now let's throw sine at it and see what happens.	
		radar.bgcolor = Color( ((0.5*math.sin(CurTime()*2)+0.51)*diff.r), ((0.5*math.sin(CurTime()*2)+0.51)*diff.g), ((0.5*math.sin(CurTime()*2)+0.51)*diff.b), 255 ) -- 0.51... lol.
	

	-- Contrasting the crosshair thingy.
		radar.fgcolor = Color( 255-radar.bgcolor.r, 255-radar.bgcolor.g, 255-radar.bgcolor.b, 255 )
	
	
	-- Greying out the 'passive' blips.
		radar.player_color = Color(160,160,160,100)
	
	-- DEBUGGING WHAT
--		draw.DrawText(radar.bgcolor.r, "Default", ScrW() - 400, 300, color_ascale(radar.player_fontcolor,radar.alphascale), TEXT_ALIGN_CENTER)
--		draw.DrawText(radar.bgcolor.g, "Default", ScrW() - 400, 340, color_ascale(radar.player_fontcolor,radar.alphascale), TEXT_ALIGN_CENTER)
--		draw.DrawText(radar.bgcolor.b, "Default", ScrW() - 400, 380, color_ascale(radar.player_fontcolor,radar.alphascale), TEXT_ALIGN_CENTER)
		
--		draw.DrawText(diff.r, "Default", ScrW() - 300, 300, color_ascale(radar.player_fontcolor,radar.alphascale), TEXT_ALIGN_CENTER)
--		draw.DrawText(diff.g, "Default", ScrW() - 300, 340, color_ascale(radar.player_fontcolor,radar.alphascale), TEXT_ALIGN_CENTER)
--		draw.DrawText(diff.b, "Default", ScrW() - 300, 380, color_ascale(radar.player_fontcolor,radar.alphascale), TEXT_ALIGN_CENTER)
	
	else
		if ( radar.bgcolor ~= radar.bgcolorbak ) then

   		 	radar.bgcolor = radar.bgcolorbak
			radar.fgcolor = radar.fgcolorbak
			radar.player_color = radar.player_colorbak
	
		end
	
	end
end


function CD_Radar_cc_radarvar_autocomplete ( command, args )
	argv = string.Explode(" ",string.sub(args,2))
	--Msg("Autocomplete args: '"..string.sub(args,2).."' argc: "..table.getn(argv).."\n")
	if (table.getn(argv)>1) then if (radar[argv[1]]~=nil) then return {command.." "..argv[1].." "..radar[argv[1]]} else return {} end end
	local ret = {}
	for k,v in pairs(radar) do
		table.insert(ret,command.." "..k)
	end
	return ret
end

function CD_Radar_cc_radarvar ( pl, command, args )
	--Msg(type(args).."\n")
	--argv = string.Explode(" ",string.sub(args,2))
	if ( table.getn(args) < 1 ) then Msg(HUD_PRINTCONSOLE,"No var given!\n"); return end
	if ( radar[args[1]] == nil ) then Msg(HUD_PRINTCONSOLE,"Unknown radar var '"..args[1].."'!\n"); return end
	if ( table.getn(args) < 2 ) then Msg(HUD_PRINTCONSOLE,"No value given!\n"); return end
	radar[args[1]] = tonumber(args[2])
end

concommand.Add( "CD_radarvar", CD_Radar_cc_radarvar, CD_Radar_cc_radarvar_autocomplete )

texsize2h = 756
texsize2w = 1050
Box2H = texsize2h / 2
ChatBox = surface.GetTextureID( "hgn/srp/ui/ChatBox" );
function CD_DrawChatBox()
	local IsVisible = RAD_Chat.Derma.Panel:IsVisible()
	
	-- Check Is Visible.
	if (IsVisible) then
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetTexture( ChatBox );
	surface.DrawTexturedRect( 0, ScrH() - (ScrH() / 1.9) , 1050 , ScrH() / 1.35 );
	end
end
hook.Add( "HUDPaint", "CD_DrawChatBox", CD_DrawChatBox ) 


hook.Add( "HUDPaint", "CD_DrawRadar", CD_DrawRadar )

////////////////

WEATHER={
	["sunny"]={
		Brightness=0,
		Contrast=1,
		Colour=1,
		Precipitation=0,
		SoundLevel=3.9,
		Pitch=100,
	},
	["cloudy"]={
		Brightness=0,
		Contrast=1,
		Colour=0.6,
		Precipitation=0,
		SoundLevel=3.9,
		Pitch=100,
	},
	["rain"]={
		Brightness=-0.07,
		Contrast=0.9,
		Colour=0.4,
		Precipitation=10,
		SoundLevel=3.9,
		Pitch=100,
		Sound="ambient/weather/rumble_rain_nowind.wav",
	},
	["heavyrain"]={
		Brightness=-0.07,
		Contrast=0.9,
		Colour=0.4,
		Precipitation=15,
		SoundLevel=3.9,
		Pitch=100,
		Sound="ambient/weather/rumble_rain_nowind.wav",
	},
	["sunnyrain"]={
		Brightness=0,
		Contrast=0.7,
		Colour=1.2,
		Precipitation=10,
		SoundLevel=3.9,
		Pitch=100,
		Sound="ambient/weather/rumble_rain_nowind.wav",
	},
	["storm"]={
		--Brightness=-0.15,
		--Contrast=0.7,
		--Colour=0.1,
		Brightness=0,
		Contrast=0.3,
		Colour=1,
		Precipitation=30,
		SoundLevel=2.9,
		Pitch=100,
		Sound="ambient/weather/rumble_rain.wav",
	},
	["dark"]={
		Brightness=0,
		Contrast=0.25,
		Colour=1,
		Precipitation=0,
		SoundLevel=2.9,
		Pitch=100,
	    Sound="hgn/stalker/background/night_bkg_1.wav",
	},
	["morning"]={
		Brightness=0,
		Contrast=0.7,
		Colour=1,
		Precipitation=0,
		SoundLevel=2.9,
		Pitch=100,
	    Sound="hgn/stalker/background/night_bkg_1.wav",
	},
	["darkrain"]={
		Brightness=0,
		Contrast=0.3,
		Colour=1,
		Precipitation=5,
		SoundLevel=3.9,
		Pitch=100,
		Sound="ambient/weather/rumble_rain_nowind.wav",
	},
}


local CurWeather={
		Brightness=0,
		Contrast=1,
		Colour=1,
		Precipitation=0,
		Pitch=100,
		SoundLevel=3.9,
		Pitch=100,
}

SetGlobalString("weather","sunny")

local WeatherSound=nil
local PrevWeather="sunny"
local LastLightning=0
 local bright = CreateClientConVar("rp_b", "240")
 local green = CreateClientConVar("rp_g", "320")
 local cont = CreateClientConVar("rp_c", "1")
 local colo = CreateClientConVar("rp_co", "1") 

Tracecontents = CONTENTS_SOLID
function WeatherOverlay()


	if render.GetDXLevel() < 80 then return end

	local WeatherName=GetGlobalString("weather")
	
	if not WeatherName or not WEATHER[WeatherName] then WeatherName="sunny" end
	
	local traced = {}
	traced.start = LocalPlayer():GetPos()
	traced.endpos = LocalPlayer():GetPos()+Vector(0,0,700)
	traced.mask = Tracecontents
	local tr=util.TraceLine(traced)
	
	if tr.HitWorld then
		CurWeather.Brightness=math.Approach( CurWeather.Brightness, math.Clamp(WEATHER[WeatherName].Brightness,0,5), 0.01 )
		CurWeather.Contrast=math.Approach( CurWeather.Contrast, math.Clamp(WEATHER[WeatherName].Contrast,1,5), 0.01 )
		CurWeather.Colour=math.Approach( CurWeather.Colour, math.Clamp(WEATHER[WeatherName].Colour,1,5), 0.01 )
	else
	
		CurWeather.Brightness=math.Approach( CurWeather.Brightness, WEATHER[WeatherName].Brightness, 0.01 )
		CurWeather.Contrast=math.Approach( CurWeather.Contrast, WEATHER[WeatherName].Contrast, 0.01 )
		CurWeather.Colour=math.Approach( CurWeather.Colour, WEATHER[WeatherName].Colour, 0.01 )
	
	end
	
	 CurWeather.Precipitation=math.Approach( CurWeather.Precipitation, math.Clamp(WEATHER[WeatherName].Precipitation,0,25), 0.01 )  
	if nightvision == true then
	local nightcol = {}
	nightcol[ "$pp_colour_addr" ] 		= 0
	nightcol[ "$pp_colour_addg" ] 		= 1
	nightcol[ "$pp_colour_addb" ] 		= 0
	nightcol[ "$pp_colour_brightness" ]=  .1
	nightcol[ "$pp_colour_contrast" ] 	=  .5
	nightcol[ "$pp_colour_colour" ] 	=  .8
	nightcol[ "$pp_colour_mulr" ] 		= 0
	nightcol[ "$pp_colour_mulg" ] 		= 0
	nightcol[ "$pp_colour_mulb" ] 		= 0
	DrawColorModify(nightcol)
	else
	local ScrColTab = {}
	ScrColTab[ "$pp_colour_addr" ] 		= 0
	ScrColTab[ "$pp_colour_addg" ] 		= 0
	ScrColTab[ "$pp_colour_addb" ] 		= 0
	ScrColTab[ "$pp_colour_brightness" ]= CurWeather.Brightness
	ScrColTab[ "$pp_colour_contrast" ] 	= CurWeather.Contrast
	ScrColTab[ "$pp_colour_colour" ] 	= CurWeather.Colour
	ScrColTab[ "$pp_colour_mulr" ] 		= 0
	ScrColTab[ "$pp_colour_mulg" ] 		= 0
	ScrColTab[ "$pp_colour_mulb" ] 		= 0
	DrawColorModify(ScrColTab)
	end
	
	if not PrevWeather or PrevWeather~=WeatherName then
		if WeatherSound then WeatherSound:Stop() end
		if WEATHER[WeatherName].Sound then
			WeatherSound=CreateSound(LocalPlayer(),WEATHER[WeatherName].Sound)
			WeatherSound:Play()
			PrevWeather=WeatherName
		else
			WeatherSound=nil
		end
	end
	
	if CurTime()>LastLightning and  CurWeather.Precipitation>10 then
		if math.random(1,20)==10 then
			LastLightning=CurTime()+30
			CurWeather.Contrast=5
			timer.Simple(0.2,function()
				CurWeather.Contrast=WEATHER[WeatherName].Contrast
			end)
			timer.Simple(3,function()
				surface.PlaySound(Format("ambient/atmosphere/thunder%i.wav",math.random(1,4)))
			end)
		end
	end
	
	if WeatherSound and tr.HitWorld or (WeatherSound and LocalPlayer():InVehicle()) then
		CurWeather.SoundLevel=math.Approach( CurWeather.SoundLevel, 2, 0.195 )
		CurWeather.Pitch=math.Approach( CurWeather.Pitch, 50, 2 )
		WeatherSound:SetSoundLevel(CurWeather.SoundLevel)
		WeatherSound:ChangePitch(CurWeather.Pitch)
	elseif WeatherSound then
		CurWeather.SoundLevel=math.Approach( CurWeather.SoundLevel, 3.9, 0.195 )
		CurWeather.Pitch=math.Approach( CurWeather.Pitch, 100, 2 )
		WeatherSound:SetSoundLevel(CurWeather.SoundLevel)
		WeatherSound:ChangePitch(CurWeather.Pitch)
	end
/*	if( !nightvision ) then return;  end
	if nightvision == true then
	local nightcol = {}
	nightcol[ "$pp_colour_addr" ] 		= 0
	nightcol[ "$pp_colour_addg" ] 		= .15
	nightcol[ "$pp_colour_addb" ] 		= 0
	nightcol[ "$pp_colour_brightness" ]= .25
	nightcol[ "$pp_colour_contrast" ] 	= 1.2
	nightcol[ "$pp_colour_colour" ] 	= 1
	nightcol[ "$pp_colour_mulr" ] 		= 0
	nightcol[ "$pp_colour_mulg" ] 		= 0
	nightcol[ "$pp_colour_mulb" ] 		= 0
	DrawColorModify(nightcol)
	end */
end


local LastEffect=0
hook.Add("RenderScreenspaceEffects", "WeatherOverlay", WeatherOverlay)
function WeatherThink()
	local WeatherName=GetGlobalString("weather")
	if not WeatherName or not WEATHER[WeatherName] then WeatherName="sunny" end
	if CurWeather.Precipitation>0 then
		if CurTime()>LastEffect then
			LastEffect=CurTime()+1
			local eff=EffectData()
				eff:SetMagnitude(CurWeather.Precipitation)
			util.Effect("rain",eff)
		end
	end
end
hook.Add("Think","",WeatherThink)
nightvision = false
function RecNVum ()
    if( nightvision == true ) then
    nightvision = false
    else
    nightvision = true
    end
end
usermessage.Hook("RecNVum", RecNVum )


