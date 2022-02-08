
// Variables that are used on both client and server

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "Left click to make players freak out. Right click to make them shoot. Reload to force focus"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

local ShootSound = Sound( "Metal.SawbladeStick" )

/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
local shoottime = 0
function SWEP:Reload()
if( CLIENT ) then return end;
	if( shoottime > CurTime() ) then return end;
	local tr = self.Owner:GetEyeTrace()
	if( tr.Entity:IsPlayer() ) then
	if(  tr.Entity == self.Owner ) then return end;

//	shoottime = CurTime() + 3

	local WPos = self.Owner:GetPos()
//		WPos = WPos + Vector( 0, 0, 64 )

	
	local CamPos = tr.Entity:GetPos()
	local Ang = WPos - CamPos
		if( CamPos:Distance( WPos ) > 1000 ) then return false end 
		shoottime = CurTime() + 3
	Ang = Ang:Angle()
	tr.Entity:SetEyeAngles(Ang)
	tr.Entity:Freeze( true )
	tr.Entity:SetFOV(10, .7) 
	tr.Entity:ConCommand( "play hgn/stalker/player/controller_final_hit_l.mp3" )
	self.Owner:Freeze( true )
local dmginfo = DamageInfo()
dmginfo:SetDamage( 20 ) --50 damage
dmginfo:SetDamageType( 262144 ) --Bullet damage
dmginfo:SetAttacker( ents.GetAll()[1] ) --First player found gets credit
dmginfo:SetDamageForce( Vector( 0, 0, 0) ) --Launch upwards
 tr.Entity:TakeDamageInfo( dmginfo ) --Take damage!
      timer.Simple(.7, function() self.Owner:Freeze( false ) end )

      timer.Simple(1, function() tr.Entity:SetFOV(0, .3) end )
      timer.Simple(1.3, function() tr.Entity:Freeze( false ) end )
//	self.Owner:Freeze( true )
end
end

function Test1( ply1, ply2 )

	local WPos = ply1:GetPos()
	//	WPos = WPos - Vector( 0, 0, 64 )

	
	local CamPos = ply2:GetPos()
	local Ang = WPos - CamPos
	
	Ang = Ang:Angle()
	ply2:SnapEyeAngles(Ang)
	ply2:Freeze( true )
	ply2:SetFOV(ply2:Distance( ply1 ) / 15, .7) 
	ply2:ConCommand( "play hgn/stalker/player/controller_final_hit_l.mp3" )
      timer.Simple(.7, function() ply2:SetFOV(0, .3) end )
      timer.Simple(1, function() ply2:Freeze( false ) end )
//	self.Owner:Freeze( true )

end 
/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	
end


/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	local tr = self.Owner:GetEyeTrace()
	if( tr.Entity:IsPlayer() ) then
		tr.Entity:ViewPunch( Angle( math.Rand( -10, 10 ), math.Rand( -10, 10 ), 0 ) )
		tr.Entity:SetFOV(120, 5)
		 timer.Simple(5, function() tr.Entity:SetFOV(20, 10) end )
		 timer.Simple(15, function() tr.Entity:SetFOV(0, 5) end )
	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	local tr = self.Owner:GetEyeTrace()
	if( tr.Entity:IsPlayer() ) then
		tr.Entity:ViewPunch( Angle( math.Rand( -10, 10 ), math.Rand( -10, 10 ), 0 ) )
		tr.Entity:ConCommand("+attack")
		 timer.Simple(2, function() tr.Entity:ConCommand("-attack") end )
	end
	
end


/*---------------------------------------------------------
   Name: ShouldDropOnDie
   Desc: Should this weapon be dropped when its owner dies?
---------------------------------------------------------*/
function SWEP:ShouldDropOnDie()
	return false
end
