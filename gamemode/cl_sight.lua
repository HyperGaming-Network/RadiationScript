-------------------------------
-- www.HyperGamer.Net
-- HGNRP
-- Author: Silver Knight
-------------------------------
util.PrecacheSound( "/hgn/stalker/music/background1.mp3" )
util.PrecacheSound( "/hgn/stalker/music/background2.mp3" ) 
util.PrecacheSound( "/hgn/stalker/music/background3.mp3" ) 
util.PrecacheSound( "/hgn/stalker/music/background4.mp3" ) 

function StartDatShit()
RunConsoleCommand( "play", "/hgn/stalker/music/background2.mp3" );
end
timer.Create( "backgroundmusictimer", 279, 0, StartDatShit )

function SpinTheRecord( ply )
timer.Start( "backgroundmusictimer" )
end
hook.Add( "PlayerInitialSpawn", "backgroundmusichook", SpinTheRecord )

