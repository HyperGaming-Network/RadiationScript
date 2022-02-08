local function VectorString (vec)
	return "Vector ("..math.floor (vec.x * 10000) / 10000 ..", "..math.floor (vec.y * 10000) / 10000 ..", "..math.floor (vec.z * 10000) / 10000 ..")"
end

if SERVER then
	AddCSLuaFile ("shared.lua")
	SWEP.HoldType = "ar2"
else
	SWEP.PrintName		= "Ironsights Designer"
	SWEP.Author			= "Devenger"
	SWEP.Contact		= "devenger@gmail.com"
	SWEP.Purpose		= "Design ironsight coordinates for scripted weapons"
	SWEP.Instructions	= "Left click to drag weapon, right-click to change drag mode, press sprint to activate mouse and use menu.\nIronsight coordinates can be printed to console or saved to a .txt file."
	SWEP.Slot		= 5
	SWEP.SlotPos	= 100
	SWEP.ViewModelFlip	= true
end

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_p228.mdl"

SWEP.ViewModelFOV		= 82
SWEP.BobScale			= 0
SWEP.SwayScale			= 0

SWEP.Primary.Ammo		= ""
SWEP.Secondary.Ammo		= ""

SWEP.IronsMul			= 1
SWEP.IronsMulDir		= 1
SWEP.IronsMoveTime		= 0.25

SWEP.IronsPos			= Vector (0,0,0)
SWEP.IronsAng			= Vector (0,0,0)

SWEP.AnglesModes		=	{
								{{"IronsPos","x",0.5},{"IronsPos","z",0.5},"Position X/Z (Left/Right/Up/Down Positioning)", "Pos X/Z"},
								{nil,{"IronsPos", "y",0.5},"Position Y (Backwards/Forwards)", "Pos Y"},
								{{"IronsAng","y",-1},{"IronsAng","x",1},"Angles Pitch/Yaw (Left/Right/Up/Down Angling)", "Ang Pitch/Yaw"},
								{{"IronsAng","z",-1},nil,"Angle Roll (Left/Right Lean)", "Ang Roll"}
							}

SWEP.AnglesMode			= 1
SWEP.Sensitivity		= 0.0005

function SWEP:Initialize ()
	self.IronsPos			= Vector (0,0,0)
	self.IronsAng			= Vector (0,0,0)
end

if SERVER then
	local function svSetViewModel (pl, cmd, args)
		local wpn = pl:GetActiveWeapon()
		local mName = string.gsub (args[1], ".mdl", "")
		if pl:GetActiveWeapon() and pl:GetActiveWeapon():GetClass() == "ironsights_designer" then
			--print ("got "..mName)
			if file.Exists ("../"..mName..".mdl") then
				--print ("new model: "..mName)
				util.PrecacheModel (mName..".mdl")
				wpn:GetTable().ViewModel = mName..".mdl"
				
				pl:SendLua ([[LocalPlayer():GetActiveWeapon():SetMessage ("Model changed to ]]..mName..[[.mdl")]])
				pl:SendLua ([[LocalPlayer():GetActiveWeapon():GetTable().ViewModel = "]]..mName..[[.mdl"]])
				pl:SendLua ([[LocalPlayer():GetViewModel():SetModel ("]]..mName..[[.mdl")]])
				pl:SendLua ([[IDSTBKeys["Model"]:SetText ("- Model: ]]..mName..".mdl"..[[")]])
			else
				pl:SendLua ([[LocalPlayer():GetActiveWeapon():SetMessage ("Could not find ]]..mName..[[.mdl")]])
			end
		end
	end

	concommand.Add ("sv__IDSetViewModel", svSetViewModel)
else
	function clSetViewModel (pl, cmd, args)
		local mName = string.gsub (args[1], ".mdl", "")
		if string.find (mName, "/") then
			LocalPlayer():ConCommand ("sv__IDSetViewModel "..mName)
		else
			LocalPlayer():ConCommand ("sv__IDSetViewModel models/weapons/"..mName)
		end
	end
	
	local wpnmodels = file.Find ("../models/weapons/*.mdl")
	for k,v in pairs (wpnmodels) do
		if string.sub (v, 1, 2) == "w_" then wpnmodels[k] = nil else wpnmodels[k] = string.gsub(string.lower(v), ".mdl", "") end
	end
	
	function clSetViewModelAC (cmd, args)
		if string.find (args, "/") then return {} end
		local args = string.sub (args, 2)
		local ACos = {}
		for k,v in pairs (wpnmodels) do
			local compN = string.gsub (v, ".mdl", "")
			if string.find (compN, args) then
				ACos[#ACos+1] = "ID_ViewModel "..string.gsub (v, ".mdl", "")
			end
		end
		return ACos
	end
	
	concommand.Add ("ID_ViewModel", clSetViewModel, clSetViewModelAC)
end

function SWEP:PrimaryAttack () end

SWEP.LastSecondaryAttack = 0

function SWEP:SecondaryAttack ()
	if SERVER then return end
	if self.LastSecondaryAttack > CurTime() - 0.1 then return end
	self.AnglesMode = self.AnglesMode + 1
	if self.AnglesMode > #self.AnglesModes then self.AnglesMode = 1 end
	self.Dragging = false
	self.Owner:EmitSound ("Weapon_Pistol.Empty")
	self.LastSecondaryAttack = CurTime()
end

function SWEP:ToggleIronsights ()
	if self.IronsToggleDown then return end
	self:MenuToggleIronsights ()
	self.IronsToggleDown = true
end

function SWEP:ToggleMenu ()
	if self.MenuToggleDown then return end
	self.MenuActive = not self.MenuActive
	gui.EnableScreenClicker (self.MenuActive)
	self.MenuToggleDown = true
end

function SWEP:MenuOpenModelEntry ()
	if not IDModelTextEntry then
		local x = IDMenu.X + IDSTBKeys["Model"].X + 55
		local y = IDMenu.Y + IDSTBKeys["Model"].Y - 1
		IDModelTextEntry = vgui.Create ("ID_TextEntry")
		IDModelTextEntry:SetVisible (true)
		IDModelTextEntry:MakePopup()
		IDModelTextEntry:SetPos (x, y)
		IDModelTextEntry:SetSize (300, 21)
		IDModelTextEntry:SetText (string.gsub (IDSTBKeys["Model"]:GetValue(), "- Model: ", ""))
		IDModelButton = vgui.Create ("Button")
		IDModelButton:SetPos (x + 302, y)
		IDModelButton:SetText ("Set")
		IDModelButton:SetSize (40, 21)
		IDModelButton:GetTable().DoClick = function (self)
			LocalPlayer():ConCommand ("ID_ViewModel "..IDModelTextEntry:GetValue())
			IDModelTextEntry:Remove()
			IDModelTextEntry = nil
			self:Remove()
		end
	else
		IDModelTextEntry:Remove()
		IDModelTextEntry = nil
		IDModelButton:Remove()
	end
end

function SWEP:MenuToggleIronsights ()
	self.IronsMulDir = -self.IronsMulDir
	local str = "- Ironsights: Off"
	if self.IronsMulDir > 0 then str = "- Ironsights: On" end
	IDSTBKeys["Ironsights"]:SetText (str)
end

function SWEP:MenuToggleFlip ()
	self.ViewModelFlip = not self.ViewModelFlip
	local str = "- Model flip: Off"
	if self.ViewModelFlip then str = "- Model flip: On" end
	IDSTBKeys["Flip"]:SetText (str)
end

function SWEP:MenuToggleCrosshair ()
	self.DrawCrosshair = not self.DrawCrosshair
	local str = "- Crosshair: Off"
	if self.DrawCrosshair then str = "- Crosshair: On" end
	IDSTBKeys["Crosshair"]:SetText (str)
end

function SWEP:MenuPrintIronsightFunctions (miss)
	print ("--------------------\nSWEP.IronSightsPos = "..VectorString (self.IronsPos).."\nSWEP.IronSightsAng = "..VectorString (self.IronsAng).."\n--------------------\n")
	if not miss then self:SetMessage ("Functions printed to console") end
end

function SWEP:MenuLoadIronsightFunctions ()
	--Thank you RabidToaster with help approaching this/dealing with a string.find difficulty.
	local path = "ironsights/"..string.gsub(string.gsub(self.Weapon.Owner:GetViewModel():GetModel(), "models/weapons/", ""), ".mdl", "")..".txt"
	local success = false
	if file.Exists (path) then
		local str = file.Read (path)
		local lines = {
			string.sub (str, 1, string.find (str, "\n")-1),
			string.sub (str, string.find (str, "\n")+1)
		}
		
		local targetTbl = self.IronsPos
		local org = {"x","y","z"}
		
		for k,line in pairs(lines) do	
			local numStr = string.gsub (string.sub (line, string.find (line, "\(", 1, true)+1, string.find (line, "\)", 1, true)-1), " ", "")
			local tbl = string.Explode (",", numStr)
			if not #tbl == 3 then return end
			for k,v in pairs (tbl) do
				targetTbl[org[k]] = tonumber(v)
			end
			if targetTbl == self.IronsPos then
				targetTbl = self.IronsAng
			else
				success = true
			end
		end
	end
	
	if success then
		self:SetMessage ("Ironsights loaded from "..path)
	else
		self:SetMessage ("Failed to load: "..path.." either invalid or does not exist.")
	end
end

function SWEP:MenuSaveIronsightFunctions ()
	if not file.IsDir ("ironsights") then file.CreateDir ("ironsights") end
	local path = "ironsights/"..string.gsub(string.gsub(self.Weapon.Owner:GetViewModel():GetModel(), "models/weapons/", ""), ".mdl", "")..".txt"
	file.Write (path, "SWEP.IronSightsPos = "..VectorString (self.IronsPos).."\nSWEP.IronSightsAng = "..VectorString (self.IronsAng))
	self:SetMessage ("Functions saved to "..path)
end

function SWEP:MenuTransplantIronsights ()
	local hits = 0
	
	for k,v in pairs (LocalPlayer():GetWeapons()) do
		print (v)
		local wpn = v:GetTable()
		if wpn.Classname != "ironsights_designer" and wpn.ViewModel == LocalPlayer():GetViewModel():GetModel() then
			print ("transplanting")
			wpn.IronSightsPos = self.IronsPos
			wpn.IronSightsAng = self.IronsAng
			hits = hits + 1
		end
	end
	
	if hits > 0 then self:SetMessage ("Ironsights transplanted onto "..hits.." weapons. This is only temporary, changes are not saved!", 7) else
	self:SetMessage ("No weapons with matching models found.") end
end

function SWEP:MenuResetSelectedAxes ()
	if self.AnglesModes[self.AnglesMode][1] then
		self[self.AnglesModes[self.AnglesMode][1][1]][self.AnglesModes[self.AnglesMode][1][2]] = 0
	end
	if self.AnglesModes[self.AnglesMode][2] then
		self[self.AnglesModes[self.AnglesMode][2][1]][self.AnglesModes[self.AnglesMode][2][2]] = 0
	end
	self:SetMessage ("Reset "..self.AnglesModes[self.AnglesMode][4])
end

function SWEP:MenuResetAllAxes ()
	self.IronsPos			= Vector (0,0,0)
	self.IronsAng			= Vector (0,0,0)
	self:SetMessage ("Reset all axes")
end

function SWEP:MenuPrimaryAttack ()
	self:RequestFireAnim (ACT_VM_PRIMARYATTACK)
	self.Weapon:SendWeaponAnim (ACT_VM_PRIMARYATTACK)
end

function SWEP:MenuSecondaryAttack ()
	self:RequestFireAnim (ACT_VM_SECONDARYATTACK)
	self.Weapon:SendWeaponAnim (ACT_VM_SECONDARYATTACK)
end

function SWEP:MenuReload ()
	self:RequestFireAnim (ACT_VM_RELOAD)
	self.Weapon:SendWeaponAnim (ACT_VM_RELOAD)
end

function SWEP:RequestFireAnim (num)
	RunConsoleCommand ("RequestFireAnim", num)
end

if SERVER then
	function PlayFireAnim (pl, cmd, args)
		if not pl:GetActiveWeapon():IsValid() or pl:GetActiveWeapon():GetClass() != "ironsights_designer" then return end
		local act = tonumber(args[1])
		if act then pl:GetActiveWeapon():SendWeaponAnim(act) end
	end
	
	concommand.Add ("RequestFireAnim", PlayFireAnim)
end

SWEP.LastPrintOut = 0

function SWEP:Think ()
	if SERVER then return end
	
	if self.Owner:KeyPressed (IN_ATTACK2) then self:SecondaryAttack() end
	if self.Owner:KeyDown (IN_JUMP) then self:ToggleIronsights() else self.IronsToggleDown = false end
	if self.Owner:KeyDown (IN_SPEED) then self:ToggleMenu() else self.MenuToggleDown = false end
	
	if self.Owner:KeyDown (IN_RELOAD) then
		if self.Owner:KeyPressed (IN_USE) then
			self:MenuResetAllAxes()
			return
		elseif self.Owner:KeyPressed (IN_RELOAD) then
			self:MenuResetSelectedAxes()
		end
	end
	
	if self.Owner:KeyPressed (IN_USE) and self.LastPrintOut + 0.2 < CurTime() then
		self:MenuPrintIronsightFunctions ()
		self.LastPrintOut = CurTime()
	end
	
	if self.Owner:KeyPressed (IN_ATTACK) then
		self.Dragging = true
	elseif self.Owner:KeyReleased (IN_ATTACK) then
		self.Dragging = false
	end
	
	local flipMul = 1
	if self.ViewModelFlip then flipMul = -1 end
	
	if self.Dragging then
		local cmd = self.Owner:GetCurrentCommand()
		local mode = self.AnglesModes[self.AnglesMode]
		if mode[1] then
			self[mode[1][1]][mode[1][2]] = math.floor ((self[mode[1][1]][mode[1][2]] + cmd:GetMouseX() * self.Sensitivity * flipMul * mode[1][3]) * 10000) / 10000
		end
		if mode[2] then
			self[mode[2][1]][mode[2][2]] = math.floor ((self[mode[2][1]][mode[2][2]] + cmd:GetMouseY() * self.Sensitivity * -1 * mode[2][3]) * 10000) / 10000
		end
	end
	
	if not IDSTBKeys then return end
	IDSTBKeys["Pos"]:SetText ("- Ironsight Pos: "..VectorString (self.IronsPos))
	IDSTBKeys["Ang"]:SetText ("- Ironsight Ang: "..VectorString (self.IronsAng))
end

function SWEP:Holster ()
	if CLIENT then self:MenuPrintIronsightFunctions (true) end
	return true
end

function SWEP:Deploy ()
	if CLIENT then self:ToggleMenu() end
end

function SWEP:FreezeMovement ()
	return self.Dragging
end
	
function SWEP:GetViewModelPosition (pos, ang)
	self.IronsMul = math.Clamp (self.IronsMul + self.IronsMulDir * FrameTime() / self.IronsMoveTime, 0, 1)
	mul = self.IronsMul
	
	if mul == 0 then return pos, ang end

	local Offset = self.IronsPos
	local AngMod = self.IronsAng
	
	if AngMod then
		ang = ang * 1
		ang:RotateAroundAxis (ang:Right(), 		AngMod.x * mul)
		ang:RotateAroundAxis (ang:Up(), 		AngMod.y * mul)
		ang:RotateAroundAxis (ang:Forward(), 	AngMod.z * mul)
	end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

	pos = pos + Offset.x * Right * mul
	pos = pos + Offset.y * Forward * mul
	pos = pos + Offset.z * Up * mul
	
	return pos, ang
end

if SERVER then return end

SWEP.MessageTime = -11
SWEP.MessageHangTime = 3

function SWEP:SetMessage (msg, t)
	print (msg)
	self.Message = msg
	self.MessageTime = CurTime()
	if t then self.MessageHangTime = t else self.MessageHangTime = 3 end
end

surface.CreateFont ("coolvetica", 48, 1000, true, false, "IDName") 
surface.CreateFont ("coolvetica", 24, 500, true, false, "IDSubtitle") 
surface.CreateFont ("coolvetica", 19, 500, true, false, "IDHelp") 

SWEP.Gradient			= surface.GetTextureID ("gui/gradient")
SWEP.InfoIcon			= surface.GetTextureID ("gui/info")
SWEP.ToolNameHeight		= 0

SWEP.InfoBoxHeight = 80
SWEP.InfoBox2Height = 194

SWEP.MenuCreated = false
SWEP.MenuY = 0

function SWEP:DrawHUD ()
	local x, y = 50, 40 
 	local w, h = 0, 0 
 	 
 	TextTable = {} 
 	QuadTable = {} 
 	 
 	QuadTable.texture 	= self.Gradient 
 	QuadTable.color		= Color (10, 10, 10, 120) 
 	 
 	QuadTable.x = 0 
 	QuadTable.y = y-8 
 	QuadTable.w = 600 
 	QuadTable.h = self.ToolNameHeight - (y-8) 
 	draw.TexturedQuad (QuadTable) 
 	 
 	TextTable.font = "IDName" 
 	TextTable.color = Color (240, 240, 240, 255) 
 	TextTable.pos = {x, y} 
 	TextTable.text = "Ironsights Designer"
 	 
 	w, h = draw.TextShadow (TextTable, 3) 
 	y = y + h 
   
 	TextTable.font = "IDSubtitle" 
 	TextTable.pos = {x, y} 
 	TextTable.text = "Current mode: "..self.AnglesModes[self.AnglesMode][3]
 	w, h = draw.TextShadow (TextTable, 2) 
 	y = y + h + 8 
 	 
 	self.ToolNameHeight = y 
 	 
 	y = y + 1
	
	self.MenuY = y
	
	if self.MessageTime > CurTime() - self.MessageHangTime then
		local alpha = math.min (((self.MessageTime - CurTime()) / self.MessageHangTime * 800) + 600, 0)
		draw.SimpleText (self.Message, "IDSubtitle", ScrW() / 2 + 2, ScrH() / 2 - 126, Color (0, 0, 0, 255 + alpha),1,1)
		draw.SimpleText (self.Message, "IDSubtitle", ScrW() / 2, ScrH() / 2 - 128, Color (240, 240, 240, 200 + alpha),1,1)
	end
	
	active = "Off"
	if self.IronsMulDir > 0 then active = "On" end
	draw.SimpleText ("Ironsights "..active, "IDSubtitle", ScrW() / 2 + 2, ScrH() / 2 - 97, Color (0, 0, 0, 255),1,1)
	draw.SimpleText ("Ironsights "..active, "IDSubtitle", ScrW() / 2, ScrH() / 2 - 99, Color (240, 240, 240, 200),1,1)
	
	draw.SimpleText (self.AnglesModes[self.AnglesMode][4], "IDSubtitle", ScrW() / 2 + 2, ScrH() / 2 - 78, Color (0, 0, 0, 255),1,1)
	draw.SimpleText (self.AnglesModes[self.AnglesMode][4], "IDSubtitle", ScrW() / 2, ScrH() / 2 - 80, Color (240, 240, 240, 200),1,1)
	
	if not self.MenuCreated or not IDMenu then
		if IDMenu then IDMenu:Remove() IDMenu = nil end
		IDMenu = vgui.Create ("ID_Menu")
		self.MenuCreated = true
	elseif IDMenu:IsValid() and not IDMenu:IsVisible() then
		IDMenu:SetVisible (true)
	end
end

local PANEL = {}

PANEL.Gradient = surface.GetTextureID ("gui/gradient")

local STBs = {
	{"LEFT-CLICK: Drag weapon into position"},
	{"RIGHT-CLICK: Change drag mode"},
	{"SPRINT: Toggle mouse"},
	"GAP",
	{"- Model: "..SWEP.ViewModel, "OpenModelEntry", "Model"},
	{"- Ironsight Pos: "..VectorString (SWEP.IronsPos), nil, "Pos"},
	{"- Ironsight Ang: "..VectorString (SWEP.IronsAng), nil, "Ang"},
	"GAP",
	{"- Reset selected axes (RELOAD)", "ResetSelectedAxes"},
	{"- Reset all axes (USE + RELOAD)", "ResetAllAxes"},
	{"- Ironsights: On (JUMP)", "ToggleIronsights", "Ironsights"},
	{"- Model flip: On", "ToggleFlip", "Flip"},
	{"- Crosshair: On", "ToggleCrosshair", "Crosshair"},
	"GAP",
	{"- Load ironsights from data/ironsights/*.txt", "LoadIronsightFunctions"},
	{"- Transplant ironsights onto all SWEPs in inventory with same model", "TransplantIronsights"},
	{"- Print ironsight functions to console (USE)", "PrintIronsightFunctions"},
	{"- Save ironsight functions to data/ironsights/*.txt", "SaveIronsightFunctions"},
	"GAP",
	{"- Test animation 1", "PrimaryAttack"},
	{"- Test animation 2", "Reload"},
	"GAP",
	{"Made by Devenger (devenger(at)gmail.com)"},
	{"Additional credits to RabidToaster for code assistance"}
}

function PANEL:Init ()
	--self.TextEntry = vgui.Create ("ID_TextEntry", self)
	--self.STB = vgui.Create ("ID_StatusToggleButton", self)
	self.STBs = {}
	IDSTBKeys = {}
	for k,v in pairs (STBs) do
		if v != "GAP" then
			self.STBs[k] = vgui.Create ("ID_StatusToggleButton", self)
			self.STBs[k]:SetText (v[1])
			self.STBs[k]:SetFunction (v[2])
			if v[3] then IDSTBKeys[v[3]] = self.STBs[k] end
		else
			self.STBs[k] = v
		end
	end
end

function PANEL:Paint ()
	surface.SetDrawColor (10, 10, 10, 140) 
	surface.SetTexture (self.Gradient) 
	local y = 0
	yStart = 0
	for k,v in pairs (self.STBs) do
		if v == "GAP" then
		 	surface.DrawTexturedRect (0, yStart, self:GetWide(), y+2-yStart)
			y = y + 3
			yStart = y
		else
			y = y + 19
		end
	end
	surface.SetDrawColor (10, 10, 10, 140) 
 	surface.SetTexture (self.Gradient) 
 	surface.DrawTexturedRect (0, yStart, self:GetWide(), y+2-yStart)
end

function PANEL:PerformLayout ()
	local y = 1
	for k,v in pairs (self.STBs) do
		if v != "GAP" then
			v:SetPos (50, y)
			v:SetSize (600, 21)
			y = y + 19
		else
			y = y + 3
		end
	end
	local Gy = 0
	if LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetClass() == "ironsights_designer" then Gy = LocalPlayer():GetActiveWeapon():GetTable().MenuY end
	self:SetPos (0, Gy)
	self:SetSize (600, y+2)
	--self.STB:SetPos (50, 1)
end

function PANEL:Think ()
	if not LocalPlayer():GetActiveWeapon():IsValid() or LocalPlayer():GetActiveWeapon():GetClass() != "ironsights_designer" then
		self:SetVisible (false)
		gui.EnableScreenClicker (false)
	end
end

vgui.Register ("ID_Menu", PANEL)

PANEL = {}

PANEL.DefaultColour = Color (240, 240, 240, 255)
PANEL.MouseOnColour = Color (240, 240, 50, 255)

function PANEL:OnCursorEntered ()
	self.MouseOn = true
end

function PANEL:OnCursorExited ()
	self.MouseOn = false
end

function PANEL:Paint ()
	--print (self:GetValue())
	draw.SimpleText (self:GetValue(), "IDHelp", 2, 2, Color (0, 0, 0, 200))
	col = self.DefaultColour
	if self.MouseOn and self.Function then col = self.MouseOnColour end
	draw.SimpleText (self:GetValue(), "IDHelp", 0, 0, col)
	return true
end

function PANEL:SetFunction (str)
	self.Function = str
end

function PANEL:DoClick ()
	if not self.Function or not LocalPlayer():GetActiveWeapon():IsValid() or LocalPlayer():GetActiveWeapon():GetClass() != "ironsights_designer" then return end
	local str = LocalPlayer():GetActiveWeapon():GetTable()["Menu"..self.Function](LocalPlayer():GetActiveWeapon():GetTable())
	LocalPlayer():EmitSound ("Weapon_Pistol.Empty")
	if str then
		self:SetText (str)
	end
end

vgui.Register ("ID_StatusToggleButton", PANEL, "Button")

PANEL = {}

vgui.Register ("ID_TextEntry", PANEL, "TextEntry")