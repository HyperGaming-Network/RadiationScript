-- 'Realistic' Gun base: example SWEP
-- By Teta_Bonita

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false -- Crosshairs are for wimps.
	SWEP.ViewModelFOV		= 76
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
		
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.IconLetter			= "b"
	SWEP.DrawWeaponInfoBox  = true
	
	killicon.AddFont("AK-74M", "CSKillIcons", SWEP.IconLetter, Color(255, 220, 0, 255))
	
end

SWEP.Base			= "base"
SWEP.HoldType = "smg"

------------
-- Info --
------------
SWEP.PrintName		= "AK-47"	
SWEP.Author			= "SilverKnight"
SWEP.Purpose		= "S.T.A.L.K.E.R Roleplay"
SWEP.Instructions	= "Hold your use key and press secondary fire to change fire modes."

-------------
-- Misc. --
-------------
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.Weight				= 8.5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.WepType = "wepitem"


----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound("Weapon_AK74.Single")
SWEP.Primary.Damage			= 14 -- This determines both the damage dealt and force applied by the bullet.
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Ammo			= "smg1"
SWEP.MuzzleVelocity			= 900 -- How fast the bullet travels in meters per second. For reference, an AK47 shoots at about 750, an M4 shoots at about 900, and a Luger 9mm shoots at about 350 (source: Wikipedia)
SWEP.FiresUnderwater 		= false


-------------------------
-- Secondary Fire --
-------------------------
-- Secondary Fire is used to switch ironsights and firemodes
SWEP.Secondary.ClipSize		= -1 -- best left at -1
SWEP.Secondary.DefaultClip	= -1 -- set to -1 if you don't use secondary ammo
SWEP.Secondary.Ammo			= "none" -- Leave this if you want your SWEP to have grenades, otherwise set to "none" if you don't use secondary ammo.


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 0.8 -- Time in seconds it takes the player to re-steady his aim after firing.

-- The following variables control the overall accuracy of the gun and typically increase with each shot
-- Recoil: how much the gun kicks back the player's view.
SWEP.MinRecoil		= 0.1
SWEP.MaxRecoil		= 0.7
SWEP.DeltaRecoil	= 0.15 -- The recoil to add each shot.  Same deal for spread and spray.

-- Spread: the width of the gun's firing cone.  More spread means less accuracy.
SWEP.MinSpread		= 0.003
SWEP.MaxSpread		= 0.06
SWEP.DeltaSpread	= 0.0055

-- Spray: the gun's tendancy to point in random directions.  More spray means less control.
SWEP.MinSpray		= 0
SWEP.MaxSpray		= 1.7
SWEP.DeltaSpray		= 0.2


---------------------------
-- Ironsight/Scope --
---------------------------
-- IronSightsPos and IronSightsAng are model specific paramaters that tell the game where to move the weapon viewmodel in ironsight mode.
--------------------

SWEP.IronSightsPos = Vector (6.1096, -3.3198, 2.0515)
SWEP.IronSightsAng = Vector (3.1359, 0.0388, 0)
--------------------
SWEP.IronSightZoom			= 1.3 -- How much the player's FOV should zoom in ironsight mode. 
SWEP.UseScope				= false -- Use a scope instead of iron sights.
SWEP.ScopeScale 			= 0.4 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZooms				= {4,8,16} -- The possible magnification levels of the weapon's scope.   If the scope is already activated, secondary fire will cycle through each zoom level in the table.
SWEP.DrawParabolicSights	= false -- Set to true to draw a cool parabolic sight (helps with aiming over long distances)

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel				= "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_ak47.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_rifle" -- This is an extra muzzleflash effect
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_rifle" -- This is a shell ejection effect
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment	= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.Primary.Sound = Sound( "Weapon_AK47.Single" );
SWEP.RunArmOffset  = Vector (-7.8485, -5.5701, -1.0282)
SWEP.RunArmAngle= Vector (-9.4639, -47.4063, 2.0318)

-------------------
-- Modifiers --
-------------------
-- Modifiers scale the gun's recoil, spread, and spray based on the player's stance
SWEP.CrouchModifier		= 0.7 -- Applies if player is crouching.
SWEP.IronSightModifier 	= 0.7 -- Applies if player is in iron sight mode.
SWEP.RunModifier 		= 1.4 -- Applies if player is moving.
SWEP.JumpModifier 		= 1.6 -- Applies if player is in the air (jumping)

-- Note: the jumping and crouching modifiers cannot be applied simultaneously

--------------------
-- Fire Modes --
--------------------
-- You can choose from a list of firemodes, or add your own! \0/
SWEP.AvailableFireModes		= {"Auto","Semi","Burst"} -- What firemodes shall we use?
-- "Auto", "Burst", "Semi", and "Grenade" are firemodes that are available by default.

-- RPM is the rounds per minute the gun can fire for each mode (if applicable)
SWEP.AutoRPM				= 650
SWEP.SemiRPM				= 650
SWEP.BurstRPM				= 1800 -- Burst RPM affects the space between the shots during the burst.  The space between bursts is determined by SemiRPM.
SWEP.DrawFireModes			= true -- Set to true to allow drawing of a visual indicator for the current firemode.

-- Additional parameters for the "Grenade" firemode
--SWEP.GrenadeDamage			= 100
--SWEP.GrenadeVelocity		= 1400
--SWEP.GrenadeRPM				= 50


-- Custom firemodes!
