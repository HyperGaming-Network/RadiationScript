if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "BloodSucker Cloak";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "Silver Knight"
SWEP.Instructions	= "Right Click To Cloak"
SWEP.Contact		= "www.HyperGamer.Net"
SWEP.Purpose		= "S.T.A.L.K.E.R. Role Play"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.IconLetter	= "j"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.NextStrike = 0;
SWEP.NextCloak = 0;
SWEP.Cloaked = false;
SWEP.CurrentCloak = 255;
  
SWEP.ViewModel      = ""
SWEP.WorldModel     = ""
   
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"

util.PrecacheSound("hgn/stalker/player/invisible_2.mp3") 

if SERVER then
	function DoSpyRespawn( ply )
		if ply.Cloaked then
			ply.Cloaked = false;
			ply:SetColor( 255, 255, 255, 255 );
			ply:DrawViewModel( true );
		end
	end
	hook.Add( "PlayerSpawn", "DoSpyRespawn", DoSpyRespawn );
end

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( "normal" );
	end
end

function SWEP:Precache()
end

function SWEP:Deploy()
	self.Owner.Cloaked = false;
	self.LastHealth = self.Owner:Health();
	self.Owner:EmitSound( "" );
	self.Cloaked = false;
	self.CurrentCloak = 255;
	self.Owner:SetColor( 255, 255, 255, 255 );
	self.NextCloak = CurTime();
	self.NextStrike = CurTime();
	self.Owner:DrawViewModel( true );
	return true;
end

function SWEP:Holster( wep )
	if self.Owner then
		if self.Owner:IsValid() and self.Owner:Alive() then
			self.Owner.Cloaked = false;
			self.Cloaked = false;
			self.CurrentCloak = 255;
			self.Owner:SetColor( 255, 255, 255, 255 );
			self.NextCloak = CurTime();
			self.NextStrike = CurTime();
		end
	end
	return true;
end 

function SWEP:PrimaryAttack()

end

function SWEP:Think()
	if self.Cloaked then
		if self.LastHealth > self.Owner:Health() then
			self.CurrentCloak = 50;
			self.StartCloak = true;
			self.Owner:DrawViewModel( true );
		end
		self.LastHealth = self.Owner:Health();
		
		if CurTime() >= self.CloakTimer then
			self.CurrentCloak = 0;
			self.StartUnCloak = true;
			self.Cloaked = false;
			self.Owner:DrawViewModel( true );
		end
	end
	if self.StartUnCloak then
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Your Visible" )
		self.CurrentCloak = self.CurrentCloak + 1;
		self.Owner:SetColor( 255, 255, 255, self.CurrentCloak )
		self.Weapon:SetColor( 255, 255, 255, self.CurrentCloak )
		if self.CurrentCloak == 255 then
			self.StartUnCloak = false;
			self.NextStrike = ( CurTime() + 0.1 );
			self.Owner.Cloaked = false;
		end
	elseif self.StartCloak then
	    self.Owner:PrintMessage( HUD_PRINTCENTER, "Your Cloaked" )
		self.CurrentCloak = self.CurrentCloak - 1;
		self.Owner:SetColor( 255, 255, 255, self.CurrentCloak )
		self.Weapon:SetColor( 255, 255, 255, self.CurrentCloak )
		if self.CurrentCloak == 0 then
			self.Weapon:EmitSound( "hgn/stalker/player/invisible_2.mp3" )
			self.StartCloak = false;
			self.Owner:DrawViewModel( false );
			self.Owner.Cloaked = true;
		end
	end
end
	
function SWEP:SecondaryAttack()
	if( CurTime() < self.NextCloak ) then return; end
	self.NextCloak = ( CurTime() + 5 );
	
	if self.Cloaked then
		self.CurrentCloak = 0;
		self.StartUnCloak = true;
		self.Cloaked = false;
		self.Owner:DrawViewModel( true );
	else
		self.CloakTimer = CurTime() + 20;
		self.NextStrike = ( CurTime() + 1000000 );
		self.CurrentCloak = 255;
		self.StartCloak = true;
		self.Cloaked = true;
	end
end
	

function SWEP:Reload()
	self.Weapon:EmitSound( "hgn/stalker/background/sucker_growl_1.mp3" )
end 