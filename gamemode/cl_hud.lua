-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- cl_hud.lua 
-- General HUD stuff.
-------------------------------
LocalPlayer( ).MyModel = "";

surface.CreateFont( "ChatFont", 22, 100, true, false, "PlInfoFont" );
surface.CreateFont( "ChatFont", 32, 500, true, false, "AmmoFont" );
surface.CreateFont( "TargetID", 14, 500, true, false, "AmmoNameFont" );
surface.CreateFont( "ChatFont", 24, 500, true, false, "HUDFont" );
surface.CreateFont( "coolvetica", 48, 500, true, false, "MelonLarge" )
surface.CreateFont( "coolvetica", 26, 500, true, false, "MelonMedium" )
surface.CreateFont( "Courier New", 22, 100, true, false, "PlInfoFont" );
surface.CreateFont( "Tahoma", 22, 100, true, false, "PlInfoFont" );
surface.CreateFont( "Tahoma", 32, 500, true, false, "AmmoFont" );
surface.CreateFont( "Tahoma", 14, 500, true, false, "AmmoNameFont" );
surface.CreateFont( "Tahoma", 12, 600, true, false, "TinyFont" );
surface.CreateFont( "coolvetica", 80, 600, true, false, "MelonHuge" );
surface.CreateFont( "coolvetica", 80, 600, true, false, "Watermark" );
surface.CreateFont( "Tahoma", 15, 100, true, false, "Visitor -BRK-" );
surface.CreateFont( "Tahoma", 20, 100, true, false, "TimeFont" );
surface.CreateFont("stalker2", 12, 600, true, false, "RAD_Chat_MainText")

function DrawAmmoInfo( )
end

local function DrawTime( )

	--draw.DrawText( GetGlobalString( "time" ), "PlInfoFont", 10, 10, Color( 255,255,255,255 ), 0 );
	
end

function DrawTargetInfo( )
	
	local tr = LocalPlayer( ):GetEyeTrace( )
	if( !tr.HitNonWorld ) then return; end
	
	if( tr.Entity:GetClass( ) == "item_prop" and tr.Entity:GetPos( ):Distance( LocalPlayer( ):GetPos( ) ) < 100 ) then

		local screenpos = tr.Entity:GetPos( ):ToScreen( )
		draw.DrawText( tr.Entity:GetNWString( "Name" ), "stalkersmall", screenpos.x + 2, screenpos.y + 2, Color( 0, 0, 0, 255 ), 1 );	
		draw.DrawText( tr.Entity:GetNWString( "Name" ), "stalkersmall", screenpos.x, screenpos.y, Color( 255, 255, 255, 255 ), 1 );
		draw.DrawText( tr.Entity:GetNWString( "Description" ), "stalkersmall", screenpos.x + 2, screenpos.y + 22, Color( 0, 0, 0, 255 ), 1 );	
		draw.DrawText( tr.Entity:GetNWString( "Description" ), "stalkersmall", screenpos.x, screenpos.y + 20, Color( 255, 255, 255, 255 ), 1 );

	end
	
end
		
function GM:HUDShouldDraw( name )

	if( LocalPlayer( ):GetNWInt( "charactercreate" ) == 1 or LocalPlayer( ):GetNWInt( "charactercreate" ) == nil ) then return false; end
	
	local nodraw = 
	{ 
		"CHudHealth",
		"CHudAmmo",
		"CHudSecondaryAmmo",
		"CHudBattery",
	 }
	
	for k, v in pairs( nodraw ) do
	
		if( name == v ) then return false; end
	
	end

	return true;

end

local pnlBlackVGUI = vgui.RegisterFile( "vgui_blackscene.lua" )
local BlackVGUI = vgui.CreateFromTable( pnlBlackVGUI )

function DrawDeathHUD( )

	BlackVGUI:SetWinner( " ", 15 )
	BlackVGUI:Show()
	
	timer.Simple( 14, function() 
	BlackVGUI:Hide(); 
	ShowingDeathMode = 0 
	end )
	
end

function DrawOOCInfo( )
for k, v in pairs( player.GetAll( ) ) do	
		if( v != LocalPlayer( ) ) then

		    local tr = LocalPlayer( ):GetEyeTrace( )
			local position = v:GetPos( )
			local position = Vector( position.x, position.y, position.z + 75 )
			local screenpos = position:ToScreen( )

				if( v:GetNWInt( "faggot" ) == 1 ) then
				
				draw.DrawText( "WARNING - FAGGOT", "stalkersmall", screenpos.x, screenpos.y - 80, Color( 255, 0, 228, 255 ), 1 )

				end
				
				if( v:GetNWInt( "rave" ) == 1 ) then
				
				draw.DrawText( "RAVE", "MelonLarge", screenpos.x, screenpos.y - 80, Color( 0, 0, 255, 255 ), 1 )
				
				end
		end
end

end

function DrawPlayerInfo( ply )
	
	local position = ply:GetPos( )
	local position = Vector( position.x, position.y, position.z + 75 )
	local screenpos = position:ToScreen( )

	if( !ply:Alive( ) ) then return; end

	draw.DrawText( ply:Nick( ), "stalkersmall", screenpos.x, screenpos.y, Color( 255, 255, 255, alpha ), 1 )
	draw.DrawText( team.GetName( ply:Team( ) ), "stalkersmall", screenpos.x, screenpos.y + 10, Color( 255, 255, 255, alpha ), 1 )
	draw.DrawText( ply:GetNWString( "title" ), "stalkersmall", screenpos.x, screenpos.y + 20, Color( 255, 255, 255, alpha ), 1 )
				
	if( ply:GetNWInt( "chatopen" ) == 1 ) then
				
		draw.DrawText( "Typing..", "stalkersmall", screenpos.x, screenpos.y - 50, Color( 255, 255, 255, alpha ), 1 )
				
	end
				
	if( ply:GetNWInt( "tiedup" ) == 1 ) then
				
		draw.DrawText( "Tied Up", "stalkersmall", screenpos.x, screenpos.y - 30, Color( 255, 0, 0, alpha ), 1 )
				
	end
	
end

function DrawHudShit( )

	if( LocalPlayer():Alive() and LocalPlayer():Armor() > 0 ) then

	draw.RoundedBox( 2, 10, ScrH() - 30, 60, 25, Color( 0, 0, 0, 190 ) );
	draw.DrawText( "%"..LocalPlayer():Armor(), "stalkersmall", 65, ScrH() - 30, Color( 255, 255, 255, 255 ), 2 );
	
	end

end

--[[
function DrawBars()
	draw.RoundedBox( 2, 20, ScrH() - 170, 15, 150, Color( 0, 0, 0, 190 ) );
	
	if( LocalPlayer():Alive() ) then
		draw.RoundedBox( 2, 22, ScrH() - 168 + 146 * ( ( 100 - LocalPlayer():Health() ) / 100 ), 11, 146 * ( LocalPlayer():Health() / 100 ), Color( 150, 0, 0, 185 ) );
		draw.RoundedBox( 2, 27, ScrH() - 168 + 146 * ( ( 100 - LocalPlayer():Health() ) / 100 ), 4, 146 * ( LocalPlayer():Health() / 100 ), Color( 255, 100, 100, 70 ) );
	end
		
	draw.RoundedBox( 2, 40, ScrH() - 170, 15, 150, Color( 0, 0, 0, 190 ) );
	
	if( LocalPlayer():Armor() > 0 ) then
		draw.RoundedBox( 2, 42, ScrH() - 168 + 146 * ( ( 100 - LocalPlayer():Armor() ) / 100 ), 11, 146 * ( LocalPlayer():Armor() / 100 ), Color( 0, 0, 150, 185 ) );
		draw.RoundedBox( 2, 47, ScrH() - 168 + 146 * ( ( 100 - LocalPlayer():Armor() ) / 100 ), 4, 146 * ( LocalPlayer():Armor() / 100 ), Color( 100, 100, 255, 70 ) );
	end
end	
--]]
local TOPBAR = {}

function TOPBAR:Init()
	self:SetMouseInputEnabled(false)
end

function TOPBAR:PerformLayout()
	self:SetPos( 0, 0 )
	self:SetSize( ScrW(), 24 )
end

function TOPBAR:ApplySchemeSettings()
end
  local mat = surface.GetTextureID( "hgn/srp/ui/box1" );

function TOPBAR:Paint()
	local client = LocalPlayer()
	local money = client:GetNetworkedInt( "money" )
	
	local length     = -3 --should make 5 w/ spacer
	local spacer     = 25
	
	surface.SetFont( "Default" )
	surface.SetTexture( mat );
	 surface.SetDrawColor( 255, 255, 255, 255)
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect(0, 0, ScrW(), 24)
//	draw.RoundedBox(0, 0, 24, ScrW(), 2, Color(255, 255, 255, 255))
	
	surface.SetTextPos( length + spacer, 5 )
		if( LocalPlayer():Nick() ) then
		surface.DrawText("Name: " .. LocalPlayer():Nick())
		local x, y = surface.GetTextSize("Name: " .. LocalPlayer():Nick())
		moneypos = ( length + spacer + (x / 2) )
		length = length + x + spacer
		end
		
	surface.SetTextPos( length + spacer, 5 )
		surface.DrawText("Health: " .. LocalPlayer():Health())
		local x, y = surface.GetTextSize("Health: " .. LocalPlayer():Health())
		moneypos = ( length + spacer + (x / 2) )
		length = length + x + spacer
	if( LocalPlayer():Armor() > 0 ) then
	surface.SetTextPos( length + spacer, 5 )
		surface.DrawText("Armor: " .. LocalPlayer():Armor())
		local x, y = surface.GetTextSize("Armor: " .. LocalPlayer():Armor())
		moneypos = ( length + spacer + (x / 2) )
		length = length + x + spacer
	end
	surface.SetTextPos( length + spacer, 5 )
		surface.DrawText("Flagged: " .. team.GetName(LocalPlayer():Team()))
		local x, y = surface.GetTextSize("Association: " .. team.GetName(LocalPlayer():Team()))
		moneypos = ( length + spacer + (x / 2) )
		length = length + x + spacer

	surface.SetTextPos( length + spacer, 5 )
		surface.DrawText( "Money: " .. money .. " RU" )
		local x, y = surface.GetTextSize( "Money: " .. tostring(money) .. " RU" )
		moneypos = ( length + spacer + (x / 2) )
		length = length + x + spacer
	
	surface.SetTextPos( length + spacer, 5 )
		surface.DrawText("Title: " .. LocalPlayer():GetNWString("title"))
		local x, y = surface.GetTextSize("Title: " .. LocalPlayer():GetNWString("title"))
		length = length + x + spacer	
end
vgui.Register("AS Top Bar", TOPBAR, "Panel")
topbar = vgui.Create( "AS Top Bar" )
//timer.Simple( 2, StartTopBar )
timer.Simple( 5, function() topbar:SetVisible( true ) end )

//function StartTopBar()
//topbar = vgui.Create( "AS Top Bar" )
//end

if ( !CLIENT ) then return end

local HUD	=	{}


HUD.Fade		=	8		
HUD.FadePoint	=	7

HUD.DrawTarget	=	false
HUD.DrawPData	=	true

HUD.DisplayWebsite	=	false

HUD.ColorHealth	=	{ r = 200, g = 0, b = 0 }
HUD.ColorArmor	=	{ r = 0, g = 0, b = 200  }


HUD.x = ScrW() * 0.026
HUD.y = ScrH() - (ScrH() * 0.076)

HUD.Weapons		=	{

	weapon_pistol	=	"18",
	weapon_357		=	"6",
	weapon_smg1		=	"45",
	weapon_ar2		=	"30",
	weapon_shotgun	=	"6",
	weapon_crossbow	=	"1",

}

HUD.Tools		=	{
	"weapon_physcannon",
	"weapon_physgun",
	"gmod_tool"

}

HUD.NDraw	=	{
	"CHudHealth",
	"CHudBattery",
	"CHudAmmo",
	"CHudSecondaryAmmo",
	"CHudChat"

}

function HUD.Initialize()
	timer.Simple(1, function()
		
		
		function GAMEMODE:HUDDrawTargetID() end
		
	end)
end

function HUD.ShouldDrawHUD(info) --Hide stuff
	if ( table.HasValue(HUD.NDraw, info) ) then
		return false
	end
end

function HUD.DrawAll()
	if ( !LocalPlayer():Alive() ) then return end
	
	if ( LocalPlayer():KeyDown(IN_RELOAD) ) then
		local Time = CurTime() + HUD.Fade
		
		HUD.STime, HUD.WTime = Time, Time
	end
	
	HUD.DrawState()		
	HUD.DrawAmmo()		
	HUD.DrawTrace()		
end


function HUD.IntFormat(A, B)
	if ( A && B ) then
		

		return string.format("%0" .. A .. "d", B)
	end
end

function HUD.Alpha(Time)
	return ( -( ( HUD.Fade - HUD.FadePoint ) / math.max( Time - CurTime(), 0.001 ) ) - HUD.Fade ) * 255
end


function HUD.DrawState()
	if ( !HUD.HP || LocalPlayer():Health() ~= HUD.HP ) then
		HUD.HP		=	LocalPlayer():Health()
		HUD.STime	=	CurTime() + HUD.Fade
	end
	
	if ( !HUD.AR || LocalPlayer():Armor() ~= HUD.AR ) then
		HUD.AR		=	LocalPlayer():Armor()
		HUD.STime	=	CurTime() + HUD.Fade
	end
	
	
	if ( (HUD.STime - CurTime()) > HUD.Fade - HUD.FadePoint ) then
		
		local a = HUD.Alpha(HUD.STime)
		local h = math.Clamp(HUD.HP, 1, 100) / 100
		
		draw.RoundedBox(0, HUD.x - 1, HUD.y - 8, 112, 8, Color(0, 0, 0, a))
		draw.RoundedBox(0, HUD.x, HUD.y - 7, h * 110, 6, Color(HUD.ColorHealth.r, HUD.ColorHealth.g, HUD.ColorHealth.b, a))
		
		draw.SimpleTextOutlined("HEALTH " .. string.format("%3d", math.max(HUD.HP, 0)) .. "%", "Default", HUD.x, HUD.y - 22, Color(255, 255, 255, a), 0, 0, 1, Color(0, 0, 0, a))
		
		if ( HUD.AR > 0 ) then
			local r = math.Clamp(HUD.AR, 1, 100) / 100

			draw.RoundedBox(0, HUD.x - 1, HUD.y, 112, 4, Color(0, 0, 0, a))
			draw.RoundedBox(0, HUD.x, HUD.y + 1, r * 110, 2, Color(HUD.ColorArmor.r, HUD.ColorArmor.g, HUD.ColorArmor.b, a))
		end
	end
end

function HUD.DrawAmmo()
	
	local Weapon = LocalPlayer():GetActiveWeapon()
	
	if ( Weapon:IsWeapon() ) then
		if ( !HUD.Clip_1 || Weapon:Clip1() ~= HUD.Clip_1 ) then
			HUD.Clip_1		=	Weapon:Clip1()
			HUD.WTime		=	CurTime() + HUD.Fade
		end
		
		if ( !HUD.Clip_2 || LocalPlayer():GetAmmoCount(Weapon:GetSecondaryAmmoType()) ~= HUD.Clip_2 ) then
			HUD.Clip_2		=	LocalPlayer():GetAmmoCount(Weapon:GetSecondaryAmmoType())
			HUD.WTime		=	CurTime() + HUD.Fade
		end
		
		if ( !HUD.Ammo_1 || LocalPlayer():GetAmmoCount(Weapon:GetPrimaryAmmoType()) ~= HUD.Ammo_1 ) then
			HUD.Ammo_1		=	LocalPlayer():GetAmmoCount(Weapon:GetPrimaryAmmoType())
			HUD.WTime		=	CurTime() + HUD.Fade
		end
		
		
		if ( (HUD.WTime - CurTime()) > HUD.Fade - HUD.FadePoint ) then
			if ( Weapon:GetClass() ~= "weapon_physcannon" ) then
				
				local a = HUD.Alpha(HUD.WTime)
				local Ammo1	=	HUD.IntFormat(3, HUD.Ammo_1)
				
				if ( HUD.Clip_1 ~= -1 ) then
					if ( HUD.Weapons[Weapon:GetClass()] ) then
						HUD.MaxClip = #HUD.Weapons[Weapon:GetClass()]
						
						
					elseif ( Weapon.Primary.ClipSize ) then
						HUD.MaxClip = #tostring(Weapon.Primary.ClipSize) --I has to tostring it to get the digit length
						
						
					end
					
					local Clip	=	HUD.IntFormat(HUD.MaxClip, HUD.Clip_1)
					
					
					if ( HUD.Clip_2 > 0 ) then
						local Ammo2	=	HUD.IntFormat(2, HUD.Clip_2)
						
	
						draw.SimpleTextOutlined(string.format("AMMO %s/%s | %s", Clip, Ammo1, Ammo2), "Default", HUD.x, HUD.y + 8, Color(255, 255, 255, a), 0, 0, 1, Color(0, 0, 0, a))
						
						return
					end
					

					draw.SimpleTextOutlined(string.format("AMMO %s/%s", Clip, Ammo1), "Default", HUD.x, HUD.y + 8, Color(255, 255, 255, a), 0, 0, 1, Color(0, 0, 0, a))
					
				elseif ( HUD.Ammo_1 > 0 ) then
					

					draw.SimpleTextOutlined(string.format("AMMO %s", Ammo1), "Default", HUD.x, HUD.y + 8, Color(255, 255, 255, a), 0, 0, 1, Color(0, 0, 0, a))
					
				end
			end
		end
	end
end

function HUD.DrawTrace()
	
	local trace = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	
	if ( ValidEntity(trace.Entity) ) then
		if ( trace.Entity:IsPlayer() ) then
			if ( !HUD.DrawTarget ) then return end
			
			local p		=	{ x = ScrW() / 2, y = ScrH() / 2 }
			local y 	=	0
			
			
			if ( gmod.GetGamemode().Name == "Sandbox" || GM.IsSandboxDerived ) then
				if ( HUD.DisplayWebsite && string.len(trace.Entity:GetWebsite()) > 0 ) then
					y = 10
					
					draw.SimpleTextOutlined(tostring(trace.Entity:GetWebsite()), "DefaultSmall", p.x, p.y + 32, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 0, 0.8, Color(0, 0, 0, 200))
				end
			end
			
			draw.SimpleTextOutlined(trace.Entity:Name() .. " " .. math.max(trace.Entity:Health(), 0) .. "%", "Default", p.x, p.y + 18, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, 0, 1, Color(0, 0, 0, 200))
			
			local h = math.Clamp(trace.Entity:Health(), 1, 100) / 100
			
			draw.RoundedBox(0, p.x - 31, p.y + 38 + y, 60, 4, Color(0, 0, 0, 200))
			draw.RoundedBox(0, p.x - 30, p.y + 39 + y, h * 58, 2, Color(HUD.ColorHealth.r, HUD.ColorHealth.g, HUD.ColorHealth.b, 255))
			
			if ( trace.Entity:Armor() > 0 ) then
				local r = math.Clamp(trace.Entity:Armor(), 1, 100) / 100
				
				draw.RoundedBox(0, p.x - 31, p.y + 42 + y, 60, 2, Color(0, 0, 0, 200))
				draw.RoundedBox(0, p.x - 30, p.y + 42 + y, r * 58, 1, Color(HUD.ColorArmor.r, HUD.ColorArmor.g, HUD.ColorArmor.b, 255))
			end
			
		elseif ( HUD.DrawPData && ValidEntity(LocalPlayer():GetActiveWeapon()) && table.HasValue(HUD.Tools, LocalPlayer():GetActiveWeapon():GetClass()) ) then --Only draw if we have a tool out
			local EntData = { --I has to tostring all dis har shat
				class	= tostring(trace.Entity:GetClass()),	--Class Name
				index	= tostring(trace.Entity:EntIndex()),	--Index
				model	= tostring(trace.Entity:GetModel()),	--Model
				angle	= string.Replace(tostring(trace.Entity:GetAngles()), " ", ", "),	--Angles
				wpos	= string.Replace(tostring(trace.Entity:LocalToWorld(trace.Entity:OBBCenter())), " ", ", ")	--World Position from the center of the entity
			}
			
			draw.SimpleTextOutlined(string.format("( %s ) [ %s ] %s", EntData.class, EntData.index, EntData.model), "Default", 2, 0, Color(255, 255, 255, 255), 0, 3, 1, Color(0,0,0,255))
			draw.SimpleTextOutlined(string.format("Angle(%s) Pos(%s)", EntData.angle, EntData.wpos), "Default", 2, 15, Color(255, 255, 255, 255), 0, 3, 1, Color(0,0,0,255))
		end
	end
end

hook.Add("HUDShouldDraw", "Minimalist.Hide", HUD.ShouldDrawHUD)
hook.Add("HUDPaint", "Minimalist.Draw", HUD.DrawAll)
hook.Add("Initialize", "Minimalist.Initialize", HUD.Initialize)

ShowingDeathMode = 0
function GM:HUDPaint( )
	
	if( LocalPlayer( ):GetNWInt( "deathmode" ) == 1 and ShowingDeathMode == 0) then
	
		DrawDeathHUD( )

		ShowingDeathMode = 1;
		
	end
	
	-- DrawPlayerInfo( );
    DrawHudShit( );
	DrawAmmoInfo( );
	DrawOOCInfo( )
--	DrawBars( );	
	
	local tr = LocalPlayer():GetEyeTrace();
	
	if( tr.Entity:IsValid() and tr.Entity:GetPos():Distance( LocalPlayer():GetPos() ) < 300 ) then
		
		if( tr.Entity:IsPlayer() ) then
				
			DrawPlayerInfo( tr.Entity );
					
		end
				
	end
	
	DrawTargetInfo( );
end

AdminSeeAll = false;

function SeeAll()

	AdminSeeAll = !AdminSeeAll;

end
usermessage.Hook( "SeeAll", SeeAll );

function DrawSeeAll()

	if( AdminSeeAll ) then
	
		for k, v in pairs( player.GetAll() ) do
		
			local pos = v:EyePos() + Vector( 0, 0, 11 );
			local scrpos = pos:ToScreen();
		
			draw.DrawTextOutlined( LocalPlayer():Nick() .. " (" .. v:Nick() .. ")", "NewChatFont", scrpos.x, scrpos.y, Color( 200, 0, 0, 255 ), 1, nil, 1, Color( 0, 0, 0, 255 ) );

		end
	
	end

end

RAD_Chat = {}

-- Create some client convars that we'll need.
CreateClientConVar("RAD_Chat_radio", "1", true, true)
CreateClientConVar("RAD_Chat_ooc", "1", true, true)
CreateClientConVar("RAD_Chat_ic", "1", true, true)
CreateClientConVar("RAD_Chat_advert", "1", true, true)
CreateClientConVar("RAD_Chat_joinleave", "1", true, true)

-- Emoticons.
RAD_Chat.Messages = {}
RAD_Chat.Derma = {}

-- History.
RAD_Chat.History = {}
RAD_Chat.History.Messages = {}
RAD_Chat.History.Position = 0

-- Hook.
usermessage.Hook("RAD_Chat_Player_Message", function(Message)
	local Player = Message:ReadEntity()
	local Filter = Message:ReadString()
	local Text = Message:ReadString()
	
	-- Check Is Player.
	if ( !Player:IsPlayer() ) then
		print("ERROR: Trying to do a player message with chat filter "..Filter.." ("..Text..") and the entity isn't a player!")
	end
	
	-- Chat Text.
	RAD_Chat.ChatText(Player:EntIndex(), Player:Name(), Text, Filter)
end)

-- Hook.
usermessage.Hook("RAD_Chat_Character_Message", function(Message)
	local Player = Message:ReadEntity()
	local Character = Message:ReadString()
	local Filter = Message:ReadString()
	local Text = Message:ReadString()
	
	-- Check Is Player.
	if ( !Player:IsPlayer() ) then
		print("ERROR: Trying to do a player message with chat filter "..Filter.." ("..Text..") and the entity isn't a player!")
	end
	
	-- Chat Text.
	RAD_Chat.ChatText(Player:EntIndex(), Character, Text, Filter)
end)

-- Hook.
usermessage.Hook("RAD_Chat_Message", function(Message)
	local Filter = Message:ReadString()
	local Text = Message:ReadString()
	
	-- Chat Text.
	RAD_Chat.ChatText(nil, nil, Text, Filter)
end)


-- Get Position.
function RAD_Chat.GetPosition()
	local X, Y = 10, ScrH() - (ScrH() / 3.2)
	
	-- Check Position.
	if (RAD_Chat.Position) then Y = RAD_Chat.Position end
	
	-- Return X.
	return X, Y
end

-- Get X.
function RAD_Chat.GetX()
	local X, Y = RAD_Chat.GetPosition()
	
	-- Return X.
	return X
end

-- Get Y.
function RAD_Chat.GetY()
	local X, Y = RAD_Chat.GetPosition()
	
	-- Return Y.
	return Y
end

-- Get Spacing.
function RAD_Chat.GetSpacing(Message)
	if (Message) then
		return 20
	else
		return 20
	end
end

-- Create Derma All.
function RAD_Chat.CreateDermaAll()
	RAD_Chat.CreateDermaPanel()
	RAD_Chat.CreateDermaCheckBoxes()
	RAD_Chat.CreateDermaButtons()
	RAD_Chat.CreateDermaFilters()
	RAD_Chat.CreateDermaTextEntry()

	-- Hide.
	RAD_Chat.Derma.Panel.Hide()
end

-- Create Derma Buttons.
function RAD_Chat.CreateDermaButtons()
	if (!RAD_Chat.Derma.Buttons) then
		RAD_Chat.Derma.Buttons = {}
		
		-- Create Derma Button.
		RAD_Chat.CreateDermaButton("Up", "+", 434, 16, "Scroll up the message area.", function()
			RAD_Chat.History.Position = RAD_Chat.History.Position - 1
		end, function(self)
			if (RAD_Chat.History.Messages[RAD_Chat.History.Position - 10]) then
				self:SetDisabled(false)
			else
				self:SetDisabled(true)
			end
		end)
		RAD_Chat.CreateDermaButton("Down", "-", 454, 16, "Scroll down the message area.", function()
			RAD_Chat.History.Position = RAD_Chat.History.Position + 1
		end, function(self)
			if (RAD_Chat.History.Messages[RAD_Chat.History.Position + 1]) then
				self:SetDisabled(false)
			else
				self:SetDisabled(true)
			end
		end)
		RAD_Chat.CreateDermaButton("Bottom", "*", 474, 16, "Goto the bottom of the message area.", function()
			RAD_Chat.History.Position = #RAD_Chat.History.Messages
		end, function(self)
			if (RAD_Chat.History.Position < #RAD_Chat.History.Messages) then
				self:SetDisabled(false)
			else
				self:SetDisabled(true)
			end
		end)
		RAD_Chat.CreateDermaButton("Filters", "Filters", 494, 80, "Enable or disable message filters.", function()
			local IsVisible = RAD_Chat.Derma.Filters:IsVisible()
			
			-- Check Is Visible.
			if (IsVisible) then
				RAD_Chat.Derma.Filters:SetVisible(false)
			else
				RAD_Chat.Derma.Filters:SetVisible(true)
			end
		end, function(self) end)
	end
end
	
-- Create Derma Button.
function RAD_Chat.CreateDermaButton(Name, Text, X, Width, ToolTip, DoClick, Think)
	if (!RAD_Chat.Derma.Buttons[Name]) then
		RAD_Chat.Derma.Buttons[Name] = vgui.Create("DButton", RAD_Chat.Derma.Panel)
		RAD_Chat.Derma.Buttons[Name]:SetText(Text)
		RAD_Chat.Derma.Buttons[Name]:SetSize(Width, 16)
		RAD_Chat.Derma.Buttons[Name]:SetPos(X, 4)
		RAD_Chat.Derma.Buttons[Name]:SetToolTip(ToolTip)
		RAD_Chat.Derma.Buttons[Name].DoClick = DoClick
		RAD_Chat.Derma.Buttons[Name].Think = Think
	end
end

-- Create Derma Check Boxes.
function RAD_Chat.CreateDermaCheckBoxes()
	if (!RAD_Chat.Derma.CheckBoxes) then RAD_Chat.Derma.CheckBoxes = {} end
end

-- Create Derma Check Box.
function RAD_Chat.CreateDermaCheckBox(Name, ConVar, X, ToolTip, Label, Parent, Y)
	if (!RAD_Chat.Derma.CheckBoxes[Name]) then
		Parent = Parent or RAD_Chat.Derma.Panel
		Y = Y or 4
		
		-- Check Label.
		if (Label) then
			RAD_Chat.Derma.CheckBoxes[Name] = vgui.Create("DCheckBoxLabel", Parent)
			RAD_Chat.Derma.CheckBoxes[Name]:SetText(Label)
		else
			RAD_Chat.Derma.CheckBoxes[Name] = vgui.Create("DCheckBox", Parent)
		end
		
		-- Set Pos.
		RAD_Chat.Derma.CheckBoxes[Name]:SetPos(X, Y)
		RAD_Chat.Derma.CheckBoxes[Name]:SetToolTip(ToolTip)
		RAD_Chat.Derma.CheckBoxes[Name]:SetConVar(ConVar)
		
		-- Check Label.
		if (Label) then
			RAD_Chat.Derma.CheckBoxes[Name]:SizeToContents()
		else
			RAD_Chat.Derma.CheckBoxes[Name]:SetSize(16, 16)
		end
	end
end

-- Create Derma Text Entry.
function RAD_Chat.CreateDermaTextEntry()
	if (!RAD_Chat.Derma.TextEntry) then
		RAD_Chat.Derma.TextEntry = vgui.Create("DTextEntry", RAD_Chat.Derma.Panel)
		RAD_Chat.Derma.TextEntry:SetPos(34, 4)
		RAD_Chat.Derma.TextEntry:SetSize(396, 16)
		RAD_Chat.Derma.TextEntry.OnEnter = function()
			LocalPlayer():ConCommand( "rp_closedchat" )
			local Message = RAD_Chat.Derma.TextEntry:GetValue()
			
			-- Check Message.
			if (Message and Message != "") then
				RAD_Chat.History.Position = #RAD_Chat.History.Messages
				
				-- Message.
				Message = string.Replace(Message, '"', '\"')
				
				-- Check Say Team.
				if (RAD_Chat.SayTeam) then
					LocalPlayer():ConCommand("say_team \""..Message.."\"\n")
				else
					LocalPlayer():ConCommand("say \""..Message.."\"\n")
				end
				
				-- Set Text.
				RAD_Chat.Derma.TextEntry:SetText("")
			end
			
			-- Hide.
			RAD_Chat.Derma.Panel.Hide()
		end
		
		RAD_Chat.Derma.TextEntry.OnTextChanged = function()
			local Message = RAD_Chat.Derma.TextEntry:GetValue()
			LocalPlayer():ConCommand( "rp_openedchat" )
		end
		
		-- Think.
		RAD_Chat.Derma.TextEntry.Think = function()
			local Message = RAD_Chat.Derma.TextEntry:GetValue()
			-- Check Len.
			if (string.len(Message) > 126) then
				if( self ) then
				self:SetValue(string.sub(Message, 1, 126))
				self:SetCaretPos(126)
				end
				-- Play Sound.
				surface.PlaySound("common/talk.wav")
			end
		end
	end
end

-- Create Derma Filters.
function RAD_Chat.CreateDermaFilters()
	if (!RAD_Chat.Derma.Filters) then
		RAD_Chat.Derma.Filters = vgui.Create("EditablePanel")
		RAD_Chat.Derma.Filters:SetSize(116, 112)
		
		-- Paint.
		function RAD_Chat.Derma.Filters:Paint()
			local BackgroundColor = Color(0, 0, 0, 150)
			local CornerSize = 4
			local TitleColor = Color(50, 255, 50, 255)
			local TextColor = Color(255, 255, 255, 255)
			
			-- Rounded Box.
			draw.RoundedBox(CornerSize, 0, 0, self:GetWide(), self:GetTall(), BackgroundColor)
		end
		
		-- Think.
		function RAD_Chat.Derma.Filters:Think()
			local X = RAD_Chat.Derma.Panel.x + RAD_Chat.Derma.Panel:GetWide() + 4
			local Y = RAD_Chat.Derma.Panel.y + RAD_Chat.Derma.Panel:GetTall() - self:GetTall()
			
			-- Set Pos.
			self:SetPos(X, Y)
		end
		
		-- Create Derma Check Box.
		RAD_Chat.CreateDermaCheckBox("Radio", "RAD_Chat_radio", 8, "Filter radio messages.", "Filter Radio", RAD_Chat.Derma.Filters, 8)
		RAD_Chat.CreateDermaCheckBox("OOC", "RAD_Chat_ooc", 8, "Filter out-of-character messages.", "Filter OOC", RAD_Chat.Derma.Filters, 28)
		RAD_Chat.CreateDermaCheckBox("IC", "RAD_Chat_ic", 8, "Filter in-character messages.", "Filter IC", RAD_Chat.Derma.Filters, 48)
		RAD_Chat.CreateDermaCheckBox("advert", "RAD_Chat_advert", 8, "Filter advert messages.", "Filter Adverts", RAD_Chat.Derma.Filters, 68)
		RAD_Chat.CreateDermaCheckBox("Join/Leave", "RAD_Chat_joinleave", 8, "Filter join/leave messages.", "Filter Join/Leave", RAD_Chat.Derma.Filters, 88)
	end
end

-- Create Derma Panel.
function RAD_Chat.CreateDermaPanel()
	if (!RAD_Chat.Derma.Panel) then
		RAD_Chat.Derma.Panel = vgui.Create("EditablePanel")
		RAD_Chat.Derma.Panel:SetSize(576, 24)
		RAD_Chat.Derma.Panel.Show = function()
			RAD_Chat.Derma.Panel:SetKeyboardInputEnabled(true)
			RAD_Chat.Derma.Panel:SetMouseInputEnabled(true)
			
			-- Set Visible.
			RAD_Chat.Derma.Scroll:SetVisible(true)
			RAD_Chat.Derma.Panel:SetVisible(true)
			RAD_Chat.Derma.Panel:MakePopup()
			
			-- Position.
			RAD_Chat.History.Position = #RAD_Chat.History.Messages
			
			-- Request Focus.
			RAD_Chat.Derma.TextEntry:RequestFocus()
		end
		RAD_Chat.Derma.Panel.Hide = function()
			RAD_Chat.Derma.Panel:SetKeyboardInputEnabled(false)
			RAD_Chat.Derma.Panel:SetMouseInputEnabled(false)
			
			-- Set Text.
			RAD_Chat.Derma.TextEntry:SetText("")
			
			-- Set Visible.
			RAD_Chat.Derma.Panel:SetVisible(false)
			RAD_Chat.Derma.Scroll:SetVisible(false)
			RAD_Chat.Derma.Filters:SetVisible(false)
		end
		
		-- Paint.
		function RAD_Chat.Derma.Panel:Paint()
			local BackgroundColor = Color(0, 0, 0, 150)
			local CornerSize = 4
			local TitleColor = Color(50, 255, 50, 255)
			local TextColor = Color(255, 255, 255, 255)
			
			-- Rounded Box.
			draw.RoundedBox(CornerSize, 0, 0, self:GetWide(), self:GetTall(), BackgroundColor)
			
			-- Set Font.
			surface.SetFont("RAD_Chat_MainText")
			
			-- Width.
			local Width = surface.GetTextSize("Say")
			
			-- Check Say Team.
			if (RAD_Chat.SayTeam) then
				Width = surface.GetTextSize("Say Team")
				
				-- Simple Text.
				draw.SimpleText("Say Team", "RAD_Chat_MainText", 5, 13, Color(0, 0, 0, 255), 0, 1)
				draw.SimpleText("Say Team", "RAD_Chat_MainText", 4, 12, TitleColor, 0, 1)
				
				-- Text Entry.
				RAD_Chat.Derma.TextEntry:SetPos(74, 4)
				RAD_Chat.Derma.TextEntry:SetSize(356, 16)
			else
				draw.SimpleText("Say", "RAD_Chat_MainText", 5, 13, Color(0, 0, 0, 255), 0, 1)
				draw.SimpleText("Say", "RAD_Chat_MainText", 4, 12, TitleColor, 0, 1)
				
				-- Text Entry.
				RAD_Chat.Derma.TextEntry:SetPos(34, 4)
				RAD_Chat.Derma.TextEntry:SetSize(396, 16)
			end
			
			-- Simple Text.
			draw.SimpleText(":", "RAD_Chat_MainText", 5 + Width, 13, Color(0, 0, 0, 255), 0, 1)
			draw.SimpleText(":", "RAD_Chat_MainText", 4 + Width, 12, TextColor, 0, 1)
		end
		
		-- Think.
		function RAD_Chat.Derma.Panel:Think()
			local X, Y = RAD_Chat.GetPosition()
			
			-- Set Pos.
			RAD_Chat.Derma.Panel:SetPos(X, Y + 6)
			
			-- Check Is Visible.
			if (self:IsVisible() and input.IsKeyDown(KEY_ESCAPE)) then RAD_Chat.Derma.Panel.Hide() end
		end
		
		-- Scroll.
		RAD_Chat.Derma.Scroll = vgui.Create("Panel")
		RAD_Chat.Derma.Scroll:SetPos(0, 0)
		RAD_Chat.Derma.Scroll:SetSize(0, 0)
		
		-- On Mouse Wheeled.
		function RAD_Chat.Derma.Scroll:OnMouseWheeled(Delta)
			local IsVisible = RAD_Chat.Derma.Panel:IsVisible()
			
			-- Check Is Visible.
			if (IsVisible) then
				if (Delta > 0) then
					if (RAD_Chat.History.Messages[RAD_Chat.History.Position - 10]) then
						RAD_Chat.History.Position = RAD_Chat.History.Position - 1
					end
				else
					if (RAD_Chat.History.Messages[RAD_Chat.History.Position + 1]) then
						RAD_Chat.History.Position = RAD_Chat.History.Position + 1
					end
				end
			end
		end
	end
end

-- Player Bind Press.
function RAD_Chat.PlayerBindPress(Player, Bind, Press)
	if (Bind == "toggleconsole") then
		RAD_Chat.Derma.Panel.Hide()
	elseif (Bind == "messagemode" and Press) then
		RAD_Chat.Derma.Panel.Show()
		RAD_Chat.SayTeam = false
		
		-- Return True.
		return true
	elseif (Bind == "messagemode2" and Press) then
		RAD_Chat.Derma.Panel.Show()
		RAD_Chat.SayTeam = false -- (normally true).
		
		-- Return True.
		return true
	end
end

-- Add.
hook.Add("PlayerBindPress", "RAD_Chat.PlayerBindPress", RAD_Chat.PlayerBindPress)

-- Message Add.
function RAD_Chat.MessageAdd(Title, Name, Text, Filtered)
	local Message = {}
	
	-- Check Title.
	if (Title) then
		Message.Title = {}
		Message.Title.Text = Title[1]
		Message.Title.Color = Title[2] or Color(255, 255, 255, 255)
	end
	
	-- Check Name.
	if (Name) then
		Message.Name = {}
		Message.Name.Text = Name[1]
		Message.Name.Color = Name[2] or Color(255, 255, 255, 255)
	end
	
	-- Time Start.
	Message.TimeStart = CurTime()
	Message.TimeFade = Message.TimeStart + 10
	Message.TimeFinish = Message.TimeFade + 1
	Message.Spacing = 0
	Message.Blocks = {}
	Message.Color = Text[2] or Color(255, 255, 255, 255)
	Message.Alpha = 255
	Message.Lines = 1
	Message.Text = string.Explode(" ", Text[1])
	
	-- Extract Types.
	RAD_Chat.ExtractTypes(Message)
	RAD_Chat.PrintConsole(Message)
	
	-- Check Filtered.
	if (Filtered) then return end
	
	-- Check Position.
	if (RAD_Chat.History.Position == #RAD_Chat.History.Messages) then
		RAD_Chat.History.Position = #RAD_Chat.History.Messages + 1
	end
	
	-- Check Messages.
	if (#RAD_Chat.Messages == 10) then table.remove(RAD_Chat.Messages, 10) end
	
	-- Copy.
	local Copy = table.Copy(Message)
	
	-- Insert.
	table.insert(RAD_Chat.Messages, 1, Message)
	table.insert(RAD_Chat.History.Messages, Copy)
	
	-- Play Sound.
	surface.PlaySound("common/talk.wav")
end

-- Print Console.
function RAD_Chat.PrintConsole(Message)
	local String = ""
	
	-- Check Title.
	if (Message.Title) then String = String..Message.Title.Text.." " end
	if (Message.Name) then String = String..Message.Name.Text..": " end
	
	-- For Loop.
	for K, V in pairs(Message.Blocks) do
		local Space = " "
		
		-- Check K.
		if (K == #Message.Blocks) then Space = "" end
		
		-- Check Break.
		if (V.Break) then Space = "" end
		
		-- Check Type.
		if (V.Type == "Text") then String = String..V.Text..Space end
		
		-- Check Break.
		if (V.Break) then
			print(String)
			
			-- String.
			String = ""
		end
	end
	
	-- Check String.
	if (String != "") then print(String) end
end

-- Extract Types.
function RAD_Chat.ExtractTypes(Message)
	local Length = 0
	
	-- Check Title.
	if (Message.Title) then Length = Length + string.len(Message.Title.Text) end
	if (Message.Name) then Length = Length + string.len(Message.Name.Text..":") end
	
	-- Set Font.
	surface.SetFont("RAD_Chat_MainText")
	
	-- For Loop.
	for K, V in pairs(Message.Text) do
		local Extracted = false
		
		-- Characters.
		local Characters = string.len(V) + 1
		
		-- Check Length.
		if (Length + Characters >= 60) then
			local Break = math.Clamp(Characters - ((Length + Characters) - 60), 0, Characters)
			
			-- Dash.
			local Dash = "-"
			local One = string.sub(V, 1, Break)
			local Two = string.sub(V, Break + 1)
			
			-- Check Find.
			if (string.find(string.sub(One, -1), "%p")) then Dash = "" end
			if (string.find(string.sub(Two, 1, 1), "%p")) then
				Dash, One, Two = "", One..string.sub(Two, 1, 1), string.sub(Two, 2)
			end
			
			-- Check One.
			if (One == "" or Two == "") then Dash = "" end
			
			-- Check Insert.
			table.insert(Message.Blocks, {Type = "Text", Text = One..Dash, Break = true})
			
			-- Check Two.
			if (Two != "") then table.insert(Message.Blocks, {Type = "Text", Text = Two}) end
			
			-- Lines.
			Message.Lines = Message.Lines + 1
			
			-- Length.
			Length = string.len(Two)
			Extracted = true
		end
		
		-- Check Extracted.
		if (!Extracted) then
			Length = Length + Characters
			
			-- Insert.
			table.insert(Message.Blocks, {Type = "Text", Text = V})
		end
	end
	
	-- For Loop.
	for K, V in pairs(Message.Blocks) do
		if (V.Break) then
			if (!Message.Blocks[K + 1]) then
				Message.Blocks[K].Break = false
				
				-- Lines.
				Message.Lines = Message.Lines - 1
			end
		end
	end
end

-- Think.
function RAD_Chat.Think()
	local Time = CurTime()
	
	-- For Loop.
	for K, V in pairs(RAD_Chat.Messages) do
		if (Time >= V.TimeFade) then
			local FadeTime = V.TimeFinish - V.TimeFade
			local TimeLeft = V.TimeFinish - Time
			local Alpha = math.Clamp((255 / FadeTime) * TimeLeft, 0, 255)
			
			-- Check Alpha.
			if (Alpha == 0) then
				table.remove(RAD_Chat.Messages, K)
			else
				V.Alpha = Alpha
			end
		end
	end
end

-- Add.
hook.Add("Think", "RAD_Chat.Think", RAD_Chat.Think)
maxlines = 4
		if( ScrH() < 1024) then  deflines = 4 end
		if( ScrH() < 1200) then  deflines = 8; else deflines = 9; end
-- HUD Paint.
function RAD_Chat.HUDPaint()
	local X, Y = RAD_Chat.GetPosition()

	local X = X + 10
	local Y = Y - 10
	
	-- Set Font.
	surface.SetFont("RAD_Chat_MainText")
	
	-- Space.
	local Space = surface.GetTextSize(" ")
	local Box = {Width = 0, Height = 0}
	
	-- Table.
	local Table = RAD_Chat.Messages
	local IsVisible = RAD_Chat.Derma.Panel:IsVisible()
	
	-- Check Is Visible.
	if (IsVisible) then
		Table = {}
		if( ScrH() < 1024) then  maxlines = 4 end
		if( ScrH() < 1200) then  maxlines = 8; else maxlines = 9; end
		//local linesremoved = 0
		for I = maxlines, 0, -1 do
			if( RAD_Chat.History.Messages[RAD_Chat.History.Position - I] ) then
				//if( linesremoved < deflines / 2 ) then
				if( RAD_Chat.History.Messages[RAD_Chat.History.Position - I]["Lines"] > 1 ) then 
				maxlines = maxlines - RAD_Chat.History.Messages[RAD_Chat.History.Position - I]["Lines"] + 1
				//local linesremoved = linesremoved + RAD_Chat.History.Messages[RAD_Chat.History.Position - I]["Lines"] + 1
				//print( linesremoved )
				//end
				end
			end
		end
		if( 2 >= maxlines ) then maxlines = 2 end
		-- For Loop.
		for I = 0, maxlines do
				table.insert(Table, RAD_Chat.History.Messages[RAD_Chat.History.Position - I])
		end
	else
		if (#RAD_Chat.History.Messages > 100) then
			local Amount = #RAD_Chat.History.Messages - 100
			
			-- For Loop.
			for I = 1, Amount do table.remove(RAD_Chat.History.Messages, 1) end
		end
	end
	
	-- For Loop.
	for K, V in pairs(Table) do
		if (Table[K - 1]) then Y = Y - Table[K - 1].Spacing end
		
		-- Is Visible.
		local IsVisible = RAD_Chat.Derma.Panel:IsVisible()
		
		-- Check Is Visible.
		if (!IsVisible and K == 1) then
			Y  = Y - ((RAD_Chat.GetSpacing() + V.Spacing) * V.Lines)
		else
			if (K == 1) then Y = Y + 2 end
			
			-- Y.
			Y = Y - ((RAD_Chat.GetSpacing() + V.Spacing) * V.Lines)
		end
		
		-- Message X.
		local MessageX = X
		local MessageY = Y
		
		-- Check Title.
		if (V.Title) then
			local Width = surface.GetTextSize(V.Title.Text)
			
			-- Title Color.
			local TitleColor = Color(V.Title.Color.r, V.Title.Color.g, V.Title.Color.b, V.Alpha)
			
			-- Draw.
			draw.SimpleText(V.Title.Text, "RAD_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
			draw.SimpleText(V.Title.Text, "RAD_Chat_MainText", MessageX, MessageY, TitleColor, 0, 0)
			
			-- Message X.
			MessageX = MessageX + Width + Space
		end
		
		-- Check Name.
		if (V.Name) then
			local Width = surface.GetTextSize(V.Name.Text)
			
			-- Name Color.
			local NameColor = Color(V.Name.Color.r, V.Name.Color.g, V.Name.Color.b, V.Alpha)
			
			-- Draw.
			draw.SimpleText(V.Name.Text, "RAD_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
			draw.SimpleText(V.Name.Text, "RAD_Chat_MainText", MessageX, MessageY, NameColor, 0, 0)
			
			-- Message X.
			MessageX = MessageX + Width
			
			-- Width.
			local Width = surface.GetTextSize(":")
			
			-- Text.
			draw.SimpleText(":", "RAD_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
			draw.SimpleText(":", "RAD_Chat_MainText", MessageX, MessageY, Color(255, 255, 255, V.Alpha), 0, 0)
			
			-- Message X.
			MessageX = MessageX + Width + Space
		end
		
		-- Text Color.
		local TextColor = Color(V.Color.r, V.Color.g, V.Color.b, V.Alpha)
		local Tag = nil
		
		-- For Loop.
		for K2, V2 in pairs(V.Blocks) do
			if (V2.Type == "Text") then
				local Width = surface.GetTextSize(V2.Text)
				
				-- Draw.
				draw.SimpleText(V2.Text, "RAD_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
				draw.SimpleText(V2.Text, "RAD_Chat_MainText", MessageX, MessageY, TextColor, 0, 0)
				
				-- Message X.
				MessageX = MessageX + Width + Space
			end
			
			-- Check Message X.
			if (MessageX - 8 > Box.Width) then Box.Width = MessageX - 8 end
			if (RAD_Chat.GetY() - Y > Box.Height) then Box.Height = RAD_Chat.GetY() - Y end
			
			-- Check Break.
			if (V2.Break) then
				MessageY = MessageY + RAD_Chat.GetSpacing() + V.Spacing
				MessageX = X
			end
		end
	end
	
	-- Set Pos.
	RAD_Chat.Derma.Scroll:SetPos(X, Y)
	RAD_Chat.Derma.Scroll:SetSize(Box.Width, Box.Height)
end

-- Add.
hook.Add("HUDPaint", "RAD_Chat.HUDPaint", RAD_Chat.HUDPaint)

-- Start Chat.
function RAD_Chat.StartChat(Team) return true end

-- Add.
hook.Add("StartChat", "RAD_Chat.StartChat", RAD_Chat.StartChat)

-- Chat Text.
function RAD_Chat.ChatText(Index, Name, Text, Filter)
	local Type = Filter
	local Filtered = false
	
	-- Check Filter.
	if (Filter == "arrested" or Filter == "yell" or Filter == "whisper" or Filter == "looc" or Filter == "talk"
	or Filter == "request") then
		Filter = "ic"
	end
	
	-- Check ConVar Exists.
	if (ConVarExists("RAD_Chat_"..Filter) and GetConVarNumber("RAD_Chat_"..Filter) == 0) then
		Filtered = true
	end
	
	-- Player.
	local Player = player.GetByID(Index)
	
	-- Check Player.
	if (ValidEntity(Player)) then
		local Team = Player:Team()
		local TeamColor = team.GetColor(Team)
		
		-- Check Filter.
		if (Type == "chat") then
			RAD_Chat.MessageAdd(nil, {Name, TeamColor}, {Text}, Filtered)
		elseif (Type == "ic") then
			RAD_Chat.MessageAdd(nil, nil, {Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "talk") then
			RAD_Chat.MessageAdd(nil, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "advert") then
			RAD_Chat.MessageAdd({"[AD]"}, nil, {Name..": "..Text, Color(200, 150, 225, 255)}, Filtered)
		elseif (Type == "yell") then
			RAD_Chat.MessageAdd({"[YELL]"}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "whisper") then
			RAD_Chat.MessageAdd({"[WHISPER]"}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "looc") then
			RAD_Chat.MessageAdd({"[LOCAL OOC]", Color(255, 75, 75, 255)}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "radio") then
			RAD_Chat.MessageAdd({"[RADIO]"}, nil, {Name..": "..Text, Color(200, 255, 125, 255)}, Filtered)
		elseif (Type == "arrested") then
			RAD_Chat.MessageAdd({"[ARRESTED]"}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "admin") then
			RAD_Chat.MessageAdd({"[ADMIN CHAT]"}, nil, {Name..": "..Text, Color(154, 205, 50, 255)}, Filtered)
		elseif (Type == "adminbc") then
			RAD_Chat.MessageAdd({"[ADMIN]"}, nil, {Name..": "..Text, Color(255, 0, 0, 255)}, Filtered)
		elseif (Type == "request") then
			RAD_Chat.MessageAdd({"[PLAYER REQUEST]"}, nil, {Name..": "..Text, Color(125, 200, 255, 255)}, Filtered)
		elseif (Type == "broadcast") then
			RAD_Chat.MessageAdd({"[BROADCAST]"}, nil, {Name..": "..Text, Color(255, 75, 75, 255)}, Filtered)
		elseif (Type == "event") then
			RAD_Chat.MessageAdd({"[EVENT]"}, nil, {Name..": "..Text, Color(255, 75, 75, 255)}, Filtered)
		elseif (Type == "ooc") then
			RAD_Chat.MessageAdd({"[OOC]", Color(255, 75, 75, 255)}, {Name, TeamColor}, {Text}, Filtered)
		end
	else
		if (Name == "Console" and Type == "chat") then
			RAD_Chat.MessageAdd({"[OOC]"}, {"Console", Color(150, 150, 150, 255)}, {Text}, Filtered)
		elseif (Filter == "joinleave") then
			Text = Text.."."
			
			-- Check Find.
			if (string.find(Text, "%(") and string.find(Text, "%)")) then
				Text = string.gsub(Text, "Kicked by Console :", "Kicked by Console:", 1)
				Text = string.gsub(Text, "%.%)", ")")
				
				-- Message Add.
				RAD_Chat.MessageAdd(nil, nil, {Text, Color(255, 255, 255, 255)}, Filtered)
			else
				RAD_Chat.MessageAdd(nil, nil, {Text, Color(175, 255, 125, 255)}, Filtered)
			end
		else
			RAD_Chat.MessageAdd(nil, nil, {Text, Color(255, 255, 255, 255)}, Filtered)
		end
	end
	
	-- Return True.
	return true
end

-- Add.
hook.Add("ChatText", "RAD_Chat.ChatText", RAD_Chat.ChatText)

-- Create Derma All.
RAD_Chat.CreateDermaAll()


--local bars

bars = {
	Stamina = { X = 0, Y = 0, W = 0, H = 0, V = false, A = 0, R = 189, G = 000, B = 000 },
	Battery = { X = 0, Y = 0, W = 0, H = 0, V = false, A = 0, R = 000, G = 189, B = 000 },
	AirTank = { X = 0, Y = 0, W = 0, H = 0, V = false, A = 0, R = 189, G = 100, B = 000 },
	}


local function DrawOutlinedMeter( amt, thickness, x, y, w, h, clr )
	draw.RoundedBox( 0, x, y, w, h, Color( 0, 0, 0, 200 ) );
	if( amt > .01 ) then
		draw.RoundedBox( 0, x + thickness, y + thickness, ( w - thickness * 2 ) * amt, h - thickness * 2, clr );
	end
end


local function HUDPaint( )
	
	local me = LocalPlayer( )

	
	local sprint 	= me:GetDTFloat( 3 )

	
// draw.RoundedBox( 0, 5, 5, ScrW() / 6 + 8, high, Color( 10, 10, 10, 150 ) );
     DrawOutlinedMeter( sprint /  1, 0.5, ScrW() / 6 * 5, ScrH() - 50, ScrW() / 6, 10, Color( 255, 217, 50, 150 ) ); 

end

hook.Add( "HUDPaint", "Stamina.HUDPaint", HUDPaint )

