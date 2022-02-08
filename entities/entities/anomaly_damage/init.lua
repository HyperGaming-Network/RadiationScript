AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Damage = {}
Damage.Radius = ENT.BaseScale*2
Damage.BaseDamage = 20
Damage.DamageType = 0
Damage.Delay = 0.2
Damage.RadInt = 0.2
Damage.RadInc = 1
Damage.NextRad = 0

local Warning = {}
Warning.Sound = {"player/geiger1.wav","player/geiger2.wav","player/geiger3.wav"}
Warning.NextTick = 0
Warning.TickDelay = 0.1
Warning.Radius = ENT.BaseScale*3

function ENT:Initialize()

	self.model = "models/Gibs/HGIBS_spine.mdl"
	self.Entity:SetModel( self.model ) 
 	
	self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox

	local phys = self.Entity:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(10000)

	end
	--self:CreateSprite()
	
	self.Entity:DrawShadow(false)
	self:CreatePointHurt()
	self:CreateSprite("220 0 0",0.5,200)
end  

function ENT:CreateSprite(color,size,alpha)
	local pos = self.Entity:GetPos()
	
	local sprite = ents.Create("env_sprite")
	sprite:SetPos(pos)
	local kv = {
		model="",
		scale=size,
		rendermode=5,
		renderamt=alpha,
		rendercolor=color,
	}
	sprite:KeyValueTable(kv);
	sprite:Spawn()
	sprite:Activate()
	sprite:SetParent(self.Entity)
	--print("Created")
end

local eMeta = FindMetaTable("Entity")
function eMeta:KeyValueTable(tbl)
	for k,v in pairs(tbl) do
		self:SetKeyValue(k,v)
	end
end

function ENT:CreatePointHurt()
	local hurt = ents.Create("point_hurt")
	hurt:SetPos(self.Entity:GetPos())
	local kvs = {
		DamageRadius = Damage.Radius,
		Damage = Damage.BaseDamage,
		DamageDelay = Damage.Delay,
		DamageType = Damage.DamageType
	}
	hurt:KeyValueTable(kvs)
	hurt:Spawn()
	hurt:SetParent(self.Entity)
	hurt:Fire("turnon","",0)
end

function ENT:Think()
	local all = player.GetAll()
	local ePos = self.Entity:GetPos()
	for k,user in pairs(all) do
		local uPos = user:GetPos()
		local dist = (ePos-uPos):Length()
		if dist < Warning.Radius then
			if CurTime() > Warning.NextTick then
				local ran = math.random(1,table.getn(Warning.Sound))
				user:EmitSound(Warning.Sound[ran])
				user:SetNetworkedFloat("rad",user:GetNetworkedFloat("rad")+Damage.RadInc)
				Warning.NextTick = CurTime()+Warning.TickDelay
			end
		end
	end
	if CurTime() > Damage.NextRad then
		Damage.NextRad = CurTime()+Damage.RadInt
		for k,user in pairs(all) do
			local uPos = user:GetPos()
			local dist = (ePos-uPos):Length()
			if dist < Warning.Radius then
				user:SetNetworkedFloat("rad",user:GetNetworkedFloat("rad")+Damage.RadInc)
			end
		end
	end
end

function ENT:KeyValue(key,value)
	self[key] = tonumber(value) or value
end

function ENT:SpawnFunction( ply, tr )

if ( !tr.Hit ) then return end

local SpawnPos = tr.HitPos + tr.HitNormal * 2
local ang = tr.HitNormal:Angle()
local ent = ents.Create( "anomaly_damage" )
ent:SetPos( SpawnPos )
--ent:SetAngles(ang)
ent:Spawn()
ent:Activate()

return ent

end
