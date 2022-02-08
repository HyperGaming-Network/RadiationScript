PLUGIN.Name = "Pills"; -- What is the plugin name
PLUGIN.Author = "LastExile"; -- Author of the plugin
PLUGIN.Description = "Pills"; -- The description or purpose of the plugin

PillClass = {}
PillClass.__index = PillClass

PillClass.base = nil
PillClass.camera = {
	x = nil, y = nil, z = nil,
	back = nil,
	right = nil,
	up = nil
	}
PillClass.ghost = nil
PillClass.model = nil
PillClass.speeds = {walking = nil, running = nil} 
PillClass.sounds = {
	effect = Sound("Weapon_Bugbait.Splat"),
	pain = nil
	}
PillClass.player = nil
PillClass.type = nil
PillClass.waterlevel = 3

function PillClass:CalcView(pos, ang, fov)
	if GetViewEntity() == self.player and self.player:Health() > 0 then
		if self.ghost and self.ghost:IsValid() then
			self.ghost:SetColor(255, 255, 255, 255)
		end
		if self.camera then
			ang = self.player:GetAimVector():Angle()
			pos = self.player:GetPos() + Vector(self.camera.x or 0, self.camera.y or 0, self.camera.z or 0)
			if self.camera.back or self.camera.right or self.camera.up then
				local t = {}
				t.start = pos 
				t.endpos = pos
				if self.camera.back then t.endpos = t.endpos + ang:Forward() * -self.camera.back end
				if self.camera.right then t.endpos = t.endpos + ang:Right() * self.camera.right end
				if self.camera.up then t.endpos = t.endpos + ang:Up() * self.camera.up end
				t.filter = self.player
				local tr = util.TraceLine(t)
				pos = tr.HitPos
				if tr.Fraction < 1 then
					pos = pos + tr.HitNormal * 2
				end
			end
			return GAMEMODE:CalcView(self.player, pos, ang, fov)
		end
	else
		if self.ghost and self.ghost:IsValid() then
			self.ghost:SetColor(255, 255, 255, 0)
		end
	end
end

function PillClass:Disabled()
	if SERVER and self.ghost then self.ghost:Remove() end
	self.ghost = nil
	GAMEMODE:SetPlayerSpeed(self.player, pills.speeds.walking or pills.speeds.running, pills.speeds.running or pills.speeds.walking)
end

function PillClass:Effect()
	local ed = EffectData()
	ed:SetOrigin(self.player:GetPos())
	ed:SetStart(self.player:GetPos())
	ed:SetScale(1000)
	util.Effect("cball_explode", ed)
	if self.sounds.transform then
		self.player:EmitSound(self.sounds.effect)
	end
end

function PillClass:Enabled()
	self:Spawned()
	if SERVER then
		local ghost = ents.Create("prop_dynamic")
		ghost:SetAngles(self.player:GetAngles())
		ghost:SetCollisionGroup(COLLISION_GROUP_NONE)
		ghost:SetColor(255, 255, 255, 0)
		ghost:SetMoveType(MOVETYPE_NONE)
		ghost:SetModel(self.player:GetModel())
		ghost:SetParent(self.player)
		ghost:SetPos(self.player:GetPos())
		ghost:SetRenderMode(RENDERMODE_TRANSALPHA)
		ghost:SetSolid(SOLID_NONE)
		ghost:Spawn()
		self.ghost = ghost
		umsg.Start("pills.ghost", self.player)
		umsg.Entity(self.ghost)
		umsg.End()
	end
end

function PillClass:Hurt(attacker)
	if self.sounds.pain then
		self.player:EmitSound(self.sounds.pain)
	end
end

function PillClass:Initialize()
end

function PillClass:KeyPress(key)
end

function PillClass:KeyRelease(key)
end

function PillClass:Killed(attacker, weapon)
end

function PillClass:Melee(start, dir, length, mins, maxs, damage, effect)
	// create the hull
	if not pills.hull then
		pills.hull = ents.Create("base_entity")
		pills.hull:SetCollisionGroup(COLLISION_GROUP_NONE)
		pills.hull:SetMoveType(MOVETYPE_NONE)
		pills.hull:SetSolid(SOLID_NONE)
		pills.hull:Spawn()
	end
	pills.hull:SetAngles(self.player:GetAngles())
	pills.hull:SetCollisionBounds(mins, maxs)

	// trace the hull
	local t = {}
	t.start = start
	t.endpos = start + dir * length 
	t.filter = self.player
	self.player:LagCompensation(true)
	local tr = util.TraceEntity(t, pills.hull)
	self.player:LagCompensation(false)

	// did it hit anything?
	if tr.Hit then
		if tr.Entity and tr.Entity:IsValid() then
			self:MeleeDamage(tr, damage, effect)
		end
		return tr
	else
		return nil
	end
end

function PillClass:MeleeDamage(tr, damage, effect)
	if tr.Entity.TakeDamage then
		tr.Entity:TakeDamage(damage, self.player)
   	else
   		// thanks jetboom
   		util.BlastDamage(self.player, self.player, tr.Entity:GetPos(), 4, damage)
   		if tr.Entity:IsValid() then
		   tr.Entity:Extinguish()
		end
   	end
   	if effect then
		local ed = EffectData()
		ed:SetEntity(tr.Entity)
		ed:SetNormal(tr.HitNormal)
		ed:SetOrigin(tr.HitPos)
		ed:SetStart(tr.HitPos)
		util.Effect(effect, ed)
	end
end

function PillClass:SetAnimation(animation)
	if self.model then
		return false
	end
end
function PillClass:Spawned()
	if self.model then
		self.player:SetModel(self.model)
		if self.ghost then
			self.ghost:SetModel(self.model)
		end
	end
	if self.speeds.walking or self.speeds.running then
		GAMEMODE:SetPlayerSpeed(self.player, self.speeds.walking or self.speeds.running, self.speeds.running or self.speeds.walking)
	end
end

function PillClass:ShouldTakeDamage(attacker)
end

function PillClass:TakeDamage(inflictor, attacker, amount)
end

function PillClass:Think()
	self:Animate()
end

// -----------------------------------------------------------------------------
// load the pills

pills = {}
pills.classes = {}
pills.speeds = {walking = 250, running = 500}

function pills.Enable(player, type)
	if not pills.classes[type] then
		print('ERROR: pills.Enable: No such pill "' .. type .. '"')
		return
	end
	if player.pill then
		pills.Disable(player)
	end
	player.pill = {}
	setmetatable(player.pill, {__index = pills.classes[type]})
	player.pill.player = player
	if SERVER then
		umsg.Start("pills.enable", player)
		umsg.String(type)
		umsg.End()
	end
	player.pill:Enabled()
end

function pills.Disable(player)
	if player.pill then
		player.pill:Disabled()
		player.pill = nil
	end
	if SERVER then
		umsg.Start("pills.disable", player)
		umsg.End()
	end
end

function pills.SetHumanSpeeds(walking, running)
	pills.speeds.walk = walking
	pills.speeds.run = running
end

local files = file.FindInLua("pills/*.lua")
for _, filename in pairs(files) do
	local offset, length, type = string.find(filename, "([%w_]*)\.lua")
	PILL = {}
	setmetatable(PILL, {__index = PillClass})
	PILL.base = PillClass
	PILL.type = type
	AddCSLuaFile("pills/" .. filename)
	include("pills/" .. filename)
	PILL:Initialize()
	pills.classes[type] = PILL
end

function random_sequence(...)
	local t = {}
	t.random = true
	t.sequences = arg
	return t
end

PillClass.animation = nil
PillClass.animations = {
	crouch = nil,
	crouchWalk = nil,
	idle = nil,
	jump = nil,
	run = nil,
	swim = nil,
	walk = nil
	}
PillClass.forced = nil

// called each frame to make the animations play
function PillClass:Animate()
	local sequence, rate
	if self.forced and CurTime() < self.forced.time then
		sequence, rate = self.forced.sequence, self.forced.rate
	else
		self.forced = nil
		sequence, rate = self:SequenceForAnimation(self:ChooseAnimation())
	end
	if sequence then
		local sequenceIndex = self.player:LookupSequence(sequence)
		if self.player:GetSequence() != sequenceIndex then
			self.player:ResetSequence(sequenceIndex)
		end
		self.player:SetPlaybackRate(rate)
		if self.ghost then
			sequenceIndex = self.ghost:LookupSequence(sequence)
			if self.ghost:GetSequence() != sequenceIndex then
				self.ghost:Fire("setanimation", sequence, 0)
			end
			self.ghost:SetPlaybackRate(rate)
		end
	end
end

// returns the animation that should be playing
function PillClass:ChooseAnimation()
	local speed = self.player:GetVelocity():Length()
	if self.player:OnGround() then
		if self.player:Crouching() and self.animations.crouch or self.animations.crouchWalk then
			if self.animations.crouchWalk and speed > 0 then
				return "crouchWalk"
			elseif self.animations.crouch then
				return "crouch"
			end
		elseif self.animations.run and not self.player:Crouching() and self.player:KeyDown(IN_SPEED) then
			return "run"
		elseif self.animations.walk and speed > 0 then
			return "walk"
		end
	else
		if self.animations.swim and self.waterlevel and self.player:WaterLevel() >= self.waterlevel then
			return "swim"
		elseif self.animations.jump then
			return "jump"
		end
	end
	return "idle"
end

// forces an animation to play for the duration specified
function PillClass:ForceAnimation(animation, duration)
	self.forced = nil
	local s, r = self:SequenceForAnimation(animation)
	self:ForceSequence(s, r, duration)
end

// forces a mdl sequence to play for the duration and at the rate specified
function PillClass:ForceSequence(sequence, rate, duration)
	self.forced = {}
	self.forced.sequence = sequence
	self.forced.rate = rate
	self.forced.time = CurTime() + duration
end

// turns an animation into a mdl sequence
function PillClass:SequenceForAnimation(animation)
	local sequence, rate
	if type(self.animations[animation]) == "table" then
		if self.animations[animation].random then
			local a = self.animations[animation].sequences
			return a[math.random(#a)], self.animations[animation].rate or 1
		else
			return self.animations[animation][1], self.animations[animation][2]
		end
	else
		return self.animations[animation], 1
	end
end

PillMessages = {}

function PillMessages.DisableMessage(um)
	pills.Disable(LocalPlayer())
end
usermessage.Hook("pills.disable", PillMessages.DisableMessage)

function PillMessages.EnableMessage(um)
	pills.Enable(LocalPlayer(), um:ReadString())
end
usermessage.Hook("pills.enable", PillMessages.EnableMessage)

function PillMessages.GhostMessage(um)
	local player = LocalPlayer()
	if player.pill then
		player.pill.ghost = um:ReadEntity()
	end
end
usermessage.Hook("pills.ghost", PillMessages.GhostMessage)

local PillHooks = {}



if CLIENT then
	function PillHooks.CalcView(player, pos, ang, fov)
		if player.pill then return player.pill:CalcView(pos, ang, fov) end
	end
	hook.Add("CalcView", "PillHooks.CalcView", PillHooks.CalcView)
	return
end

function PillHooks.EntityTakeDamage(player, inflictor, attacker, amount)
	if player.pill then return player.pill:TakeDamage(inflictor, attacker, amount) end
end
hook.Add("EntityTakeDamage", "PillHooks.EntityTakeDamage", PillHooks.EntityTakeDamage)

function PillHooks.KeyPress(player, key)
	if player.pill then return player.pill:KeyPress(key) end
end
hook.Add("KeyPress", "PillHooks.KeyPress", PillHooks.KeyPress)

function PillHooks.KeyRelease(player, key)
	if player.pill then return player.pill:KeyRelease(key) end
end
hook.Add("KeyRelease", "PillHooks.KeyRelease", PillHooks.KeyRelease)

function PillHooks.PlayerDeath(player, weapon, attacker)
	if player.pill then return player.pill:Killed(attacker, weapon) end
end
hook.Add("PlayerDeath", "PillHooks.PlayerDeath", PillHooks.PlayerDeath)

function PillHooks.PlayerHurt(player, attacker)
	if player.pill then return player.pill:Hurt(attacker) end
end
hook.Add("PlayerHurt", "PillHooks.PlayerHurt", PillHooks.PlayerHurt)

function PillHooks.PlayerSpawn(player)
	if player.pill then
		GAMEMODE:PlayerSpawn(player)
		player.pill:Spawned()
		return false
	end
end
hook.Add("PlayerSpawn", "PillHooks.PlayerSpawn", PillHooks.PlayerSpawn)

function PillHooks.PlayerShouldTakeDamage(player, attacker)
	if player.pill then return player.pill:ShouldTakeDamage(attacker) end
end
hook.Add("PlayerShouldTakeDamage", "PillHooks.PlayerShouldTakeDamage", PillHooks.PlayerShouldTakeDamage)

function PillHooks.SetPlayerAnimation(player, animation)
	if player.pill then return player.pill:SetAnimation(player, animation) end
end
hook.Add("SetPlayerAnimation", "PillHooks.SetPlayerAnimation", PillHooks.SetPlayerAnimation)

function PillHooks.UpdateAnimation(player)
	if player.pill then return player.pill:Think() end
end
hook.Add("UpdateAnimation", "PillHooks.UpdateAnimation", PillHooks.UpdateAnimation)