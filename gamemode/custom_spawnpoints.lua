
function ccGetPos( ply, cmd, args )

	if( ply:IsSuperAdmin() ) then
	
		ply:PrintMessage( 2, "AddSpawnPoint( \"" .. game.GetMap() .. "\", Vector( " .. ply:GetPos().x .. ", " .. ply:GetPos().y .. ", " .. ply:GetPos().z .. " ), " );
		ply:PrintMessage( 2, "Angle( " .. ply:EyeAngles().pitch .. ", " .. ply:EyeAngles().yaw .. ", " .. ply:EyeAngles().roll .. " ) );" );
	
	end

end
concommand.Add( "rp_getspawnpoint", ccGetPos );

RAD.CustomSpawnPoints = { }

local function AddSpawnPoint( map, pos, ang, flagbool, flagtbl )
	if( not map == game.GetMap() )then return; end
	
	
	if( not RAD.CustomSpawnPoints[map] ) then
			RAD.CustomSpawnPoints[map] = { }	
	end
	
	local sp = { }
	sp.Pos = pos;
	sp.Ang = ang;
    sp.FlagBool = flagbool;
	sp.Flags = flagtbl;
	table.insert( RAD.CustomSpawnPoints[map], sp );

end

AddSpawnPoint( "md_whitehills_b2", Vector( 3946.250000, -2791.218750, 739.781250 ), Angle( 2.420009, 88.520149, 0.000000 ), false, {} );
AddSpawnPoint( "md_whitehills_b2", Vector( 3946.250000, -2791.218750, 939.781250 ), Angle( 2.420009, 88.520149, 0.000000 ), true, {"trader"} );


