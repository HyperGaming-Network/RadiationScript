if CLIENT then
	SWEP.PrintName = "Pill"
	SWEP.Slot = 0
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
		draw.SimpleText("j", "TitleFont", x + wide / 2, y + tall * 0.2, Color(255, 210, 0, 255), TEXT_ALIGN_CENTER)
	end
else
	AddCSLuaFile("shared.lua")
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

SWEP.Author = "cringerpants"
SWEP.Contact = "http://cringerpants.phuce.com"
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Spawnable = false
SWEP.AdminSpawnable = false

SWEP.Primary.ClipSize, SWEP.Secondary.ClipSize = -1, -1
SWEP.Primary.DefaultClip, SWEP.Secondary.DefaultClip = -1, -1
SWEP.Primary.Automatic, SWEP.Primary.Automatic = false, false
SWEP.Primary.Ammo, SWEP.Secondary.Ammo = "none", "none"
SWEP.ViewModel = Model("models/weapons/v_bugbait.mdl")
SWEP.WorldModel = Model("models/weapons/w_bugbait.mdl")

function SWEP:Deploy()
	if CLIENT then return end
	if self.Owner.pill then self:Holster() end 
	self.Owner.oldmodel = self.Owner:GetModel()
	local offset, length, type = string.find(self:GetClass(), "pill_(.+)")
	pills.Enable(self.Owner, type)
	self.Owner.pill:Effect()
	self.Owner:DrawWorldModel(false)
	self.Owner:DrawViewModel(false)
	timer.Create("viewmodel" .. self.Owner:UniqueID(), 0.01, 1, self.Owner.DrawViewModel, self.Owner, false) // so i use a timer
	return true
end

function SWEP:Holster()
	if CLIENT then return end
	if self.Owner.pill then self.Owner.pill:Effect() end
	pills.Disable(self.Owner)
	if self.Owner.oldmodel then
		self.Owner:SetModel(self.Owner.oldmodel)
		self.Owner.oldmodel = nil
	end
	self.Owner:DrawWorldModel(true)
	self.Owner:DrawViewModel(true)
	return true
end

function SWEP:PrimaryAttack()
	return false
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end
