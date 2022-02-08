include('shared.lua')

function LocalPlSetup()
	LocalPlayer().PREVY = 0
	LocalPlayer().PREVT = 0
	LocalPlayer().AIMPOS = {}
	LocalPlayer().AIMPOS.x = 0
	LocalPlayer().AIMPOS.y = 0
end
hook.Add("InitPostEntity", "localplsetup", LocalPlSetup)  

function ENT:Initialize()
end

function ENT:Draw()
	self.Entity:DrawModel()
end
/*
function MyCalcView( ply, origin, angles, fov )
	local Vehicle = ply:GetVehicle()
	local wep = ply:GetActiveWeapon()

	
	if ( ValidEntity( Vehicle ) && 
		 gmod_vehicle_viewmode:GetInt() == 1 
		 /*&& ( !ValidEntity(wep) || !wep:IsWeaponVisible() )*/
		) then
		
		return GAMEMODE:CalcVehicleThirdPersonView( Vehicle, ply, origin*1, angles*1, fov )
		
	end

	local ScriptedVehicle = ply:GetScriptedVehicle()
	if ( ValidEntity( ScriptedVehicle ) ) then
	
		// This code fucking sucks.
		local view = ScriptedVehicle.CalcView( ScriptedVehicle:GetTable(), ply, origin, angles, fov )
		if ( view ) then return view end

	end

	local view = {}
	view.origin 	= origin
	view.angles		= angles
	view.fov 		= fov
	
	// Give the active weapon a go at changing the viewmodel position
	
	if ( ValidEntity( wep ) ) then
	
		local func = wep.GetViewModelPosition
		if ( func ) then
			view.vm_origin,  view.vm_angles = func( wep, origin*1, angles*1 ) // Note: *1 to copy the object so the child function can't edit it.
		end
		
		local func = wep.CalcView
		if ( func ) then
			view.origin, view.angles, view.fov = func( wep, ply, origin*1, angles*1, fov ) // Note: *1 to copy the object so the child function can't edit it.
		end
	
	end
	
	if LocalPlayer():GetNetworkedBool("InChopper") && !(LocalPlayer():GetNetworkedBool("UsingCam")) then
		view.origin = origin - LocalPlayer():GetAimVector()*300 //+ math.random(-5,5)*LocalPlayer():GetUp() + math.random(-5,5)*LocalPlayer():GetRight()
	end
	return view
end
hook.Add("CalcView", "MyCalcView", MyCalcView) 
*/
function ENT:Think()
	if self.Entity:GetNetworkedBool("USE") then
		local VEnt = self.Entity:GetNetworkedEntity("ENNT")
		local a_velo = (self.Entity:GetAngles().y - LocalPlayer().PREVY)
		if a_velo>180 then a_velo = a_velo - 360 end
		if a_velo<-180 then a_velo = 360 + a_velo end
		a_velo = a_velo/(CurTime() - LocalPlayer().PREVT)
		PREVT = CurTime()
		local eyes = LocalPlayer():EyeAngles()
		local angs = self.Entity:GetAngles()
		PREVY = angs.y
		local w_p = -eyes.p + angs.p
		w_p = math.Max(-90, w_p)
		w_p = math.Min(20, w_p)
		local w_y = eyes.y - angs.y
		if w_y>180 then w_y = w_y - 360 end
		if w_y<-180 then w_y = 360 + w_y end
		w_y = math.Max(-40, w_y)
		w_y = math.Min(40, w_y)
		local rud = a_velo * 0.5
		rud = math.Max(-45, rud)
		rud = math.Min(45, rud)
		self.Entity:SetPoseParameter("weapon_pitch",w_p)
		VEnt:SetPoseParameter("weapon_pitch",w_p)
		self.Entity:SetPoseParameter("weapon_yaw",w_y)
		VEnt:SetPoseParameter("weapon_yaw",w_y)
		self.Entity:SetPoseParameter("rudder",rud)
		VEnt:SetPoseParameter("rudder",rud)
		local attach = self.Entity:LookupAttachment( "muzzle" )
		attach = VEnt:GetAttachment(attach)
		AimPos(attach.Pos, Angle(self.Entity:GetAngles().p - w_p, self.Entity:GetAngles().y + w_y, 0))
	end
	self:NextThink(CurTime()+0.01)
end

function AimPos(start, angs)
	local tracedata = {}
		tracedata.start = start
		tracedata.endpos = start + angs:Forward()*1000
	local trace = util.TraceLine(tracedata)
	LocalPlayer().AIMPOS = trace.HitPos:ToScreen()
end
	
function HUD()
	if LocalPlayer():GetNetworkedBool("InChopper") && !(LocalPlayer():GetNetworkedBool("UsingCam")) then
		surface.SetDrawColor( 255, 0, 0, 255 )
		surface.DrawOutlinedRect( LocalPlayer().AIMPOS.x-5, LocalPlayer().AIMPOS.y-5, 10, 10 )
		for k,v in pairs(ents.GetAll()) do
			if (v:IsNPC() || v:IsPlayer()) && v!=LocalPlayer() then
				local pos = v:GetPos() + Vector(0,0,30)
				local name = "Undefined Target"
				if v:IsNPC() then name = v:GetClass() end
				if v:IsPlayer() then name = v:Nick() end
				draw.DrawText( "+", "ScoreboardText", pos:ToScreen().x, pos:ToScreen().y-10, Color(255,0,0,255), 1 )
				draw.DrawText( name, "ScoreboardText", pos:ToScreen().x+3, pos:ToScreen().y-15, Color(255,0,0,255), 0 )
			end
		end
		local GRTime = math.Max(CurTime()-LocalPlayer():GetNetworkedInt("HGunReloadTime")-0.1,0)
		GRTime = math.Min(2, GRTime)
		draw.RoundedBox( 4, 100, 20, 10, (ScrH()-40), Color(50,50,255,100) )
		if GRTime!=0 then draw.RoundedBox( 4, 100, 20, 10, (GRTime/2)*(ScrH()-40), Color(255,0,0,225) ) end
		for loop=1, 20, 1 do
			draw.RoundedBox( 4, 20, (loop*(ScrH()/22)), 20, 15, Color(50,50,255,100) )
		end
		for loop=1,LocalPlayer():GetNetworkedInt("HBullets"), 1 do
			draw.RoundedBox( 4, 23, ((21-loop)*(ScrH()/22))+3, 14, 9, Color(255,0,0,225) )
		end
		BRTime = math.Min(CurTime()-LocalPlayer():GetNetworkedInt("HLastBomb"),1.5)
		draw.RoundedBox( 4, ScrW()-300, 20, 250, 70, Color(50,50,255,100) )
		if BRTime!=0 then draw.RoundedBox( 4, ScrW()-300, 20, BRTime*(250/1.5), 70, Color(255,0,0,225) ) end
		Healthz = LocalPlayer():GetNetworkedInt("HHealthz")/2000
		draw.RoundedBox( 4, ScrW()-100, 100, 50, (ScrH()-120), Color(50,50,255,100) )
		if BRTime!=0 then draw.RoundedBox( 4, ScrW()-100, ScrH() - ((ScrH()-120)*Healthz+20),50, (ScrH()-120)*Healthz, Color(255,0,0,225) ) end
	end
end
hook.Add("HUDPaint", "ChopperHUD", HUD) 