
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )		

end

if ( CLIENT ) then

	SWEP.PrintName			= "Black Magic"			
	SWEP.Author				= "Sakarias"
	SWEP.DrawCrosshair 		= true
	SWEP.DrawAmmo			= false
	SWEP.Slot				= 1
	SWEP.SlotPos			= 0
	SWEP.ViewModelFOV		= 80

end

SWEP.WepUse   = 1

SWEP.Spazzer = SWEP.Spazzer or NULL
SWEP.PropType = 0
SWEP.EnableSpazz = 0
SWEP.EnableSpook = 0

SWEP.HPeffect   = 0
SWEP.SuckHealth = 0

SWEP.SpookForce = 2
SWEP.SpookTime = 2
SWEP.SpookMoveF = 0
SWEP.SpookMoveV = 0
SWEP.TelekineL = 150

SWEP.SpookDelay= CurTime()
SWEP.DelayTime = CurTime()
SWEP.DelayTimePrim = CurTime()
SWEP.DelayReload   = CurTime()

SWEP.NPCHateOrFear = NULL
SWEP.HateOrFear  = 0

SWEP.HeartBeatTime = CurTime()

SWEP.PossesAllie = 0

-----------------------Main functions----------------------------

--------------PRECACHEING ALL SOUNDS .... :-(
function SWEP:Precache()

util.PrecacheSound("ambient/atmosphere/cave_hit1.wav")
util.PrecacheSound("ambient/atmosphere/cave_hit2.wav")
util.PrecacheSound("ambient/atmosphere/cave_hit3.wav")
util.PrecacheSound("ambient/atmosphere/cave_hit4.wav")
util.PrecacheSound("ambient/atmosphere/cave_hit5.wav")
util.PrecacheSound("ambient/atmosphere/cave_hit6.wav")
util.PrecacheSound("music/stingers/HL1_stinger_song16.mp3")


util.PrecacheSound("npc/antlion_guard/angry1.wav") 
util.PrecacheSound("npc/antlion_guard/angry2.wav") 
util.PrecacheSound("npc/antlion_guard/angry3.wav") 

util.PrecacheSound("npc/antlion/attack_single1.wav") 
util.PrecacheSound("npc/antlion/attack_single2.wav") 
util.PrecacheSound("npc/antlion/attack_single3.wav")
util.PrecacheSound("npc/antlion/attack_double1.wav") 
util.PrecacheSound("npc/antlion/attack_double1.wav") 
util.PrecacheSound("npc/antlion/attack_double1.wav") 

util.PrecacheSound("npc/headcrab/alert1.wav") 
util.PrecacheSound("npc/headcrab/attack2.wav")
util.PrecacheSound("npc/headcrab/attack3.wav")
util.PrecacheSound("npc/headcrab/die1.wav") 
util.PrecacheSound("npc/headcrab/die2.wav")
util.PrecacheSound("npc/headcrab/pain1.wav") 
util.PrecacheSound("npc/headcrab/pain2.wav")
util.PrecacheSound("npc/headcrab/pain3.wav") 

util.PrecacheSound("npc/strider/creak1.wav")
util.PrecacheSound("npc/strider/creak2.wav")
util.PrecacheSound("npc/strider/creak3.wav")
util.PrecacheSound("npc/strider/creak4.wav")
util.PrecacheSound("npc/strider/striderx_pain2.wav")
util.PrecacheSound("npc/strider/striderx_pain5.wav")
util.PrecacheSound("npc/strider/striderx_pain7.wav")
util.PrecacheSound("npc/strider/striderx_pain8.wav")

util.PrecacheSound("npc/barnacle/neck_snap1.wav") 
util.PrecacheSound("npc/barnacle/neck_snap2.wav") 
util.PrecacheSound("npc/barnacle/barnacle_crunch2.wav") 
util.PrecacheSound("npc/barnacle/barnacle_crunch2.wav")		
util.PrecacheSound("npc/zombie/zombie_voice_idle1.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle2.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle3.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle4.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle5.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle6.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle7.wav") 
util.PrecacheSound("npc/zombie/zombie_voice_idle8.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle9.wav") 
util.PrecacheSound("npc/zombie/zombie_voice_idle10.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle11.wav")
util.PrecacheSound("npc/zombie/zombie_voice_idle12.wav")																								
util.PrecacheSound("npc/zombie/zombie_voice_idle13.wav")	
util.PrecacheSound("npc/zombie/zombie_voice_idle14.wav")

util.PrecacheSound("vehicles/v8/vehicle_impact_medium1.wav")	
util.PrecacheSound("vehicles/v8/vehicle_impact_medium2.wav")	
util.PrecacheSound("vehicles/v8/vehicle_impact_medium3.wav")		
util.PrecacheSound("vehicles/v8/vehicle_impact_medium4.wav")
util.PrecacheSound("vehicles/v8/v8_stop1.wav")
util.PrecacheSound("vehicles/Airboat/fan_motor_shut_off1.wav")

util.PrecacheSound("npc/fast_zombie/fz_frenzy1.wav")	
util.PrecacheSound("npc/zombie_poison/pz_warn1.wav")
util.PrecacheSound("npc/zombie_poison/pz_warn2.wav")
util.PrecacheSound("npc/zombie_poison/pz_alert1.wav")
util.PrecacheSound("npc/zombie_poison/pz_alert2.wav")
util.PrecacheSound("npc/zombie/zombie_pain1.wav")
util.PrecacheSound("npc/zombie/zombie_pain2.wav")
util.PrecacheSound("npc/zombie/zombie_pain3.wav")
util.PrecacheSound("npc/zombie/zombie_pain4.wav")
util.PrecacheSound("npc/zombie/zombie_pain5.wav")
util.PrecacheSound("npc/zombie/zombie_pain6.wav")

util.PrecacheSound("npc/ichthyosaur/attack_growl1.wav")
util.PrecacheSound("npc/ichthyosaur/attack_growl2.wav")
util.PrecacheSound("npc/ichthyosaur/attack_growl3.wav")



end
--------------PRECACHEING ALL SOUNDS END ... :-D

function SWEP:Initialize()
if SERVER then
	self:SetWeaponHoldType( "normal" )
end

end

----------------------------THINK
function SWEP:Think()


if self.WepUse == 1 then
 --This code is used when you start using the weapon or if you pick up the weapon
		self.WepUse = 20

	local RanStartSound =  math.random( 1, 6)
		
	if RanStartSound == 1 then self.Weapon:EmitSound("ambient/atmosphere/cave_hit1.wav") end
	if RanStartSound == 2 then self.Weapon:EmitSound("ambient/atmosphere/cave_hit2.wav") end
	if RanStartSound == 3 then self.Weapon:EmitSound("ambient/atmosphere/cave_hit3.wav") end
	if RanStartSound == 4 then self.Weapon:EmitSound("ambient/atmosphere/cave_hit4.wav") end
	if RanStartSound == 5 then self.Weapon:EmitSound("ambient/atmosphere/cave_hit5.wav") end
	if RanStartSound == 6 then self.Weapon:EmitSound("ambient/atmosphere/cave_hit6.wav") end

		local effectdata = EffectData()
		effectdata:SetOrigin( self.Owner:GetPos() ) 
		effectdata:SetAttachment( 1 )
		util.Effect( "magicspawn", effectdata )

end


if self.Spazzer == NULL then
self.EnableSpook = 0
end


if self.Spazzer:IsValid() then

if self.PropType == 4 and self.EnableSpook == 1 and self.HPeffect == 1 then 

		local effectdata = EffectData()
		effectdata:SetOrigin( self.Spazzer:GetPos() )
		util.Effect( "soulsHP", effectdata )
end

if self.PropType == 4 and self.EnableSpook == 1 and self.HPeffect == 2 then 

		local effectdata = EffectData()
		effectdata:SetOrigin( self.Spazzer:GetPos() )
		util.Effect( "soulsHPSec", effectdata )
end

if self.PropType == 4 and self.EnableSpook == 1 and self.HPeffect == 3 then 

		local effectdata = EffectData()
		effectdata:SetOrigin( self.Spazzer:GetPos() )
		util.Effect( "soulsHPThird", effectdata )
end

----------TELEKINESIS

if self.PropType == 1 or self.PropType == 2 or self.PropType == 3 then 

if( self.Owner:KeyDown(IN_USE) ) then

	
  if self.Owner:KeyDown(IN_ATTACK) then 	
	self.TelekineL = self.TelekineL + 1
  end
  
  if self.Owner:KeyDown(IN_ATTACK) then 	
	self.TelekineL = self.TelekineL + 2
  end
  
  if self.Owner:KeyDown(IN_ATTACK2) then 	
	self.TelekineL = self.TelekineL - 2
  end


	if self.TelekineL <50 then self.TelekineL = 50 end

	if self.TelekineL >400 then self.TelekineL = 400 end
	
local trace = {}
trace.start = self.Owner:GetShootPos()
trace.endpos = trace.start + (self.Owner:GetAimVector() * self.TelekineL)
trace.filter = { self.Owner, self.Weapon }
local tr = util.TraceLine( trace )

local ent = self.Spazzer	

			local vec = trace.endpos - ent:GetPos()
			vec:Normalize()

		local speed = self.Spazzer:GetPhysicsObject():GetVelocity()

			self.Spazzer:GetPhysicsObject():SetVelocity( (vec * (self.SpookMoveV/2)) + speed )


		local effectdata = EffectData()
		effectdata:SetOrigin( self.Spazzer:GetPos() ) 
		util.Effect( "blackmagic", effectdata )
	end

end

----------TELEKINESIS END

----------POSSESSED SOUNDS D-:

--Props, ragdolls will make different sounds.
--It would be very odd if a vehicle made human noises :-P

if self.EnableSpook == 1 then


	if self.SpookDelay < CurTime() then


local RanSound = math.random( 1, 20)

	if RanSound == 1 then 
---------------
		if self.PropType == 3 then	

			if (not string.find(self.Spazzer:GetModel(), "Fast_Zombie_Legs*")) and (not string.find(self.Spazzer:GetModel(), "zombie_soldier_legs*")) and (not string.find(self.Spazzer:GetModel(), "Classic_legs*")) and (not string.find(self.Spazzer:GetModel(), "AntLion*")) and (not string.find(self.Spazzer:GetModel(), "antlion*")) and(not string.find(self.Spazzer:GetModel(), "Antlion*")) and (not string.find(self.Spazzer:GetModel(), "antlion_guard*")) and (not string.find(self.Spazzer:GetModel(), "hunter*")) and (not string.find(self.Spazzer:GetModel(), "headcrab*")) and (not string.find(self.Spazzer:GetModel(), "headcrabblack*")) and (not string.find(self.Spazzer:GetModel(), "headcrabclassic*")) and (not string.find(self.Spazzer:GetModel(), "Lamarr*"))then

		 RanSound = math.random( 1, 18)
			
			if RanSound == 1 then self.Spazzer:EmitSound("npc/barnacle/neck_snap1.wav") end
			if RanSound == 2 then self.Spazzer:EmitSound("npc/barnacle/neck_snap2.wav") end	
			if RanSound == 3 then self.Spazzer:EmitSound("npc/barnacle/barnacle_crunch2.wav") end	
			if RanSound == 4 then self.Spazzer:EmitSound("npc/barnacle/barnacle_crunch2.wav") end		
			if RanSound == 5 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle1.wav") end
			if RanSound == 6 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle2.wav") end
			if RanSound == 7 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle3.wav") end
			if RanSound == 8 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle4.wav") end
			if RanSound == 9 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle5.wav") end
			if RanSound == 10 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle6.wav") end
			if RanSound == 11 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle7.wav") end
			if RanSound == 12 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle8.wav") end
			if RanSound == 13 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle9.wav") end
			if RanSound == 14 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle10.wav") end
			if RanSound == 15 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle11.wav") end
			if RanSound == 16 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle12.wav") end																								
			if RanSound == 17 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle13.wav") end	
			if RanSound == 18 then self.Spazzer:EmitSound("npc/zombie/zombie_voice_idle14.wav") end				
		end

		if string.find(self.Spazzer:GetModel(), "antlion_guard*") then
		
		 RanSound = math.random( 1, 3)
			if RanSound == 1 then self.Spazzer:EmitSound("npc/antlion_guard/angry1.wav") end
			if RanSound == 2 then self.Spazzer:EmitSound("npc/antlion_guard/angry2.wav") end
			if RanSound == 3 then self.Spazzer:EmitSound("npc/antlion_guard/angry2.wav") end
		end

		if string.find(self.Spazzer:GetModel(), "AntLion*") or string.find(self.Spazzer:GetModel(), "antlion*") or string.find(self.Spazzer:GetModel(), "Antlion*") then
		if (not string.find(self.Spazzer:GetModel(), "antlion_guard*")) then

		 RanSound = math.random( 1, 6)
			if RanSound == 1 then self.Spazzer:EmitSound("npc/antlion/attack_single1.wav") end
			if RanSound == 2 then self.Spazzer:EmitSound("npc/antlion/attack_single2.wav") end
			if RanSound == 3 then self.Spazzer:EmitSound("npc/antlion/attack_single3.wav") end
			if RanSound == 4 then self.Spazzer:EmitSound("npc/antlion/attack_double1.wav") end
			if RanSound == 5 then self.Spazzer:EmitSound("npc/antlion/attack_double1.wav") end
			if RanSound == 6 then self.Spazzer:EmitSound("npc/antlion/attack_double1.wav") end
		end
		end

		if string.find(self.Spazzer:GetModel(), "headcrab*") or string.find(self.Spazzer:GetModel(), "headcrabblack*") or string.find(self.Spazzer:GetModel(), "headcrabclassic*") or string.find(self.Spazzer:GetModel(), "Lamarr*") then
		 RanSound = math.random( 1, 8)
			if RanSound == 1 then self.Spazzer:EmitSound("npc/headcrab/alert1.wav") end
			if RanSound == 2 then self.Spazzer:EmitSound("npc/headcrab/attack2.wav") end
			if RanSound == 3 then self.Spazzer:EmitSound("npc/headcrab/attack3.wav") end
			if RanSound == 4 then self.Spazzer:EmitSound("npc/headcrab/die1.wav") end
			if RanSound == 5 then self.Spazzer:EmitSound("npc/headcrab/die2.wav") end
			if RanSound == 6 then self.Spazzer:EmitSound("npc/headcrab/pain1.wav") end
			if RanSound == 7 then self.Spazzer:EmitSound("npc/headcrab/pain2.wav") end
			if RanSound == 8 then self.Spazzer:EmitSound("npc/headcrab/pain3.wav") end
		end

		if string.find(self.Spazzer:GetModel(), "hunter*") then
		 RanSound = math.random( 1, 8)
			if RanSound == 1 then self.Spazzer:EmitSound("npc/strider/creak1.wav") end
			if RanSound == 2 then self.Spazzer:EmitSound("npc/strider/creak2.wav") end
			if RanSound == 3 then self.Spazzer:EmitSound("npc/strider/creak3.wav") end
			if RanSound == 4 then self.Spazzer:EmitSound("npc/strider/creak4.wav") end
			if RanSound == 5 then self.Spazzer:EmitSound("npc/strider/striderx_pain2.wav") end
			if RanSound == 6 then self.Spazzer:EmitSound("npc/strider/striderx_pain5.wav") end
			if RanSound == 7 then self.Spazzer:EmitSound("npc/strider/striderx_pain7.wav") end
			if RanSound == 8 then self.Spazzer:EmitSound("npc/strider/striderx_pain8.wav") end

			end

end
----------------------

		if self.PropType == 2 then	
		 RanSound = math.random( 1, 6)
			
			if RanSound == 1 then self.Spazzer:EmitSound("vehicles/v8/vehicle_impact_medium1.wav") end	
			if RanSound == 2 then self.Spazzer:EmitSound("vehicles/v8/vehicle_impact_medium2.wav") end	
			if RanSound == 3 then self.Spazzer:EmitSound("vehicles/v8/vehicle_impact_medium3.wav") end		
			if RanSound == 4 then self.Spazzer:EmitSound("vehicles/v8/vehicle_impact_medium4.wav") end
			if RanSound == 5 then self.Spazzer:EmitSound("vehicles/v8/v8_stop1.wav") end
			if RanSound == 6 then self.Spazzer:EmitSound("vehicles/Airboat/fan_motor_shut_off1.wav") end
		end

		if self.PropType == 1 then	
		 RanSound = math.random( 1, 11)
			
			if RanSound == 1 then self.Spazzer:EmitSound("npc/fast_zombie/fz_frenzy1.wav") end		
			if RanSound == 2 then self.Spazzer:EmitSound("npc/zombie_poison/pz_warn1.wav") end
			if RanSound == 3 then self.Spazzer:EmitSound("npc/zombie_poison/pz_warn2.wav") end
			if RanSound == 4 then self.Spazzer:EmitSound("npc/zombie_poison/pz_alert1.wav") end
			if RanSound == 5 then self.Spazzer:EmitSound("npc/zombie_poison/pz_alert2.wav") end
			if RanSound == 6 then self.Spazzer:EmitSound("npc/zombie/zombie_pain1.wav") end
			if RanSound == 7 then self.Spazzer:EmitSound("npc/zombie/zombie_pain2.wav") end
			if RanSound == 8 then self.Spazzer:EmitSound("npc/zombie/zombie_pain3.wav") end
			if RanSound == 9 then self.Spazzer:EmitSound("npc/zombie/zombie_pain4.wav") end
			if RanSound == 10 then self.Spazzer:EmitSound("npc/zombie/zombie_pain5.wav") end
			if RanSound == 11 then self.Spazzer:EmitSound("npc/zombie/zombie_pain6.wav") end
		end

	end
-----POSSESSED SOUNDS END

		self.SpookDelay = CurTime() +  self.SpookTime
			
		self.SpookTime = self.SpookTime - 0.2
		self.SpookMoveV = self.SpookMoveV + self.SpookMoveF 

		if self.PropType == 4 and self.Spazzer:IsValid() and self.HPeffect>=1 then 
			local Korv = self.Spazzer:Health() - 5
				self.Spazzer:Fire("sethealth", ""..Korv.."", 0)
					
		
		if self.Owner:Health() < 200 then 	
		self.Owner:SetHealth(self.Owner:Health() + 1)	
		end
		
		end

		if self.SpookTime < 0.2 then 
		self.SpookTime = 0.2 
		self.SpookMoveV = self.SpookMoveV - self.SpookMoveF
		end 
		
if self.PropType == 1 or self.PropType == 2 or self.PropType == 3 then 
		local phys2 = self.Spazzer:GetPhysicsObject()	  
			  phys2:AddAngleVelocity(Vector((math.random(-10 , 10)), (math.random(-10 , 10)), (math.random(-10 , 10)))*(10*self.SpookForce))  	
end
end
end
end

if self.Spazzer:IsValid() and self.PropType == 4 and self.Spazzer ~= nil and self.Spazzer ~= NULL then
	if (self.Spazzer:Health() < 20) then

	local StupidValue = 2
	
	self.Spazzer:AddEntityRelationship( self.Owner, StupidValue, 99)
--	self.Spazzer:Fire("setrelationship","player, D_FR 99",0) --Workaround
	
	end
end

end
----------------------------PRIMARY ATTACK
function SWEP:PrimaryAttack()

 if self.Owner:KeyDown(IN_USE) == false then

if self.DelayTimePrim < CurTime() then
	self.DelayTimePrim = CurTime()+2

	
local trace = {}
trace.start = self.Owner:GetShootPos()
trace.endpos = trace.start + (self.Owner:GetAimVector() * 500)
trace.filter = { self.Owner, self.Weapon }
local tr = util.TraceLine( trace )

	if tr.HitWorld or (tr.Hit == false) then
		return
		else

--- Spazzer is the entity!
		self.Spazzer = tr.Entity
---Resetting some values here
		self.SpookTime = 2
		self.SpookMoveF = 0
		self.SpookMoveV = 0
		self.EnableSpook = 0
		self.TelekineL = 150
     	self.PossesAllie = 0
		
			if string.find(self.Spazzer:GetClass(), "prop_physics") or string.find(self.Spazzer:GetClass(), "prop_vehicle_*") or string.find(self.Spazzer:GetClass(), "prop_ragdoll") or string.find(self.Spazzer:GetClass(), "npc_*")then
			self.SpookTime = 2				
			self.Spazzer:SetKeyValue("targetname", "Spazzer")
			
			
			if string.find(self.Spazzer:GetClass(), "prop_physics") then
			self.Owner:TakeDamage(5)
			self.SpookForce=5			
			self.PropType = 1
			self.SpookMoveF = 8

			end

			if string.find(self.Spazzer:GetClass(), "prop_vehicle_*") then		
			self.Owner:TakeDamage(10)
			self.SpookForce=3
			self.PropType = 2
			self.SpookMoveF = 4
			end

			if string.find(self.Spazzer:GetClass(), "prop_ragdoll") and (not string.find(self.Spazzer:GetModel(), "dog*")) and (not string.find(self.Spazzer:GetModel(), "Combine_Strider*")) then		
			self.SpookForce=100
			self.PropType = 3		
			self.SpookMoveF = 30
	
			if string.find(self.Spazzer:GetModel(), "alyx*") or string.find(self.Spazzer:GetModel(), "Barney*") or string.find(self.Spazzer:GetModel(), "breen*") or string.find(self.Spazzer:GetModel(), "Eli*") or string.find(self.Spazzer:GetModel(), "gman*") or string.find(self.Spazzer:GetModel(), "Kleiner*") or string.find(self.Spazzer:GetModel(), "monk*") or string.find(self.Spazzer:GetModel(), "mossman*") or string.find(self.Spazzer:GetModel(), "odessa*") or string.find(self.Spazzer:GetModel(), "antlion_guard*") or string.find(self.Spazzer:GetModel(), "headcrab*") or string.find(self.Spazzer:GetModel(), "headcrabblack*") or string.find(self.Spazzer:GetModel(), "headcrabclassic*") or string.find(self.Spazzer:GetModel(), "Lamarr*") or string.find(self.Spazzer:GetModel(), "vortigaunt*") or string.find(self.Spazzer:GetModel(), "Classic*") or string.find(self.Spazzer:GetModel(), "Classic_legs*") or string.find(self.Spazzer:GetModel(), "Classic_torso*") or string.find(self.Spazzer:GetModel(), "Charple*") or string.find(self.Spazzer:GetModel(), "corpse1*") or string.find(self.Spazzer:GetModel(), "male*") or string.find(self.Spazzer:GetModel(), "female*") or string.find(self.Spazzer:GetModel(), "Female*") or string.find(self.Spazzer:GetModel(), "Male*") or string.find(self.Spazzer:GetModel(), "magnusson*") or string.find(self.Spazzer:GetModel(), "hunter*") or string.find(self.Spazzer:GetModel(), "Fast_Zombie_Torso*")  or string.find(self.Spazzer:GetModel(), "Zombie_Soldier*")  or string.find(self.Spazzer:GetModel(), "zombie_soldier_legs*") or string.find(self.Spazzer:GetModel(), "zombie_soldier_torso*") or string.find(self.Spazzer:GetModel(), "zombie*")then 		
			self.SpookForce=30					
			end
			end


--here i determine what effect i should use for the traced NPC
--On Human NPC's the position of the emitter will be set in the body (HP effect 1)
--On smaller unhuman NPC's such as headcrabs the emitters position will be closer to the NPC's main position (HPeffect 2).
--I i had used HPeffect 1 om headcrabs the emitter would start above the headcrab in the air.

			if string.find(self.Spazzer:GetClass(), "npc_*")then		
			self.PropType = 4		
			self.HPeffect = 1				
			if string.find(self.Spazzer:GetClass(), "npc_antlion") or string.find(self.Spazzer:GetClass(), "npc_crow")	 or string.find(self.Spazzer:GetClass(), "npc_headcrab")	or string.find(self.Spazzer:GetClass(), "npc_headcrab_black") or string.find(self.Spazzer:GetClass(), "npc_headcrab_fast") or string.find(self.Spazzer:GetClass(), "npc_pigeon") or string.find(self.Spazzer:GetClass(), "npc_seagull") or string.find(self.Spazzer:GetClass(), "npc_zombie_torso") or string.find(self.Spazzer:GetClass(), "npc_fastzombie_torso")  then	
			self.HPeffect = 2
			end
			end

			if string.find(self.Spazzer:GetClass(), "npc_antlionguard") then
			self.HPeffect = 1	
			end

			if string.find(self.Spazzer:GetClass(), "npc_hunter") then
			self.HPeffect = 3
			end
--Disabeling drain life so you can't drain life energy from rollermines etc. (have infinite health) instead i use them as props.
			if string.find(self.Spazzer:GetClass(), "npc_cscanner") or string.find(self.Spazzer:GetClass(), "npc_manhack") or string.find(self.Spazzer:GetClass(), "npc_rollermine") or string.find(self.Spazzer:GetClass(), "npc_turret_floor") or string.find(self.Spazzer:GetClass(), "npc_turret_ground")  or string.find(self.Spazzer:GetClass(), "npc_clawscanner") then
			self.SpookForce=3
			self.PropType = 1
			self.SpookMoveF = 7
			end

--Disabeling drain life so you can't drain life energy from big NPC's with much health or infinite health
			if string.find(self.Spazzer:GetClass(), "npc_strider") or string.find(self.Spazzer:GetClass(), "npc_helicopter") or string.find(self.Spazzer:GetClass(), "npc_combine_camera") or string.find(self.Spazzer:GetClass(), "npc_combinedropship") or string.find(self.Spazzer:GetClass(), "npc_combinegunship") or string.find(self.Spazzer:GetClass(), "npc_dog") or string.find(self.Spazzer:GetClass(), "npc_barnacle") or string.find(self.Spazzer:GetClass(), "*antliongrub") then
			self.PropType = 0
			end

		local PossesSound = math.random( 1, 3)
			
			if PossesSound == 1 then self.Owner:EmitSound("npc/ichthyosaur/attack_growl1.wav") end
			if PossesSound == 2 then self.Owner:EmitSound("npc/ichthyosaur/attack_growl2.wav") end
			if PossesSound == 3 then self.Owner:EmitSound("npc/ichthyosaur/attack_growl3.wav") end

 if self.PropType == 1 or self.PropType == 2 or self.PropType == 3 then

		local effectdata = EffectData()
		effectdata:SetOrigin( self.Spazzer:GetPos() ) 
		effectdata:SetAttachment( 0 )
		util.Effect( "souls", effectdata )
 end
------------------	
	if self.PropType == 4 then
	
	if self.Spazzer:GetClass()=="npc_citizen" or self.Spazzer:GetClass()=="npc_alyx" or self.Spazzer:GetClass()=="npc_barney" or self.Spazzer:GetClass()=="npc_eli" or self.Spazzer:GetClass()=="npc_gman" or self.Spazzer:GetClass()=="npc_kleiner" or self.Spazzer:GetClass()=="npc_mossman" or self.Spazzer:GetClass()=="npc_vortigaunt" then
	self.PossesAllie = 1
	end
	
		for k, v in pairs( ents.FindInSphere( self.Spazzer:GetPos(), 256 ) ) do

			if string.find(v:GetClass(), "npc_*")then		

			if 	self.PossesAllie == 0 then
		 	if v:GetClass()=="npc_breen" or v:GetClass()=="npc_metropolice" or v:GetClass()=="npc_zombie" or v:GetClass()=="npc_zombie_torso" or v:GetClass()=="npc_poisonzombie" or v:GetClass()=="npc_antlion" or v:GetClass()=="npc_antlionguard" or v:GetClass()=="npc_barnacle" or v:GetClass()=="npc_fastzombie" or v:GetClass()=="npc_fastzombie_torso" or v:GetClass()=="npc_headcrab" or v:GetClass()=="npc_headcrab_black" or v:GetClass()=="npc_headcrab_fast" or v:GetClass()=="npc_crow" or v:GetClass()=="npc_pigeon" or v:GetClass()=="npc_seagull" or v:GetClass()=="npc_combine_s" then

			self.HateOrFear = math.random( 1, 2)
			v:AddEntityRelationship( self.Owner, self.HateOrFear, 10)
		
			end
			end

			if self.PossesAllie == 1 then
				self.HateOrFear = math.random( 1, 2)

			v:AddEntityRelationship( self.Owner, self.HateOrFear, 10)	
			end
		end
end
end
---------

end
end
end
end
end
----------------------------SECONDARY ATTACK
function SWEP:SecondaryAttack()

--The prop will moce towards the point you look at.
--I have also fixed so if the traceline hits self.spazzer then the telekinesis will be disabled.
--In that way the prop won't attack you if you point at it and use telekinesis.

if self.Owner:KeyDown(IN_USE) == false then

if self.Spazzer:IsValid() then

	if self.PropType == 1 or self.PropType == 2 or self.PropType == 3 then	
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Spazzer:GetPos() ) 	
		util.Effect( "blackmagic", effectdata )
	end


if (SERVER) then

local trace = {}
trace.start = self.Owner:GetShootPos()
trace.endpos = trace.start + (self.Owner:GetAimVector() * 99999)
trace.filter = { self.Owner, self.Weaponm,}
local tr = util.TraceLine( trace )
local NotSpazzer = tr.Entity

if self.Spazzer == NotSpazzer then return end

	
	local tr = util.GetPlayerTrace( self.Owner )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end


	local ent = self.Spazzer	

			local v = trace.HitPos - ent:GetPos()
			v:Normalize()

if self.PropType == 1 or self.PropType == 2 or self.PropType == 3 then 

		local speed = self.Spazzer:GetPhysicsObject():GetVelocity()

			self.Spazzer:GetPhysicsObject():SetVelocity( (v * self.SpookMoveV) + speed )
end

end	
end
end
end
----------------------------RELOAD
function SWEP:Reload()

--Reload will toggle the possession on or off	
	
	if self.DelayReload < CurTime() then	
		self.DelayReload = CurTime()+0.5 


			self.EnableSpook = self.EnableSpook+1

			
			if self.EnableSpook >= 2 then
				self.EnableSpook = 0
			end

		end 
---------------------		
end
----------------------------HOLSTER
function SWEP:Holster()

--Holstering the weapon will reset the start effects 

	self.WepStartEffect = CurTime()+2
	self.WepUse = 1

	return true
end
------------General Swep Info---------------
SWEP.Author   			= "Sakarias"
SWEP.Contact        	= "sakariasjohansson@hotmail.com"
SWEP.Purpose        	= ""
SWEP.Instructions   	= "Let the darkness guide you"
SWEP.Spawnable      	= true
SWEP.AdminSpawnable 	= true
--------------------------------------------

------------Models---------------------------
SWEP.ViewModel = Model( "" );
SWEP.WorldModel = Model( "" );
---------------------------------------------
 
-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay				= 0.8
SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0	
SWEP.Primary.ClipSize			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic   		= true
SWEP.Primary.Ammo         		= "none"
-------------------------------------------------------------------------------------

-------------Secondary Fire Attributes---------------------------------------

SWEP.Secondary.Delay			= 0.8
SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= true
SWEP.Secondary.Ammo         	= "none"
-------------------------------------------------------------------------------------
