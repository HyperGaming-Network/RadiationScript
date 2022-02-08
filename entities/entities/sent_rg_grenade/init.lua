-- Super-Duper Grenade
-- SENT by Teta_Bonita

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


local GrenadeModel = "models/items/AR2_Grenade.mdl"
util.PrecacheModel(GrenadeModel)

function ENT:Initialize()

	self.Entity:SetModel(GrenadeModel)

	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

	self.PhysObj = self.Entity:GetPhysicsObject()
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
	end
	
	self.Damage = self.Entity:GetVar("Damage",100)
	self.Owner = self.Entity:GetOwner()
	self.Armed = false
	
end

function ENT:Explode(normal)

	local Position = self.Entity:GetPos()
	
	local WeaponEnt = self.Entity
	local Owner = self.Entity
	if self.Owner and self.Owner:Alive() then 
		WeaponEnt = self.Owner:GetActiveWeapon()
		Owner = NULL
	end

	util.BlastDamage(WeaponEnt, self.Owner, Position, 2.5*self.Damage, self.Damage)
	
	-- Shrapnel
	for i=1,math.random(7,9) do
		local ShrapnelDamage = self.Damage*math.Rand(0.2,0.3)
		local eBullet = ents.Create("sent_rg_bullet") -- Quasi-physically simulated bullet

		local Velocity = 600*ShrapnelDamage*(VectorRand() - 0.7*normal):GetNormalized()
		local Acceleration = Vector(0,0,-600)
		
		eBullet:SetPos(Position)
		eBullet:SetVar("Velocity",Velocity)
		eBullet:SetVar("Acceleration",Acceleration)
		
		local tBullet = {} -- This is the bullet our bullet SENT will be firing when it hits something.  Everything except force and damage is determined by the bullet SENT
		tBullet.Force	= 0.5*ShrapnelDamage
		tBullet.Damage	= ShrapnelDamage
		
		local tTrace = {} --This is the trace the bullet SENT uses to see if it has hit something
		tTrace.filter = {eBullet}
		tTrace.mask = MASK_SHOT
		
		eBullet:SetVar("Bullet",tBullet)
		eBullet:SetVar("Trace",tTrace)
		eBullet:SetOwner(Owner)
		eBullet:Spawn()
	end
	
	-- Effect
	local fx = EffectData()
	fx:SetOrigin(Position)
	util.Effect("Explosion",fx)

	self.Entity:Remove()
	
	
end


function ENT:PhysicsCollide(data, physobj)

	if data.Speed > 50 and data.DeltaTime > 0.3 then
	
		if not self.Armed then
		
			--Bounce like a crazy bitch
			local LastSpeed = data.OurOldVelocity:Length()
			local NewVelocity = physobj:GetVelocity()
			
			local TargetVelocity = NewVelocity + (LastSpeed*0.2)*NewVelocity:GetNormalized()
			physobj:SetVelocity(TargetVelocity)
		
			timer.Simple(0.1, self.Explode, self, data.HitNormal)
			self.Armed = true
			
		end

	end

end


function ENT:OnTakeDamage(dmginfo)

	self.Entity:TakePhysicsDamage(dmginfo)
	
end


function ENT:Think()


end

