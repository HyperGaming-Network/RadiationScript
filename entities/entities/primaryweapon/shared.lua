ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Primary Weapon"
ENT.Author			= "Porcupine"
ENT.Category 		= "Weapon Attachments"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false


if SERVER then



function ENT:SetNewInfo( pl )

 if( pl:GetWeapon( RAD.GetCharField(pl, "wepitem") ).WorldModel != nil) then 

	local hat = self.Entity

	hat:SetOwner( pl );
	// hat:SetParent( pl );
	hat:SetModel( pl:GetWeapon( RAD.GetCharField(pl, "wepitem") ).WorldModel )

	hat:Spawn();
	hat:Activate();
   //     self:PhysicsInit( SOLID_VPHYSICS )  
      hat:SetMoveType( MOVETYPE_NONE )
	hat:SetSolid( SOLID_NONE )
	hat:SetCollisionGroup( COLLISION_GROUP_NONE )
	hat:DrawShadow( false )
 self.Entity:SetColor(255,255,255,255)

	return hat;
  else

	local hat = self.Entity

	hat:SetOwner( pl );
	// hat:SetParent( pl );
	hat:Spawn();
	hat:Activate();
   //     self:PhysicsInit( SOLID_VPHYSICS )  
      hat:SetMoveType( MOVETYPE_NONE )
	hat:SetSolid( SOLID_NONE )
	hat:SetCollisionGroup( COLLISION_GROUP_NONE )
	hat:DrawShadow( false )
  self.Entity:SetColor(255,255,255,0)
	return hat;


end
	
end

// end 

	function ENT:Think()
		if( !self.Entity:GetOwner():IsValid() ) then
			
			self.Entity:Remove()
		end
	end

/*
function ENT:SpawnWInfo( pl )
 if( pl:GetWeapon( RAD.GetCharField(pl, "wepitem") ).WorldModel != nil) then 

	local hat = self.Entity

	hat:SetOwner( pl );
	// hat:SetParent( pl );
	hat:SetModel( pl:GetWeapon( RAD.GetCharField(pl, "wepitem") ).WorldModel )

	hat:Spawn();
	hat:Activate();
   //     self:PhysicsInit( SOLID_VPHYSICS )  
      hat:SetMoveType( MOVETYPE_NONE )
	hat:SetSolid( SOLID_NONE )
	hat:SetCollisionGroup( COLLISION_GROUP_NONE )
	hat:DrawShadow( false )
 self.Entity:SetColor(255,255,255,255)

	return hat;
  else

	local hat = self.Entity

	hat:SetOwner( pl );
	// hat:SetParent( pl );
	hat:Spawn();
	hat:Activate();
   //     self:PhysicsInit( SOLID_VPHYSICS )  
      hat:SetMoveType( MOVETYPE_NONE )
	hat:SetSolid( SOLID_NONE )
	hat:SetCollisionGroup( COLLISION_GROUP_NONE )
	hat:DrawShadow( false )
  self.Entity:SetColor(255,255,255,0)
	return hat;


end
	
end
	


function ENT:SetNewInfo( pl )

 if( pl:GetWeapon( RAD.GetCharField(pl, "wepitem") ).WorldModel != nil) then 

	local hat = self.Entity
	hat:SetModel( pl:GetWeapon( RAD.GetCharField(pl, "wepitem") ).WorldModel )
	hat:DrawShadow( true )
 self.Entity:SetColor(255,255,255,255)
	return hat;
  else

	local hat = self.Entity
	hat:DrawShadow( false )
  self.Entity:SetColor(255,255,255,0)
	return hat;
end
	
end 

end
*/


function ENT:SetDropInfo( pl )
 self.Entity:SetColor(255,255,255,0)
end

end


if CLIENT then
 local roll1 = CreateClientConVar("roll", "0")
 local yaw1 = CreateClientConVar("yaw", "180")
 local pitch1 = CreateClientConVar("pitch", "180")
local x  =  CreateClientConVar("x", "-11")
local y =  CreateClientConVar("y", "2")
local z =  CreateClientConVar("z", "4")


    function ENT:Draw() 
		if( !self.Entity:GetOwner():IsValid() ) then
			return;
		end
	if LocalPlayer() != self.Entity:GetOwner() then
        local ply =  self.Entity:GetOwner()  --thanks Pecius!
	if ply:LookupBone("ValveBiped.Bip01_Spine2") then
	  local bone = ply:LookupBone("ValveBiped.Bip01_Spine2")  
			if !ply:Alive() then return end
	if( ply:GetActiveWeapon().WorldModel == self.Entity:GetModel() ) then return end;
	
        if bone then  
            local position, angles = ply:GetBonePosition(bone)
			
			local x1 = x:GetFloat();
			local y1 = y:GetFloat();
			local z1 = z:GetFloat();
			
            local x = angles:Up() * x1   
            local y = angles:Right() * y1  
            local z = angles:Forward() * z1 
  
            local pitch = pitch1:GetFloat();
            local yaw = yaw1:GetFloat();
            local roll = roll1:GetFloat();
			
      //      local scale = self:GetNWFloat("scale")  
		//	local scalevector = self:GetNWVector("scalevector")

            angles:RotateAroundAxis(angles:Forward(), pitch)  
            angles:RotateAroundAxis(angles:Right(), yaw)  
            angles:RotateAroundAxis(angles:Up(), roll)  
			
            self.Entity:SetPos( position + x + y + z)  
            self.Entity:SetAngles(angles)  
		//self:DrawModel()
      //      self:SetModelScale(scalevector * scale)  
        end  
	//	local eyepos = EyePos()  
	//	local eyepos2 = LocalPlayer():EyePos()  
  -- thanks Lexic and Pecius!
			self.Entity:DrawModel()
end
		end
    end  
// end

end
