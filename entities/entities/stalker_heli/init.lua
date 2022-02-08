AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

NEXTUSE = 0

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
		local SpawnPos = tr.HitPos+Vector(0,0,200)
		local ent = ents.Create( "stalker_heli" )
			ent:SetPos( SpawnPos )
			ent:Spawn()
			ent:Activate()
			ent.Owner=ply
	return ent
end

function ENT:Initialize()
	self.Entity:SetModel("models/combine_helicopter.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetColor(255,255,255,0)
	self.VEnt = ents.Create("prop_dynamic")
		self.VEnt:SetPos(self.Entity:GetPos())
		self.VEnt:SetAngles(self.Entity:GetAngles())
		self.VEnt:SetModel("models/combine_helicopter.mdl")
		self.VEnt:SetParent(self.Entity)
		self.VEnt:Spawn()
		self.VEnt:Activate()
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(20000)
	end	
	self.InUse = false
	self.User = nil
	self.Entity:SetUseType(SIMPLE_USE)
	self.Sound = CreateSound(self.Entity,"npc/attack_helicopter/aheli_rotor_loop1.wav")
	self.TimeX = 0
	self.TimeY = 0
	self.TimeZ = 0
	self.RTimeX = 0
	self.RTimeY = 0
	self.RTimeZ = 0
	self.Gunstate = CurTime()
	self.RoundsLeft = 20
	self.LastBomb = 0
	self.Healthz = 2000
	self.Sploding = false
	self.GunSound = CreateSound( self.Entity, "npc/attack_helicopter/aheli_weapon_fire_loop3.wav" )
	self.FireUp = CreateSound( self.Entity, "npc/attack_helicopter/aheli_charge_up.wav")
end

function ENT:Use(ply, cal)
	if !self.InUse && self.Healthz>0 && AngTest(self.Entity:GetAngles()) then
		self.InUse = true
		self.User = ply
		ply:DrawViewModel(false)
		ply:DrawWorldModel(false)
		ply:Spectate( OBS_MODE_CHASE )
		ply:SpectateEntity( self.Entity )
		self.VEnt:SetPlaybackRate(1.0)
		self.VEnt:SetSequence(0) 
		self.Entity:StartMotionController()
		self.Sound:PlayEx(1,100)
		ply:StripWeapons()
		self.Entity:GetPhysicsObject():Wake()
		ply:SetNetworkedBool("InChopper",true)
		self.User:SetNetworkedInt("HHealthz", self.Healthz)
		self.User:SetNetworkedInt("HBullets", self.RoundsLeft)
		self.User:SetNetworkedInt("HGunReloadTime", self.Gunstate)
		self.User:SetNetworkedInt("HLastBomb",self.LastBomb)
		self.Entity:SetNetworkedEntity("ENNT",self.VEnt)
		self.Entity:SetNetworkedBool("USE",true)
		self.TimeX = 0
		self.TimeY = 0
		self.TimeZ = 0
		self.RWash = ents.Create("env_rotorwash_emitter")
			self.RWash:SetPos(self.Entity:GetPos())
			self.RWash:SetParent(self.Entity)
			self.RWash:Activate()
	end
end

function ENT:PhysicsSimulate( phys, deltatime )
	phys:Wake()
	local poss = phys:GetPos()
	local angg = Angle(0,0,0)
	angg.y = self.User:EyeAngles().y
	local forw = angg:Forward():Normalize()*300
	local righ = angg:Right():Normalize()*300
	local uppp = angg:Up():Normalize()*200
	if self.User:KeyDown(8) then
		poss = poss + forw 
		angg.p = angg.p + 30
	end
	if self.User:KeyDown(16) then 
		poss = poss - forw
		angg.p = angg.p - 20
	end
	if self.User:KeyDown(1024) then 
		poss = poss + righ
		angg.r = angg.r + 25
		angg.y = angg.y - 25
	end
	if self.User:KeyDown(512) then 
		poss = poss - righ 
		angg.r = angg.r - 25
		angg.y = angg.y + 25
	end
	if self.User:KeyDown(2) then 
		poss = poss + uppp 
	end
	if self.User:KeyDown(4) then 
		poss = poss - uppp 
	end
	self.RTimeX = math.Rand(1,2.5)
	self.RTimeY = math.Rand(1,2.5)
	self.RTimeZ = math.Rand(1,2.5)
	self.TimeX = self.TimeX + (deltatime*self.RTimeX)
	self.TimeY = self.TimeY + (deltatime*self.RTimeY)
	self.TimeZ = self.TimeZ + (deltatime*self.RTimeZ)
	poss.x = poss.x + math.sin(self.TimeX)*50
	poss.y = poss.y + math.sin(self.TimeY)*50
	poss.z = poss.z + math.sin(self.TimeZ)*25
	self.ShadowParams={}
		self.ShadowParams.secondstoarrive = 1
		self.ShadowParams.pos = poss
		self.ShadowParams.angle = angg
		self.ShadowParams.maxangular = 500000000000
		self.ShadowParams.maxangulardamp = 10000
		self.ShadowParams.maxspeed = 1000000000000000
		self.ShadowParams.maxspeeddamp = 10000
		self.ShadowParams.dampfactor = 0.8
		self.ShadowParams.teleportdistance = 0
		self.ShadowParams.deltatime = deltatime
	phys:ComputeShadowControl(self.ShadowParams) 
end

function ENT:Think()
	self:NextThink(CurTime() + 0.1)
	if self.Healthz <= 0 then self:Splode() end
	if !self.InUse then return end
	self.User:SetPos(self.Entity:GetPos())
	self.Entity:SetNetworkedEntity("ENNT",self.VEnt)
	local phys = self.Entity:GetPhysicsObject()
	local a_velo = phys:GetAngleVelocity()
	local eyes = self.User:EyeAngles()
	local angs = self.Entity:GetAngles()
	local w_p = -eyes.p + angs.p
	w_p = math.Max(-90, w_p)
	w_p = math.Min(20, w_p)
	local w_y = eyes.y - angs.y
	if w_y>180 then w_y = w_y - 360 end
	if w_y<-180 then w_y = 360 + w_y end
	w_y = math.Max(-40, w_y)
	w_y = math.Min(40, w_y)
	local rud = a_velo.y * -0.5
	rud = math.Max(-45, rud)
	rud = math.Min(45, rud)
	self.Entity:SetPoseParameter("weapon_pitch",w_p)
	self.VEnt:SetPoseParameter("weapon_pitch",w_p)
	self.Entity:SetPoseParameter("weapon_yaw",w_y)
	self.VEnt:SetPoseParameter("weapon_yaw",w_y)
	self.Entity:SetPoseParameter("rudder",rud)
	self.VEnt:SetPoseParameter("rudder",rud)
	local ptab = self.User:GetTable()
	local cam = nil
	if ptab.UsingCamera then cam = ptab.UsingCamera end
	local okay = false
	if cam && cam:IsValid() then okay = true end
	self.User:SetNetworkedBool("UsingCam",okay)
	if self.User:KeyDown(2048) then self:DropBomb() end
	if self.RoundsLeft!=0 && self.User:KeyDown(1) then
		self:FireGun(Angle(self.Entity:GetAngles().p - w_p, self.Entity:GetAngles().y + w_y, 0)) 
	else 
		self.GunSound:Stop()
		self.RoundsLeft = 0
	end
	if (self.User:KeyDown(1)) then self:ChargeGun(true) else self:ChargeGun(false) end
	if (self.User:KeyDown(32) && (self.TimeX > 1)) || (self.Entity:WaterLevel()>(1)) || (!self.User:Alive())then
		self.VEnt:SetPlaybackRate(0)
		self.InUse = false
		self.User:UnSpectate()
		self.User:DrawViewModel(true)
		self.User:DrawWorldModel(true)
		self.User.HasChute = true
		self.User:SetNetworkedBool("InChopper",false)
		self.User:Spawn()
		self.User:SetColor(255,255,255,255)
		self.User:SetPos(self.Entity:GetPos() - 200*self.Entity:GetRight() - 50*self.Entity:GetUp())
		self.User = nil
		self.Entity:StopMotionController()
		self.Sound:Stop()
		self.RWash:Remove()
		self.Entity:SetNetworkedBool("USE",false)
	end
	return true
end

function ENT:OnRemove()
	if self.User then self.User:Spawn() end
	self.InUse = false
	if self.User then self.User:UnSpectate() end
	if self.User then self.User:DrawWorldModel(true) end
	if self.User then self.User:SetNetworkedBool("InChopper",false) end
	if self.User then self.User.HasChute = true end
	if self.User then self.User:SetPos(self.Entity:GetPos() - 30*self.Entity:GetRight()) end
	if self.User then self.User:SetColor(255,255,255,255) end
	self.User = nil
	self.Sound:Stop()
	self.Entity:StopMotionController()
	self.Entity:SetNetworkedBool("USE",false)
end

function ENT:FireGun(angs)
	if self.RoundsLeft != 0 then
		self.GunSound:PlayEx(1,100)
		local attach = self.Entity:LookupAttachment( "muzzle" )
		attach = self.Entity:GetAttachment(attach)
		local poss = attach.Pos
		local bullet = {}
			bullet.Num 			= 7
			bullet.Src 			= poss
			bullet.Dir 			= angs:Forward()
			bullet.Spread 		= Vector(0.165,0.165,0)
			bullet.Tracer		= 1
			bullet.TracerName 	= "HelicopterTracer"
			bullet.Force		= 5
			bullet.Damage		= 13
			bullet.Attacker 	= self.User		
		self.Entity:FireBullets( bullet )
		self.RoundsLeft = self.RoundsLeft -1
		self.User:SetNetworkedInt("HBullets", self.RoundsLeft)
	
		// Make a muzzle flash
		local effectdata = EffectData()
			effectdata:SetEntity(self.Entity)
			effectdata:SetScale( 0.5 )
		util.Effect( "StriderMuzzleFlash", effectdata )
		end
end

function ENT:ChargeGun(bool)
	if self.RoundsLeft == 0 then
		if !bool || (CurTime()> self.Gunstate +3) then
			self.Gunstate = CurTime()
			self.User:SetNetworkedInt("HGunReloadTime", self.Gunstate)
			self.FireUp:Stop()
			return
		end
		self.FireUp:PlayEx(1,100)
		if CurTime() > (self.Gunstate + 2) then
			self.RoundsLeft = 20
			self.User:SetNetworkedInt("HBullets", 20)
		end
	end
end

function ENT:DropBomb()
	if CurTime() < self.LastBomb +1.5 then return end
	self.LastBomb = CurTime()
	self.User:SetNetworkedInt("HLastBomb",self.LastBomb)
	self.Entity:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav",100,100)
	local da_bomb = ents.Create("grenade_helicopter")
	local attach = self.Entity:LookupAttachment("Bomb")
	attach = self.Entity:GetAttachment(attach)
	da_bomb:SetPos(attach.Pos - self.Entity:GetForward()*3 - self.Entity:GetUp()*3)
	da_bomb:SetAngles(Angle(math.random(-180,180),math.random(-180,180),math.random(-180,180)))
	da_bomb:Spawn()
	da_bomb:Activate()
	da_bomb:Fire("ExplodeIn",10,0)
	da_bomb:GetPhysicsObject():ApplyForceCenter( self.Entity:GetForward()*-0.4)
end

function ENT:OnTakeDamage(dmg)
	local multiplier = 1
	if dmg:IsBulletDamage( ) then multiplier = 0.5 end
	self.Healthz = self.Healthz - (dmg:GetDamage()*multiplier)
	self.Entity:EmitSound("npc/attack_helicopter/aheli_damaged_alarm1.wav")
	if self.User then self.User:SetNetworkedInt("HHealthz", self.Healthz) end
end

function ENT:Splode()
	if self.Sploding then return end
	self.Entity:SetColor(255,255,255,255)
	self.InUse = false
	if self.User then self.User:UnSpectate() end
	if self.User then self.User:DrawViewModel(true) end
	if self.User then self.User:DrawWorldModel(true) end
	if self.User then self.User:SetNetworkedBool("InChopper",false) end
	if self.User then self.User:Spawn() end
	if self.User then self.User:SetColor(255,255,255,255) end
	if self.User then self.User:SetPos(self.Entity:GetPos() - 200*self.Entity:GetRight() - 50*self.Entity:GetUp()) end
	self.User = nil
	self.Entity:StopMotionController()
	self.Sound:Stop()
	self.Entity:SetNetworkedBool("USE",false)
	local explod = ents.Create( "env_explosion" )
	explod:SetPos( self.Entity:GetPos() )
	explod:SetOwner( self.Owner )
	explod:Spawn()
	explod:SetKeyValue( "iMagnitude", "500" )
	explod:Fire( "Explode", 0, 0 )
	explod:EmitSound("ambient/explosions/explode_"..math.random(1,9)..".wav",256,100)
	self.Sploding = true
	timer.Simple( 1.5, function() self:TheEnd() end)	
	self.Entity:Ignite(10,100)
end

function ENT:TheEnd()
	local gib1 = ents.Create("prop_physics")
		local attach = self.Entity:LookupAttachment("Damage3")
		attach = self.Entity:GetAttachment(attach)
		gib1:SetPos(attach.Pos + Vector(0,0,25))
		gib1:SetAngles(self.Entity:GetAngles())
		gib1:SetModel("models/Gibs/helicopter_brokenpiece_04_cockpit.mdl")
		gib1:Spawn()
		gib1:Activate()
		gib1:Ignite(15,0)
		gib1:GetPhysicsObject():EnableDrag(false)
		gib1:GetPhysicsObject():SetVelocity(self.Entity:GetForward()*150 + self.Entity:GetUp()*250 + self.Entity:GetRight()*-150)
	local gib2 = ents.Create("prop_physics")
		attach = self.Entity:LookupAttachment("Damage1")
		attach = self.Entity:GetAttachment(attach)
		gib2:SetPos(attach.Pos + Vector(0,0,25))
		gib2:SetAngles(self.Entity:GetAngles())
		gib2:SetModel("models/Gibs/helicopter_brokenpiece_06_body.mdl")
		gib2:Spawn()
		gib2:Activate()
		gib2:Ignite(15,0)
		gib2:GetPhysicsObject():SetVelocity(self.Entity:GetRight()*250 + self.Entity:GetUp()*500)
	local gib3 = ents.Create("prop_physics")
		attach = self.Entity:LookupAttachment("Damage2")
		attach = self.Entity:GetAttachment(attach)
		gib3:SetPos(attach.Pos + Vector(0,0,25))
		gib3:SetAngles(self.Entity:GetAngles())
		gib3:SetModel("models/Gibs/helicopter_brokenpiece_05_tailfan.mdl")
		gib3:Spawn()
		gib3:Activate()
		gib3:Ignite(15,0)
		gib3:GetPhysicsObject():SetVelocity(self.Entity:GetForward()*-500 + self.Entity:GetUp()*250)
	local explod = ents.Create( "env_explosion" )
	explod:SetPos( self.Entity:GetPos() )
	explod:SetOwner( self.Owner )
	explod:Spawn()
	explod:SetKeyValue( "iMagnitude", "500" ) //the magnitude
	explod:Fire( "Explode", 0, 0 )
	explod:EmitSound("ambient/explosions/explode_"..math.random(1,9)..".wav",256,100)
	self:Remove()
end

function AngTest(ang)
	ang = ang + Angle(45,45,45)
	local b1, b2, ret = false, false, false
	if ang.p<90 && ang.p>=0 then b1 = true end
	if ang.r<90 && ang.r>=0 then b2 = true end
	if b1 && b2 then ret = true end
	return ret
end