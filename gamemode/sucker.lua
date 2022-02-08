-------------------------------
-- HyperGamer.Net Raidation Script
-- Author: Silver Knight
-- sucker.lua
-- Misc
-------------------------------
function BeginStorm()

	storm_active = true
	
	SetGlobalString("weather","dark")
	
	timer.Simple( 8, function()
		if( storm_active ) then
			for k, v in pairs( player.GetAll() ) do
				v:ConCommand("play " .. Format("ambient/atmosphere/thunder%i.wav",math.random(1,4)) )
			end
		end
	end );
	
	timer.Simple( 10, function()
		if( storm_active ) then
			SetGlobalString("weather","storm")
		end
	end );
	
	timer.Simple( 480, function()
		if( storm_active ) then
			SetGlobalString("weather","dark")
		end
	end );
	
	timer.Simple( 490, function()
		if( storm_active ) then
			SetGlobalString("weather","sunny")
		end
	end );
	
	timer.Simple( 510, function()
		storm_active = false
	end );

end