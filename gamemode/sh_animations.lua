------------------------------------------
--RadiationScript Animations
--HyperGamer.Net
------------------------------------------
--Hey hey hey! It's fucking NPC animations version three! This time with no Rick Dark shit.
--Credits to Azuisleet ( Original hook ), Entoros( Holdtype thing ), and well, me, Big Bang/F-Nox ( everything else )

--Hey hey hey! It's fucking NPC animations version three! This time with no Rick Dark shit.
--Credits to Azuisleet ( Original hook ), Entoros( Holdtype thing ), and well, me, Big Bang/F-Nox ( everything else )

--Override! Thanks Entoros!
function _R.Weapon:GetHoldType()
	if self.HoldType then
		return tostring( self.HoldType )
	end
    return "default" 
end

--Weapons that are always aimed
local AlwaysAimed = 
{
	"weapon_physgun",
	"weapon_physcannon",
	"weapon_frag",
	"weapon_slam",
	"weapon_rpg",
	"gmod_tool"
}

--Weapons that are never aimed
local NeverAimed =
{
	"hands",
	"claws"
}

function MakeUnAim( ply )

	if ValidEntity( ply:GetActiveWeapon() ) then
		if( !ply:GetActiveWeapon():GetDTBool( 1 ) and !table.HasValue( AlwaysAimed, ply:GetActiveWeapon():GetClass()) ) then
			ply:SetNWBool( "aiming", false )
			--ply:GetActiveWeapon():SendWeaponAnim( ACT_VM_HOLSTER )
				if SERVER then
					ply:DrawViewModel( false )
				end
			if( ply:GetActiveWeapon():IsValid() ) then
				ply:GetActiveWeapon():SetNWBool( "NPCAimed", false );
			end
		else
			MakeAim( ply )
		end
	end
	
end

function MakeAim( ply )
	
	if ValidEntity( ply:GetActiveWeapon() ) then
		if !table.HasValue( NeverAimed, ply:GetActiveWeapon():GetClass() ) then
			ply:SetNWBool( "aiming", true )
			if SERVER then
				ply:DrawViewModel( true )
			end
			--ply:GetActiveWeapon():SendWeaponAnim( ACT_VM_DRAW )
			ply:GetActiveWeapon():SetNWBool( "NPCAimed", true );
		end
	end

end

local function HolsterToggle( ply )

	if( not ply:GetActiveWeapon():IsValid() ) then
		return;
	end

	if( !ply:GetNWBool( "aiming", false ) ) then
	
		MakeAim( ply );
		ply:SetNWBool( "forceaim", true )
		
	else
		
		MakeUnAim( ply );
		ply:SetNWBool( "forceaim", false )
		
	end

end
concommand.Add( "rp_toggleholster", HolsterToggle );
concommand.Add( "toggleholster", HolsterToggle );

local function NPCWeaponHook( ply, key )
	if key == IN_ATTACK or key == IN_ATTACK2 then
		MakeAim( ply )
		timer.Create( ply:Nick() .. "weaponholster", 4, 1, function()
			if !ply:GetNWBool( "forceaim", false ) then
				if !ply:GetActiveWeapon():SetNWBool( "NPCAimed", false ) then
					MakeUnAim( ply )
				end
			end
		end)
	else
		if( !timer.IsTimer( ply:Nick() .. "weaponholster" ) ) then
			timer.Create( ply:Nick() .. "weaponholster", 4, 1, function()
				if !ply:GetNWBool( "forceaim", false ) then
					if ply:GetActiveWeapon():IsValid() then
						if !ply:GetActiveWeapon():SetNWBool( "NPCAimed", false ) then
							MakeUnAim( ply )
						end
					end
				end
			end)
		end
	end
	
	if key == IN_RUN then
		MakeUnAim( ply )
	end
end
hook.Add( "KeyPress", "NPCWeaponHook", NPCWeaponHook )

local Anims = {}
Anims.Male = {}
Anims.Male[ "models" ] = {
	"models/barney.mdl",
	"models/eli.mdl",
	"models/breen.mdl",
	"models/Gustavio/maleanimtree.mdl",
	"models/kleiner.mdl"
}
Anims.Male[ "default" ] = { 
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "jump" ] = "ACT_JUMP",
        [ "land" ] = "ACT_LAND",
        [ "fly" ] = "ACT_GLIDE",
        [ "sit" ] = "ACT_BUSY_SIT_CHAIR",
        [ "sitground" ] = "ACT_BUSY_SIT_GROUND",
        [ "flinch" ] = {
                ["explosion"] = "ACT_GESTURE_FLINCH_BLAST"
                },
		[ "crouch" ] = {
				[ "idle" ] = "ACT_COVER_LOW",
				[ "walk" ] = "ACT_WALK_CROUCH",
				[ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
				[ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
		},
		[ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_AIM_RIFLE_STIMULATED",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE_STIMULATED",
                [ "run" ] = "ACT_RUN_AIM_RIFLE_STIMULATED"
        }
}
Anims.Male[ "pistol" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_AIM_RIFLE_STIMULATED",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE_STIMULATED",
                [ "run" ] = "ACT_RUN_AIM_RIFLE_STIMULATED"
        },
		["fire"] = "ACT_GESTURE_RANGE_ATTACK_SMG1"
}
Anims.Male[ "rifle" ] = {
        [ "idle" ] = "ACT_IDLE_SMG1_RELAXED",
        [ "walk" ] = "ACT_WALK_RIFLE_RELAXED",
        [ "run" ] = "ACT_RUN_RIFLE_RELAXED",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_AIM_RIFLE_STIMULATED",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE_STIMULATED",
                [ "run" ] = 315
        },
		["fire"] = "ACT_GESTURE_RANGE_ATTACK_SMG1"
}
Anims.Male[ "melee" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
        [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_COWER",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_SPRINT"
        },
		["fire"] = "ACT_MELEE_ATTACK_SWING"
}
Anims.Male[ "grenade" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_COVER_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK",
                [ "run" ] = "ACT_RUN"
        }
}
 
 
Anims.Female = {}
Anims.Female[ "models" ] = {
	"models/alyx.mdl",
	"models/Gustavio/femaleanimtree.mdl"
 
}
Anims.Female[ "default" ] = { 
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "jump" ] = "ACT_JUMP",
        [ "land" ] = "ACT_LAND",
        [ "fly" ] = "ACT_GLIDE",
        [ "sit" ] = "ACT_BUSY_SIT_CHAIR",
        [ "sitground" ] = "ACT_BUSY_SIT_GROUND",
        [ "flinch" ] = {
                ["explosion"] = "ACT_GESTURE_FLINCH_BLAST"
                },
		[ "crouch" ] = {
				[ "idle" ] = "ACT_COVER_LOW",
				[ "walk" ] = "ACT_WALK_CROUCH",
				[ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
				[ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
		},
		[ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_SPRINT"
        }
}
Anims.Female[ "pistol" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_AIM_RIFLE_STIMULATED",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE_STIMULATED",
                [ "run" ] = "ACT_RUN_AIM_RIFLE_STIMULATED"
        },
        [ "reload" ] = "ACT_GESTURE_RELOAD_SMG1",
		["fire"] = "ACT_GESTURE_RANGE_ATTACK_SMG1"
}
Anims.Female[ "rifle" ] = {
        [ "idle" ] = "ACT_IDLE_SMG1_RELAXED",
        [ "walk" ] = "ACT_WALK_RIFLE_RELAXED",
        [ "run" ] = "ACT_RUN_RIFLE_RELAXED",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_AIM_RIFLE_STIMULATED",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE_STIMULATED",
                [ "run" ] = "ACT_RUN_AIM_RIFLE_STIMULATED"
        },
		["fire"] = "ACT_GESTURE_RANGE_ATTACK_SMG1"
}
Anims.Female[ "melee" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_COWER",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_SPRINT"
        },
		["fire"] = "ACT_MELEE_ATTACK_SWING"
}
Anims.Female[ "grenade" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_COVER_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK",
                [ "run" ] = "ACT_RUN"
        }
}

Anims.Metro = {}
Anims.Metro[ "models" ] = {
	"models/police.mdl"
}
Anims.Metro[ "default" ] = { 
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "jump" ] = "ACT_JUMP",
        [ "land" ] = "ACT_LAND",
        [ "fly" ] = "ACT_GLIDE",
        [ "sit" ] = "ACT_COVER_PISTOL_LOW",
        [ "sitground" ] = "",
        [ "flinch" ] = {
                ["explosion"] = "ACT_GESTURE_FLINCH_BLAST"
                },
		[ "crouch" ] = {
				[ "idle" ] = "ACT_COVER_PISTOL_LOW",
				[ "walk" ] = "ACT_WALK_CROUCH",
				[ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
				[ "aimwalk" ] = "ACT_WALK_CROUCH"
		},
		[ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_SPRINT"
        }
}
Anims.Metro[ "pistol" ] = {
        [ "idle" ] = "ACT_IDLE_PISTOL",
        [ "walk" ] = "ACT_WALK_PISTOL",
        [ "run" ] = "ACT_RUN_PISTOL",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_PISTOL_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_RANGE_AIM_PISTOL_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_ANGRY_PISTOL",
                [ "walk" ] = "ACT_WALK_AIM_PISTOL",
                [ "run" ] = "ACT_RUN_AIM_PISTOL"
        },
		[ "fire" ] = "ACT_GESTURE_RANGE_ATTACK_PISTOL",
        [ "reload" ] = "ACT_GESTURE_RELOAD_PISTOL"
}
Anims.Metro[ "rifle" ] = {
        [ "idle" ] = "ACT_IDLE_SMG1",
        [ "walk" ] = "ACT_WALK_RIFLE",
        [ "run" ] = "ACT_RUN_RIFLE",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_SMG1_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_ANGRY_SMG1",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_RUN_AIM_RIFLE"
        },
		[ "fire" ] = "ACT_GESTURE_RANGE_ATTACK_SMG1",
        [ "reload" ] = "ACT_GESTURE_RELOAD_SMG1"
}
Anims.Metro[ "melee" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_PISTOL_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_COVER_PISTOL_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_ANGRY_MELEE",
                [ "walk" ] = "ACT_WALK_ANGRY",
                [ "run" ] = "ACT_RUN"
        },
		[ "fire" ] = "ACT_MELEE_ATTACK_SWING_GESTURE"
}
Anims.Metro[ "grenade" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_PISTOL_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH",
                [ "aimidle" ] = "ACT_COVER_PISTOL_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK",
                [ "run" ] = "ACT_RUN"
        },
		[ "fire" ] = "ACT_COMBINE_THROW_GRENADE"
}

Anims.Combine = {}
Anims.Combine[ "models" ] = {
	"models/combine_super_soldier.mdl",
	"models/Combine_Soldier.mdl",
	"models/Combine_Soldier_PrisonGuard.mdl",
	"models/soldier_stripped.mdl"
}
Anims.Combine[ "default" ] = { 
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK",
        [ "run" ] = "ACT_RUN",
        [ "jump" ] = "ACT_JUMP",
        [ "land" ] = "ACT_LAND",
        [ "fly" ] = "ACT_GLIDE",
        [ "sit" ] = "ACT_COVER_LOW",
        [ "sitground" ] = "",
        [ "flinch" ] = {
                ["explosion"] = "ACT_GESTURE_FLINCH_BLAST"
                },
		[ "crouch" ] = {
				[ "idle" ] = "ACT_COVER_LOW",
				[ "walk" ] = "ACT_WALK_CROUCH",
				[ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
				[ "aimwalk" ] = "ACT_WALK_CROUCH"
		},
		[ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_SPRINT"
        }
}
Anims.Combine[ "pistol" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK_EASY",
        [ "run" ] = "ACT_RUN_RIFLE",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_ANGRY",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_RUN_AIM_RIFLE"
        }
}
Anims.Combine[ "rifle" ] = {
        [ "idle" ] = "ACT_IDLE_SMG1",
        [ "walk" ] = "ACT_WALK_RIFLE",
        [ "run" ] = "ACT_RUN_RIFLE",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_RANGE_AIM_SMG1_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_AIM_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_ANGRY_SMG1",
                [ "walk" ] = "ACT_WALK_AIM_RIFLE",
                [ "run" ] = "ACT_RUN_AIM_RIFLE"
        }
}
Anims.Combine[ "melee" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK_RIFLE",
        [ "run" ] = "ACT_RUN_RIFLE",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_COVER_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE_MANNEDGUN",
                [ "walk" ] = "ACT_WALK_AIM_SHOTGUN",
                [ "run" ] = "ACT_RUN_AIM_SHOTGUN"
        },
		[ "fire" ] = "ACT_MELEE_ATTACK1"
}
Anims.Combine[ "grenade" ] = {
        [ "idle" ] = "ACT_IDLE",
        [ "walk" ] = "ACT_WALK_RIFLE",
        [ "run" ] = "ACT_RUN_RIFLE",
        [ "crouch" ] = {
                [ "idle" ] = "ACT_COVER_LOW",
                [ "walk" ] = "ACT_WALK_CROUCH_RIFLE",
                [ "aimidle" ] = "ACT_COVER_LOW",
                [ "aimwalk" ] = "ACT_WALK_CROUCH_RIFLE"
                },
        [ "aim" ] = {
                [ "idle" ] = "ACT_IDLE",
                [ "walk" ] = "ACT_WALK_GRAVCARRY",
                [ "run" ] = "ACT_RUN_AIM_SHOTGUN"
        },
		[ "fire" ] = "ACT_COMBINE_THROW_GRENADE"
}

local function FindEnumeration( actname )

	for k, v in pairs ( _E ) do
		if(  k == actname ) then
			return tonumber( v );
		end
	end
	
	return -1;

end

local function FindName( actnum )
	for k, v in pairs ( _E ) do
		if(  v == actnum ) then
			return tostring( k );
		end
	end
	
	return "ACT_IDLE";
end	

local function HandleSequence( ply, seq )

	if string.match( seq, "&" ) then
		if string.match( seq, "switch" ) then
			local exp = string.Explode( ";", string.gsub( seq, "&", "" ) )
			local exp2 = string.Explode( ":", exp[1] )
			local model = exp2[2]
			if( string.lower( ply:GetModel() ) != string.lower( model ) ) then
				ply:SetModel( model )
				return FindEnumeration( seq )
			end
		elseif string.match( seq, "lua" ) then
			local exp = string.Explode( ";", string.gsub( seq, "&", "" ) )
			local exp2 = string.Explode( ":", exp[1] )
			local sequence = exp2[2]
			ply:StopAllLuaAnimations()
			ply:SetLuaAnimation( sequence )
			return -1
		end
	end
	
	return FindEnumeration( seq )
	
end

local function getgender( ply )


	local model = string.lower( ply:GetModel() )
	if table.HasValue( Anims.Female[ "models" ], string.lower( model ) ) then
		return "Female"
	end
	if table.HasValue( Anims.Metro[ "models" ], string.lower( model ) ) then
		return "Metro"
	end
	if table.HasValue( Anims.Combine[ "models" ], string.lower( model ) ) then
		return "Female"
	end
	
	return "Male"

end

local rifleholdtypes = {
	"smg",
	"ar2",
	"shotgun",
	"crossbow",
	"rpg",
	"physgun"
	
}

local meleeholdtypes = {
	"normal",
	"passive",
	"knife",
	"melee2",
	"melee" 
}

local grenadeholdtypes = {
	"grenade",
	"slam"
}
		
local function DetectHoldType( act )
	if string.match(  act, "pistol" ) then
		return "pistol"
	end
	for k, v in pairs( rifleholdtypes ) do
		if string.match( act, v ) then
			return "rifle"
		end
	end
	for k, v in pairs( meleeholdtypes ) do
		if string.match( act, v ) then
			return "melee"
		end
	end
	for k, v in pairs( grenadeholdtypes ) do
		if string.match( act, v ) then
			return "grenade"
		end
	end
	
	return "default"
	
end

function GM:UpdateAnimation( ply, velocity, maxseqgroundspeed )

	local eye = ply:EyeAngles()
	ply:SetLocalAngles( eye )

	if CLIENT then
		ply:SetRenderAngles( eye ) 
	end
	
	local estyaw = math.Clamp( math.atan2(velocity.y, velocity.x) * 180 / 3.141592, -180, 180 )
	local myaw = math.NormalizeAngle(math.NormalizeAngle(eye.y) - estyaw)
	
        // set the move_yaw (because it's not an hl2mp model)
	ply:SetPoseParameter("move_yaw", myaw * -1 ) 
	
	local len2d = velocity:Length2D()
	local rate = 1.0
	
	if len2d > 0.5 then
			rate =  ( ( len2d * 0.8 ) / maxseqgroundspeed )
	end
	
	rate = math.Clamp(rate, 0, 1.5)
        // you can obviously set your own playback rate
	
	ply:SetPlaybackRate( rate )
end

function GM:HandlePlayerJumping( ply )

        
        // don't airwalk, pretend we're floating, but we can airwalk underwater
        if !ply.m_bJumping && !ply:OnGround() && ply:WaterLevel() <= 0 then
                ply.m_bJumping = true
                ply.m_bFirstJumpFrame = false
                ply.m_flJumpStartTime = 0
        end
        
        if ply.m_bJumping then
				--print( "I'M FUCKING JUMPING" )
                if ply.m_bFirstJumpFrame then
                        ply.m_bFirstJumpFrame = false
                        ply:AnimRestartMainSequence()
                end
                
                if ply:WaterLevel() >= 2 then
                        ply.m_bJumping = false
                        ply:AnimRestartMainSequence()
                elseif (CurTime() - ply.m_flJumpStartTime) > 0.2 then
                        if ply:OnGround() then
                                ply.m_bJumping = false
                                ply:AnimRestartMainSequence()
                        end
                end
                
                if ply.m_bJumping then
                        ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ "default" ][ "jump" ] )
                        return true
                end
        end
        
        return false
end
 
function GM:HandlePlayerDucking( ply, velocity )

		local holdtype = "default"
		if( ValidEntity(  ply:GetActiveWeapon() ) ) then
			holdtype = DetectHoldType( ply:GetActiveWeapon():GetHoldType() ) 
		end
        if ply:Crouching() then
			--print( "I'M FUCKING DUCKING" )
			if ply:GetNWBool( "aiming", false ) then
                local len2d = velocity:Length2D()
                if len2d > 0.5 then
                        ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][ holdtype ][ "crouch" ][ "aimwalk" ] )
                else
                        ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][ holdtype][ "crouch" ][ "aimidle" ] )
                end
			else
				local len2d = velocity:Length2D()
                
                if len2d > 0.5 then
						ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ holdtype ][ "crouch" ][ "walk" ] )
                else
                        ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ holdtype ][ "crouch" ][ "idle" ] )
                end
			end
			return true
        end
        
        return false
end
 
function GM:HandlePlayerSwimming( ply )

        if ply:WaterLevel() >= 2 then
                if ply.m_bFirstSwimFrame then
                        --ply:AnimRestartMainSequence()
						ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ "default" ][ "fly" ] )
                        ply.m_bFirstSwimFrame = false
                end
				--print( "I'M FUCKING SWIMMING" )
                ply.m_bInSwim = true
        else
                ply.m_bInSwim = false
                if !ply.m_bFirstSwimFrame then
                        ply.m_bFirstSwimFrame = true
                end
        end
        
        return false
end
 
function GM:HandlePlayerDriving( ply )
 
        if ply:InVehicle() then
			--print( "I'M FUCKING DRIVING" )
			 local pVehicle = ply:GetVehicle()
            local class = pVehicle:GetClass()
                        
				if ( class == "prop_vehicle_prisoner_pod" && pVehicle:GetModel() == "models/vehicles/prisoner_pod_inner.mdl" ) then
                        ply.CalcIdeal = ACT_IDLE
                else
						ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ "default" ][ "sit" ] )
                end
                        
                return true
        end
        
        return false
end

function GM:CalcMainActivity( ply, velocity ) 
		local holdtype = "default"
		if( ValidEntity(  ply:GetActiveWeapon() ) ) then
			holdtype = DetectHoldType( ply:GetActiveWeapon():GetHoldType() ) 
		end
		--print( "I'M FUCKING SETTING THE HOLDTYPE TO " .. holdtype )
        ply.CalcIdeal = ACT_IDLE
        ply.CalcSeqOverride = -1
        
        if self:HandlePlayerDriving( ply ) ||
                self:HandlePlayerJumping( ply ) ||
                self:HandlePlayerDucking( ply, velocity ) ||
                self:HandlePlayerSwimming( ply ) then
				
		else
                local len2d = velocity:Length2D()
				
					if ply:GetNWBool( "aiming", false ) then
						if len2d > 210 then
							ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][  holdtype ][ "run" ] )
							--print( "I'M FUCKING RUNNING WHILE AIMING" )
						elseif len2d > 0.5 then
							--print( "I'M FUCKING WALKING WHILE AIMING" )
							ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][  holdtype ][ "aim" ][ "walk" ] )
						else
							--print( "I'M FUCKING STANDING WHILE AIMING" )
							ply.CalcIdeal  = HandleSequence( ply, Anims[ getgender( ply ) ][  holdtype ][ "aim" ][ "idle" ] )
						end
					else
						if len2d > 210 then
							--print( "I'M FUCKING RUNNING" )
							ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][  holdtype ][ "run" ] )
						elseif len2d > 0.5 then
							--print( "I'M FUCKING WALKING" )
							ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][  holdtype ][ "walk" ] )
						else
							--print( "I'M FUCKING STANDING" )
							ply.CalcIdeal =  HandleSequence( ply, Anims[ getgender( ply ) ][  holdtype ][ "idle" ] )
						end
					end


        end
        --print( tostring( ply.CalcSeqOverride ) .. " IS THE SEQUENCE!" )
        return ply.CalcIdeal, ply.CalcSeqOverride
end		
        
function GM:TranslateActivity( ply, act )
		
		--We're not translating through the weapon
		return act
		
end
 
function GM:DoAnimationEvent( ply, event, data )

		local holdtype = "default"
		if( ValidEntity(  ply:GetActiveWeapon() ) ) then
			holdtype = DetectHoldType( ply:GetActiveWeapon():GetHoldType() ) 
		end

        if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
				if Anims[ getgender( ply ) ][ holdtype ][ "fire" ] then
						if( string.match( Anims[ getgender( ply ) ][ holdtype ][ "fire" ], "GESTURE" ) ) then
								ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, FindEnumeration(  Anims[ getgender( ply ) ][ holdtype ][ "fire" ] ) ) -- Not a sequence, so I don't use HandleSequence here.
						else
								ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ holdtype ][ "fire" ] )
						end	
				else
						ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GESTURE_RANGE_ATTACK_SMG1 )
				end

                return ACT_VM_PRIMARYATTACK
                
        elseif event == PLAYERANIMEVENT_RELOAD then
				if Anims[ getgender( ply ) ][ holdtype ][ "reload" ] then
						if( string.match( Anims[ getgender( ply ) ][ holdtype ][ "reload" ], "GESTURE" ) ) then
								ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, FindEnumeration(  Anims[ getgender( ply ) ][ holdtype ][ "reload" ] ) )
						else
								ply.CalcIdeal = HandleSequence( ply, Anims[ getgender( ply ) ][ holdtype ][ "reload" ] )
						end	
				else
                        ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GESTURE_RELOAD_SMG1 )
				end
                
                return ACT_INVALID
		elseif event == PLAYERANIMEVENT_CANCEL_RELOAD then
        
                ply:AnimResetGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD )
                
                return ACT_INVALID
        end
                
        if event == PLAYERANIMEVENT_JUMP then
        
                ply.m_bJumping = true
                ply.m_bFirstJumpFrame = true
                ply.m_flJumpStartTime = CurTime()
                
                ply:AnimRestartMainSequence()
                
                return ACT_INVALID
                
		end
 
        return nil
end

Msg( "Gamemode file; animations.lua loaded\n" )

local function PlayerSpawn( pl )
	pl:SetDTFloat( 3, 1 )
	pl:GetTable().WalkSpeed = 80
	pl:GetTable().StaminaDrain 		= .1
	pl:GetTable().StaminaRegen 		= pl:GetTable().StaminaDrain / 3.5
	pl:GetTable().RunSpeed = 260
	pl:GetTable().JogSpeed = 140
	pl:GetTable().HighWeight = 50
	pl:GetTable().MaxWeight = 60
	pl:SetWalkSpeed( pl:GetTable().JogSpeed )
end
local ExoModels = {
"models/srp/masterduty.mdl",
"models/srp/masterfreedom.mdl",
"models/srp/mastermercenary.mdl",
"models/srp/mastermonolith.mdl",
"models/srp/masterstalker.mdl"
}
local function Think( )
	local k, v, delta, a, b, c, vel, moving
	
	delta = FrameTime( )
	
	for k, v in ipairs( player.GetAll( ) ) do
		if not ValidEntity( v ) or not v:Alive( ) then
			return
		end
		
		a = v:GetDTFloat( 3 )
		vel = v:GetVelocity( )
		vel.z = 0
		vel = vel:Length( )
		
		moving = v:KeyDown( IN_FORWARD ) or v:KeyDown( IN_MOVERIGHT ) or v:KeyDown( IN_BACK ) or v:KeyDown( IN_MOVELEFT )
		
		--Calculate stamina
		if v:KeyDown( IN_SPEED ) and ( v:IsOnGround( ) or v:WaterLevel( ) > 0 ) and vel > 0 and not ValidEntity( v:GetVehicle( ) ) and moving then
			--We're on the ground ( or swimming ), sprinting, and not driving
			a = math.Approach( a, 0, delta * v:GetTable().StaminaDrain  )
		else
			if( v:OnGround() ) then
			--Not sprinting, so regenerate it
			if( v:KeyDown( IN_WALK ) or vel == 0) then
			a = math.Approach( a, 1, delta * ( v:GetTable().StaminaRegen ))
			else
			a = math.Approach( a, 1, delta * ( v:GetTable().StaminaRegen / 2 ))
			end
		end
		end
/*
		if v:KeyPressed( IN_JUMP ) then
		if( a >= .1 ) then
			a = a - .1
		end
		end
*/
		if v:KeyDown( IN_SPEED ) then
		if a <= 0.05  then
				v:SetRunSpeed(v:GetTable().JogSpeed)
		elseif( a <= .5 ) then
			v:SetRunSpeed( v:GetTable().JogSpeed + 30 )
		else
			v:SetRunSpeed( v:GetTable().RunSpeed )
		end
	//	elseif v:KeyDown( IN_WALK ) then
	//		v:SetWalkSpeed( v:GetTable().WalkSpeed )
	//	else
	//		v:SetWalkSpeed( v:GetTable().JogSpeed )
		end
		for z,x in pairs( ExoModels ) do
		if( v:GetModel() == x ) then
			 v:SetRunSpeed(v:GetTable().JogSpeed)
		end
		end
	//	if( v:Team() != 24 ) then
	//	if( v:GetDTFloat( 1 ) > v:GetTable().HighWeight ) then
	//		v:SetRunSpeed(v:GetTable().JogSpeed)
	//	elseif( v:GetDTFloat( 1 ) > v:GetTable().MaxWeight() ) then
	//		v:SetRunSpeed( 0 )
	//	end
	//	end
		v:SetDTFloat( 3, a )

	end
end
/*
function BlockJump( ply, bind, pressed )
RAD.DayLog( "script.txt", "Player" .. ply:GetName() .. " running bind " .. bind );
end

hook.Add( "PlayerBindPress", "BlockJump", BlockJump )
*/

function KeyPressed (ply, key)
	if( key == IN_JUMP ) then
		if( ply:GetDTFloat( 3)  >= .1 ) then
			ply:SetDTFloat( 3, ply:GetDTFloat( 3) - .1 )
		end
	end
	if( key == IN_FORWARD or key == IN_MOVERIGHT or key == IN_MOVELEFT or key == IN_BACK  ) then
		if key ==  IN_WALK  then
			ply:SetWalkSpeed( ply:GetTable().WalkSpeed )
		else
			ply:SetWalkSpeed( ply:GetTable().JogSpeed )
		end
	end
end
 
hook.Add( "KeyPress", "KeyPressedHook", KeyPressed )

hook.Add( "Think"			, "Stamina.Think"			, Think 			)
hook.Add( "PlayerSpawn"			, "Stamina.PlayerSpawn"			, PlayerSpawn 			)
hook.Add( "PlayerSwitchFlashlight"	, "Stamina.PlayerSwitchFlashlight"	, PlayerSwitchFlashlight 	)
