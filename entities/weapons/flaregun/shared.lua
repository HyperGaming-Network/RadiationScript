if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	SWEP.HoldType			= "pistol"
end

SWEP.Author = "Silver Knight"
SWEP.Contact = ""
SWEP.Purpose = "S.T.A.L.K.E.R RolePlay"
SWEP.Instructions = "Left click to fire flares."
SWEP.Base = "weapon_base"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/Weapons/v_357.mdl"
SWEP.WorldModel = "models/Weapons/W_357.mdl"

SWEP.Primary.Sound = Sound( "weapons/flaregun/fire.wav" )
SWEP.Primary.NumShots = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 3
SWEP.Primary.Ammo = "GaussEnergy"

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false

SWEP.ReloadOnEmpty = true

function SWEP:Think()
	if !self.Flare or !ValidEntity( self.Flare ) then return end
    if self.Flare:WaterLevel() > 0 then self.Flare:Fire( "Die", "0.1", 0 ) end
	
	for k, v in pairs( ents.FindInSphere( self.Flare:GetPos(), 12 ) ) do
		if ValidEntity( v ) and ( v:IsNPC()) and v != self.Owner and v:Health() > 0 then
			v:Ignite( math.Rand( 14, 21 ), 1 )
		end
	end
end

function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 then return end
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:EmitSound( self.Primary.Sound )
	self:SetClip1( self:Clip1() -1 )
	self:LaunchFlare()	
	self.Weapon:TakePrimaryAmmo( 1 )
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
end

function SWEP:SecondaryAttack()
end

function SWEP:LaunchFlare()
	local tracer = self.Owner:GetEyeTrace()

	self.Flare = ents.Create("env_flare")
	self.Flare:SetPos(self.Owner:GetShootPos())
	self.Flare:SetAngles( self.Owner:GetAimVector( ):Angle() )
	self.Flare:SetKeyValue( "scale", "1" )
	self.Flare:EmitSound("Weapon_Flaregun.Burn")
	self.Flare:Spawn()
	self.Flare:Activate()
	self.Flare:Fire( "Launch", "1000", 0.1 )
end