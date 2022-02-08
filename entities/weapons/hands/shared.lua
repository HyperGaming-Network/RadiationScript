if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName      = "Hands"
	SWEP.Author    = "SilverKnight"
	SWEP.Contact    = ""
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	
	
end

local meta = FindMetaTable( "Entity" );

local DoorTypes =
{

	"func_door",
	"func_door_rotating",
	"prop_door_rotating"

}

function meta:IsDoor()

	local class = self:GetClass();
	
	for k, v in pairs( DoorTypes ) do
	
		if( v == class ) then return true; end
	
	end
	
	return false;

end
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable  = true
 
SWEP.ViewModel      = ""
SWEP.WorldModel   = ""
 
SWEP.Primary.ClipSize      = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic    = false

SWEP.Secondary.ClipSize      = 0
SWEP.Secondary.DefaultClip    = 0

function SWEP:Reload()
end

function SWEP:Initialize()
	if (CLIENT) then return end
	self:SetWeaponHoldType("normal")
end

function SWEP:PrimaryAttack()
  	local trace = { }
	trace.start = self.Owner:EyePos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 60;
	trace.filter = self.Owner;
  	
  	local tr = util.TraceLine( trace );
  	
    if( ValidEntity( tr.Entity ) and tr.Entity:IsDoor() ) then



    end

end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
end
