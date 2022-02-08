if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false -- Crosshairs are for wimps.
	SWEP.ViewModelFOV		= 76
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= true
		
	SWEP.Slot				= 4
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "k"
	SWEP.DrawWeaponInfoBox  = true
	
	killicon.AddFont("SPAS-12", "CSKillIcons", SWEP.IconLetter, Color(255, 220, 0, 255))
	
end

SWEP.Base			= "base"
SWEP.HoldType = "smg"

------------
-- Info --
------------
SWEP.PrintName		= "SPAS-12"	
SWEP.Author			= "LastExile"
SWEP.Purpose		= "S.T.A.L.K.E.R. Role Play"
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
SWEP.Primary.Sound			= Sound("weapons/srp/hgn/spas12/shotgun_fire".. math.random(6,7) ..".wav")
SWEP.Primary.Damage			= 4 -- This determines both the damage dealt and force applied by the bullet.
SWEP.Primary.NumShots		= 12
SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Ammo			= "buckshot"
SWEP.MuzzleVelocity			= 900 -- How fast the bullet travels in meters per second. For reference, an AK47 shoots at about 750, an M4 shoots at about 900, and a Luger 9mm shoots at about 350 (source: Wikipedia)
SWEP.FiresUnderwater 		= false
SWEP.Primary.Reload			= Sound("weapons/srp/hgn/spas12/shotgun_reload".. math.random(1,3) ..".wav")


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
SWEP.MinRecoil		= 0.3
SWEP.MaxRecoil		= 1.0
SWEP.DeltaRecoil	= 0.3 -- The recoil to add each shot.  Same deal for spread and spray.

-- Spread: the width of the gun's firing cone.  More spread means less accuracy.
SWEP.MinSpread		= 0.02
SWEP.MaxSpread		= 0.4
SWEP.DeltaSpread	= 0.02

-- Spray: the gun's tendancy to point in random directions.  More spray means less control.
SWEP.MinSpray		= 0
SWEP.MaxSpray		= 1.4
SWEP.DeltaSpray		= 0.2


---------------------------
-- Ironsight/Scope --
---------------------------
-- IronSightsPos and IronSightsAng are model specific paramaters that tell the game where to move the weapon viewmodel in ironsight mode.
SWEP.IronSightsPos = Vector (-8.9463, -11.5589, 4.1852)
SWEP.IronSightsAng = Vector (0.1404, 0.0175, 0)
SWEP.IronSightZoom			= 1.3 -- How much the player's FOV should zoom in ironsight mode. 
SWEP.UseScope				= false -- Use a scope instead of iron sights.
SWEP.ScopeScale 			= 0.4 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZooms				= {4,8,16} -- The possible magnification levels of the weapon's scope.   If the scope is already activated, secondary fire will cycle through each zoom level in the table.
SWEP.DrawParabolicSights	= false -- Set to true to draw a cool parabolic sight (helps with aiming over long distances)
SWEP.RunArmOffset = Vector (6.9463, -14.8268, 0.172)
SWEP.RunArmAngle = Vector (-9.4227, 42.9962, -1.3404)
-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel				= "models/srp/weapons/v_spas12.mdl"
SWEP.WorldModel				= "models/srp/weapons/w_spas12.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_grenade" -- This is an extra muzzleflash effect
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_shotgun" -- This is a shell ejection effect
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment	= "2" -- Should be "2" for CSS models or "1" for hl2 models


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
SWEP.AvailableFireModes		= {"Shotgun"} -- What firemodes shall we use?
-- "Auto", "Burst", "Semi", and "Grenade" are firemodes that are available by default.

-- RPM is the rounds per minute the gun can fire for each mode (if applicable)
SWEP.AutoRPM				= 240
SWEP.SemiRPM				= 240
SWEP.BurstRPM				= 1800 -- Burst RPM affects the space between the shots during the burst.  The space between bursts is determined by SemiRPM.
SWEP.DrawFireModes			= true -- Set to true to allow drawing of a visual indicator for the current firemode.

-- Additional parameters for the "Grenade" firemode
--SWEP.GrenadeDamage			= 100
--SWEP.GrenadeVelocity		= 1400
--SWEP.GrenadeRPM				= 50


-- Custom firemodes!
---------------------------------------------
-- Firemode: Shotgun --
---------------------------------------------
-- Description: A shotgun
SWEP.FireModes = {} -- Don't touch this!

SWEP.FireModes.Shotgun = {} -- Our firemode's main table. 
-- If you want this firemode to be used, the part after the SWEP.FireModes. (in this case, "Shotgun") should be defined as a string in the SWEP.AvailableFireModes table

SWEP.ShotgunRPM 								= 240 -- We can define our own variables for this firemode if we so desire
SWEP.FireModes.Shotgun.NumBullets 	= 12 -- Either way of adding variables is fine, as long as we call the right variable name when we need it

-- Generally, a firemode consists of 4 main functions: the FireFunction, InitFunction,RevertFunction, and HUDDrawFunction

-- This function is called when the player attacks and the firemode is active.
SWEP.FireModes.Shotgun.FireFunction = function(self)

	if not self:CanFire(self.Weapon:Clip1()) then return end -- Do we have enough ammo to fire?
	-- Note: if you want your firemode to use the secondary ammo, I reccomend replacing self.Weapon:Clip1() with self.Weapon:Ammo2()
	
	if not self.OwnerIsNPC then
		self:TakePrimaryAmmo(1) -- NPCs get infinate ammo, as they don't know how to reload	
		-- ^ obviously, this should be self:TakeSecondaryAmmo(1) if your firemode uses secondary ammo.
	end
	
	--Fire ze bullets!
	self:RGShootBullet(
	4, 											--Damage per shot
	self.BulletSpeed, 								--Speed of the bullet (this variable is derived from self.MuzzleVelocity)
	0.1, 											-- Bullet Spread
	0.2, 												-- Bullet Spray
	Vector(0,0,0),									-- Vector corresponding to the direction the gun is currently spraying ("SprayVec")
	self.FireModes.Shotgun.NumBullets)	-- How many bullets to fire
	-- Note that some paramters (damage per shot, spread, spray, recoil) were not defined in outside variables, but rather inside the firefunction itself.  How you  want to handle this is up to you.
	
	-- Apply recoil and spray
	self:ApplyRecoil(
	2,						-- Recoil
	0.5)						-- Spray

	self:ShootEffects()		-- Animations, sounds, muzzle flash, shell ejection...
	
	-- Note: the functions used here (RGShootBullet, ApplyRecoil, and ShootEffects) are defined under rg_base/shared.lua
		
end


-- This function initializes the firemode.  It can be used to update variables within the SWEP's table, such as the firing delay.
SWEP.FireModes.Shotgun.InitFunction = function(self)


	-- self.Primary.Delay and self.Primary.Automatic should be set in every firemode function, as there is no true default value for these variables
	self.Primary.Automatic = false -- 'tis not an automatic shotgun
	self.Primary.Delay = 60/self.ShotgunRPM -- This is how you convert from RPM to delay between shots
	
	self.FiresUnderwater = false -- This makes it able to be fired underwater
	-- Change the effects to be more shotgunny
	self.ShellEffect			= "rg_shelleject_shotgun"
	self.MuzzleEffect			= "rg_muzzle_grenade"
	self.Primary.Sound			= Sound("weapons/srp/spas12/shotgun_fire".. math.random(6,7) ..".wav")
	
	if CLIENT then
		-- self.FireModeDrawTable is a predefined clientside table we can use to store stuff for drawing info about this firemode to the HUD. You can add/call anything you want to/from it.
		self.FireModeDrawTable.x = 0.037*surface.ScreenWidth() -- These variables are the position on the player's screen that the firemode's icon will be drawn.
		self.FireModeDrawTable.y = 0.912*surface.ScreenHeight()
	end

end

-- In this function, we should undo what we did in the init function
SWEP.FireModes.Shotgun.RevertFunction = function(self) 
	
	-- Revert the effects too
	self.ShellEffect			= "rg_shelleject_shotgun"
	self.MuzzleEffect			= "rg_muzzle_grenade"
	self.Primary.Sound			= Sound("weapons/srp/spas12/shotgun_fire".. math.random(6,7) ..".wav")
	
	-- self.Primary.Delay and self.Primary.Automatic don't need to be reset because they don't really have defaults.
	-- Also, there is no need to revert any values in self.FireModeDrawTable, as those are generally firemode specific.

end

-- This function can be used to give the player a visual indication of his current firemode.  It is called under SWEP:DrawHUD() every client frame.
SWEP.FireModes.Shotgun.HUDDrawFunction = function(self)

	surface.SetFont("rg_firemode") -- This custom font contains the HL2 weapon icons (see "half-life 2/hl2/resource/halflife2.ttf")
	surface.SetTextPos(self.FireModeDrawTable.x,self.FireModeDrawTable.y) -- Draw this font to the position we defined in the init function.
	surface.SetTextColor(255,220,0,200) -- Default HUD color
	surface.DrawText("s") -- "s" corresponds to the hl2 shotgun ammo icon in this font
	
	-- Note: you don't have to draw a little icon in the corner of the screen if you don't want to.  If you feel like it, you can make this function repeatedly flash goatse to the player's screen (note: don't actually do this).  It's pretty flexible.

end

function SWEP:Reload()
	self:SetIronsights(false,self.Owner)
	if self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
		return false
	end
	if CurTime() >= self.ReloadTapDone then
		if self.OneReloadTap then
			if !self.AddedHoldingPenalty then
				self.AddedHoldingPenalty = true
				self.Weapon.reloadtimer = self.Weapon.reloadtimer + 0.4
			else
			self.OneReloadTap = true
			end
		end
	end
	if !self.Weapon.reloadtimer || CurTime() > self.Weapon.reloadtimer then
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
		self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
		if self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
			timer.Simple( 0.4, function() self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH ) end )
			timer.Simple( 1.4, function() self.Weapon:SendWeaponAnim( ACT_VM_IDLE ) end )
		end
		self.Weapon.reloadtimer = CurTime() + 0.4
		self.ReloadTapDone = CurTime() + 0.3
		self.OneReloadTap = false
		self.AddedHoldingPenalty = false
	end
end
