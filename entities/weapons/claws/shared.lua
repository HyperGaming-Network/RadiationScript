--------------------Server and Client Swep Settings  ------------------------ 
if (SERVER) then 
  
    AddCSLuaFile( "shared.lua" ) 
    SWEP.Weight    = 2 
    SWEP.AutoSwitchTo      = false 
    SWEP.AutoSwitchFrom  = true 
end 
  
if ( CLIENT ) then 
  
    SWEP.PrintName          = "Claws" 
    SWEP.DrawAmmo         = false 
    SWEP.DrawCrosshair    = false 
    SWEP.ViewModelFOV      = 70 
    SWEP.ViewModelFlip    = false 
    SWEP.CSMuzzleFlashes    = false 
end 
  
--------------------        General Swep Settings      ------------------------ 
SWEP.Author           = "Silver Knight" 
SWEP.HitForce            = 2 
SWEP.Spawnable              = false
SWEP.AdminSpawnable        = false 
SWEP.Slot               = 0
SWEP.SlotPos                = 1
SWEP.Purpose            = "S.T.A.L.K.E.R. Role Play" 
SWEP.Instructions         = "Left click to slash, right click for a stab." 
SWEP.ViewModel              = "" 
SWEP.WorldModel         = "" 
local KnifeRange          = 95 
  
  
--------------------        Primary Fire Attributes  ------------------------ 
SWEP.Primary.ClipSize      = -1 
SWEP.Primary.DefaultClip    = -1 
SWEP.Primary.Ammo           = "none" 
SWEP.Primary.Automatic      = true 
SWEP.Primary.Delay      = 0.5 
SWEP.Primary.Damage   = 25 
SWEP.Primary.SwingSound  = "npc/zombie/claw_miss1.wav" 
SWEP.Primary.EntitySound    = "npc/zombie/claw_strike1.wav" 
SWEP.Primary.WorldSound  = "hgn/stalker/player/attack_hit_3.mp3" 
  
  
--------------------    Secondary Fire Attributes      ------------------------ 
SWEP.Secondary.Delay        = 1.2 
SWEP.Secondary.Recoil      = 0 
SWEP.Secondary.Damage      = 40 
SWEP.Secondary.NumShots  = 1 
SWEP.Secondary.ClipSize  = -1 
SWEP.Secondary.DefaultClip  = -1 
SWEP.Secondary.Automatic    = false 
SWEP.Secondary.Ammo         = "none" 
  
util.PrecacheSound( "npc/zombie/claw_miss1.wav") 
util.PrecacheSound("npc/zombie/claw_strike1.wav") 
util.PrecacheSound("weapons/knife/knife_hitwall1.wav") 
util.PrecacheSound("hgn/stalker/player/attack_hit_3.mp3" ) 
  
util.PrecacheSound("player/footsteps/metalgrate1.wav") 
util.PrecacheSound("player/footsteps/metalgrate2.wav") 
util.PrecacheSound("player/footsteps/metalgrate3.wav") 
util.PrecacheSound("player/footsteps/metalgrate4.wav") 
  
function SWEP:PrimaryAttack() 
    local pos = self.Owner:GetShootPos() 
    local ang = self.Owner:GetAimVector() 
    
    local tracedata = {} 
        tracedata.start = pos 
        tracedata.endpos = pos + (ang * KnifeRange) 
        tracedata.filter = self.Owner 
    local trace = util.TraceLine(tracedata) 
	bullet = {} 
    bullet.Num    = 1 
    bullet.Src    = self.Owner:GetShootPos() 
    bullet.Dir    = self.Owner:GetAimVector() 
    bullet.Spread = Vector(0, 0, 0) 
    bullet.Tracer = 0 
    bullet.Force  = self.HitForce 
    bullet.Damage = self.Primary.Damage 
    
    if trace.HitNonWorld then 
        if (trace.Entity:IsPlayer()) then 
            self.Owner:FireBullets(bullet) 
            
            self.Weapon:EmitSound( self.Primary.EntitySound ) 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
  
            local Pos1 = trace.HitPos + trace.HitNormal 
            local Pos2 = trace.HitPos - trace.HitNormal 
            util.Decal("Blood", Pos1, Pos2 ) 
  
        elseif (trace.Entity:IsNPC()) then 
            self.Owner:FireBullets(bullet) 
            self.Weapon:EmitSound( self.Primary.EntitySound ) 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
            
        elseif (trace.Entity:GetClass() == "prop_ragdoll") then --If you hit a ragdoll, then paint some bloody decals on it >:) 
            self.Owner:FireBullets(bullet) 
            self.Weapon:EmitSound( self.Primary.EntitySound ) 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
            local Pos1 = trace.HitPos + trace.HitNormal 
            local Pos2 = trace.HitPos - trace.HitNormal 
            util.Decal("Blood", Pos1, Pos2 ) 
        else 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
            self.Weapon:EmitSound( self.Primary.WorldSound ) 
            
            local Pos1 = trace.HitPos + trace.HitNormal 
            local Pos2 = trace.HitPos - trace.HitNormal 
            util.Decal("ManhackCut", Pos1, Pos2 ) 
        end 
	end
    if trace.HitWorld then 
        self.Weapon:EmitSound( self.Primary.WorldSound ) 
        
        local Pos1 = trace.HitPos + trace.HitNormal 
        local Pos2 = trace.HitPos - trace.HitNormal 
        util.Decal("ManhackCut", Pos1, Pos2 ) 
        
        self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
    else    
        self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER ) 
    end 
	
    self.Weapon:EmitSound( self.Primary.SwingSound ) 
    self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
end 
  
function SWEP:SecondaryAttack() 
    local pos = self.Owner:GetShootPos() 
    local ang = self.Owner:GetAimVector() 
    
    local tracedata = {} 
        tracedata.start = pos 
        tracedata.endpos = pos + (ang * KnifeRange) 
        tracedata.filter = self.Owner 
    local trace = util.TraceLine(tracedata) 
	bullet = {} 
    bullet.Num    = 1 
    bullet.Src    = self.Owner:GetShootPos() 
    bullet.Dir    = self.Owner:GetAimVector() 
    bullet.Spread = Vector(0, 0, 0) 
    bullet.Tracer = 0 
    bullet.Force  = self.HitForce 
    bullet.Damage = self.Secondary.Damage 
    
    if trace.HitNonWorld then 
        if (trace.Entity:IsPlayer()) then 
            self.Owner:FireBullets(bullet) 
            
            self.Weapon:EmitSound( self.Primary.EntitySound ) 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
  
            local Pos1 = trace.HitPos + trace.HitNormal 
            local Pos2 = trace.HitPos - trace.HitNormal 
            util.Decal("Blood", Pos1, Pos2 ) 
  
        elseif (trace.Entity:IsNPC()) then 
            self.Owner:FireBullets(bullet) 
            self.Weapon:EmitSound( self.Primary.EntitySound ) 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
            
        elseif (trace.Entity:GetClass() == "prop_ragdoll") then --If you hit a ragdoll, then paint some bloody decals on it >:) 
            self.Owner:FireBullets(bullet) 
            self.Weapon:EmitSound( self.Primary.EntitySound ) 
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
            local Pos1 = trace.HitPos + trace.HitNormal 
            local Pos2 = trace.HitPos - trace.HitNormal 
            util.Decal("Blood", Pos1, Pos2 ) 
        else
            self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
            self.Weapon:EmitSound( self.Primary.WorldSound ) 
            
            local Pos1 = trace.HitPos + trace.HitNormal 
            local Pos2 = trace.HitPos - trace.HitNormal 
            util.Decal("ManhackCut", Pos1, Pos2 ) 
        end 
	end
    if trace.HitWorld then 
        self.Weapon:EmitSound( self.Primary.WorldSound ) 
        
        local Pos1 = trace.HitPos + trace.HitNormal 
        local Pos2 = trace.HitPos - trace.HitNormal 
        util.Decal("ManhackCut", Pos1, Pos2 ) 
        
        self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER ) 
    else    
        self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER ) 
    end 
    
    self.Weapon:EmitSound( self.Primary.SwingSound ) 
    self.Weapon:SetNextPrimaryFire( CurTime() + self.Secondary.Delay ) 
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
end 
  
function SWEP:Reload() 
    if self.Owner:KeyPressed(IN_RELOAD) then 
       self.Weapon:EmitSound( "hgn/stalker/background/sucker_growl_1.mp3" ) 
    end 
end 
  
function SWEP:Initialize() 
    if ( SERVER ) then 
        self:SetWeaponHoldType( "melee" ); 
    end 
end 
  
/*--------------------------------------------------------- 
    When the weapon is pulled out 
---------------------------------------------------------*/ 
function SWEP:Deploy() 
    self.Weapon:EmitSound( "hgn/stalker/background/sucker_growl_1.mp3" )
end
