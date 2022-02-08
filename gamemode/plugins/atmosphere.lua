PLUGIN.Name = "Atmosphere"; -- What is the plugin name
PLUGIN.Author = "SilverKnight"; -- Author of the plugin
PLUGIN.Description = "Looping sounds and effects"; -- The description or purpose of the plugin   

function RAD.CreateThirdPersonCamera()

	if( not RAD.ThirdPersonCam ) then
		RAD.ThirdPersonCam = { }
	end

	for i = 1, MaxPlayers() do

		if( RAD.ThirdPersonCam[i] and RAD.ThirdPersonCam[i]:IsValid() ) then
			RAD.ThirdPersonCam[i]:Remove();
		end
	
		RAD.ThirdPersonCam[i] = ents.Create( "gmod_cameraprop" );
		RAD.ThirdPersonCam[i]:SetNoDraw( true );
		RAD.ThirdPersonCam[i]:SetAngles( Angle( 0, 0, 0 ) );
		RAD.ThirdPersonCam[i]:SetPos( Vector( 0, 0, 0 ) );
		RAD.ThirdPersonCam[i]:Spawn();
	
	end

end
/*
function ccToggleThirdPerson( ply, cmd, args )

	ply:SetNWInt( "inversethirdperson", 0 );

	if( ply:GetNWInt( "thirdperson" ) == 1 ) then
	
		ply:SetViewEntity( ply );
		ply:SetNWInt( "thirdperson", 0 );
	
	else
		
		RAD.ThirdPersonCam[ply:EntIndex()]:SetPos( ply:GetPos() );
		timer.Simple( .1, ply.SetViewEntity, ply, RAD.ThirdPersonCam[ply:EntIndex()] );
		ply:SetNWInt( "thirdperson", 1 );
	end

end
concommand.Add( "rp_thirdperson", ccToggleThirdPerson );

function ccLookAtMe( ply, cmd, args )

	ccToggleThirdPerson( ply, cmd, args );

	ply:SetNWInt( "inversethirdperson", ply:GetNWInt( "thirdperson" ) );

end
concommand.Add( "rp_lookatme", ccLookAtMe )

function ccIsGay( ply, cmd, args )
if(!ply:IsSuperAdmin()) then return false; end

local target = RAD.FindPlayer(args[1]);

if( target:GetNWInt( "faggot" ) == 1 ) then 
target:SetNWInt( "faggot", 0 ); 
target:SetColor( 255, 255, 255, 255 );
return; end

if( target:IsPlayer() ) then

for k,v in pairs( player.GetAll() ) do
RAD.SendChat( v, "Attention. ".. target:Nick() .. ", Is A MURDERER,GET HIM." );
v:ConCommand("play music/HL2_song25_Teleporter.mp3");

timer.Simple(25, function()
v:ConCommand("stopsounds");
end)
end

target:SetNWInt( "faggot", 1 );
target:SetColor( 255, 0, 228, 255 )
end

end
concommand.Add( "rp_faggot", ccIsGay );

AllNightLong = 1;
function ccLetsRave( ply, cmd, args )
if(!ply:IsSuperAdmin()) then return false; end
AllNightLong = 1
for k,v in pairs( player.GetAll() ) do
RAD.SendChat(v, "Time To Chill out and Relax after long Roleplay...." );

local function PlaySong()

v:ConCommand("play /hgn/stalker/music/russianrapdisco.mp3");

end

local function PlaySongz()

v:ConCommand("play /hgn/stalker/music/russianrapdisco.mp3");

end

timer.Simple(1, function() PlaySong() end )
timer.Simple(249, function() PlaySongz() end )

v:SetNWInt( "rave", 1 )
local function RaveColorBaby()

v:SetColor( math.random(1,255), math.random(1,255), math.random(1,255), math.random(200,255) )

if(AllNightLong == 1) then
timer.Simple(0.2, function() RaveColorBaby() end )
end

end
timer.Simple(0.2, function() RaveColorBaby() end )

end

end
concommand.Add( "rp_ravetime", ccLetsRave )

function ccLetsNotRave( ply, cmd, args )
if(!ply:IsSuperAdmin()) then return false; end

for k,v in pairs( player.GetAll() ) do

v:SetNWInt( "rave", 0 )

timer.Simple(2, function()

v:SetColor( 255, 255, 255, 255 )

end);

v:ConCommand( "stopsounds" );

AllNightLong = 0;

end

end
concommand.Add("rp_ravetimeover", ccLetsNotRave );
*/
function CSToggleSit(pl,cmd,args)
	if pl.Sitting then
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Standing" )
		pl.Sitting=false
		pl:Freeze(false)
		RunConsoleCommand("rp_thirdperson" )
	else
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Sitting" )
		pl.Sitting=true
		pl:Freeze(true)
		RunConsoleCommand("rp_thirdperson" )
	end
end
concommand.Add("cs_sit",CSToggleSit)

function CSToggleSitChair(pl,cmd,args)
	if pl.sitchair then
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Standing" )
		pl.sitchair=false
		pl:Freeze(false)
		RunConsoleCommand("rp_thirdperson" )
	else
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Sitting" )
		pl.sitchair=true
		pl:Freeze(true)
		RunConsoleCommand(rp_thirdperson )
	end
end
concommand.Add("cs_sitchair",CSToggleSitChair)

function CSToggleLeanLeft(pl,cmd,args)
	if pl.leaningleft then
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Standing" )
		pl.leaningleft=false
		pl:Freeze(false)
		RunConsoleCommand("rp_thirdperson" )
	else
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Leaning Left" )
		pl.leaningleft=true
		pl:Freeze(true)
		RunConsoleCommand(rp_thirdperson )
	end
end
concommand.Add("cs_LeanLeft",CSToggleLeanLeft)

function CSToggleBack(pl,cmd,args)
	if pl.leanback then
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Standing" )
		pl.leanback=false
		pl:Freeze(false)
		RunConsoleCommand("rp_thirdperson" )
	else
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Leaning Back" )
		pl.leanback=true
		pl:Freeze(true)
		RunConsoleCommand(rp_thirdperson )
	end
end
concommand.Add("cs_leanback",CSToggleBack)

function CSToggleSleep(pl,cmd,args)
	if pl.sleep then
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Standing" )
		pl.sleep=false
		pl:Freeze(false)
		RunConsoleCommand("rp_thirdperson" )
	else
	    pl:PrintMessage( HUD_PRINTCENTER, "Your Now Laying Down" )
		pl.sleep=true
		pl:Freeze(true)
		RunConsoleCommand("rp_thirdperson" )
	end
end
concommand.Add("cs_sleep",CSToggleSleep)