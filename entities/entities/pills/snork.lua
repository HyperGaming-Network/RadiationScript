PILL.animations = {
	attack = "Melee",
	idle = "idle",
	run = "run",
	walk = "walk_all",
    jump = "LeapStrike",
	}
PILL.camera = {back = 48, z = 50}
PILL.model = Model("models/stalker/srk.mdl")
PILL.sounds = {
	attack = Sound("hgn/stalker/creature/snork/snorkscream.mp3"),
	attackHit = Sound("NPC_FastZombie.AttackHit"),
	attackMiss = Sound("hgn/stalker/creature/snork/snork_idle_1.mp3"),
	idle = Sound("NPC_FastZombie.AlertNear")
	}
PILL.speeds = {walking = 100, running = 298}

function PILL:ChooseAnimation()
	if self.attacking or CurTime() <= self.attackingTimer then
		return nil
	end
	return self.base.ChooseAnimation(self)
end

function PILL:Enabled()
	self.attacking = false
	self.attackingTimer = 0
	self.idleTimer = 0
	self.base.Enabled(self)
end

function PILL:KeyPress(key)
	if key == IN_ATTACK and not attacking and CurTime() > self.attackingTimer then
		self.attacking = true
		self.attackingTimer = CurTime() + 0.7
		self:ForceAnimation("attack", 1)
	elseif key == IN_ATTACK2 then
		if CurTime() > self.idleTimer then
			self.idleTimer = CurTime() + 2
			self.player:EmitSound(self.sounds.idle)
		end
	end
end

function PILL:Think()
	if self.attacking and CurTime() > self.attackingTimer then
		self.attacking = false
		self.attackingTimer = self.attackingTimer + 0.3
		if self:Melee(self.player:GetShootPos(), self.player:GetAimVector(), 50, Vector(-8, -8, -8), Vector(8, 8, 8), 15, "BloodImpact") then
			self.player:EmitSound(self.sounds.attackHit)
		else
			self.player:EmitSound(self.sounds.attackMiss)
		end
	end
	self.base.Think(self)
end
