-- RadiationScript
-------------------
 
     local function CalcView( pl, origin, angles, fov )
   
         // get their ragdoll
       local ragdoll = pl:GetRagdollEntity();
       if( !ragdoll || ragdoll == NULL || !ragdoll:IsValid() ) then
/*	local vel = ply:GetVelocity()
	local ang = ply:EyeAngles()
	
	VelSmooth = VelSmooth * 0.5 + vel:Length() * 0.1
	WalkTimer = WalkTimer + VelSmooth * FrameTime() * 0.1
	
	angle.roll = angle.roll + ang:Right():DotProduct( vel ) * 0.01
	
	if ViewWobble > 0 then
	
		angle.roll = angle.roll + math.sin( CurTime() ) * ( ViewWobble * 15 )
		ViewWobble = ViewWobble - 0.1 * FrameTime()
		
	end
	
	if ply:GetGroundEntity() != NULL then
	
		angle.roll = angle.roll + math.sin( WalkTimer ) * VelSmooth * 0.001
		angle.pitch = angle.pitch + math.sin( WalkTimer * 0.3 ) * VelSmooth * 0.001
		
	end
		
	return self.BaseClass:CalcView( ply, origin, angle, fov )

	end */
       
        // find the eyes
        local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment( "eyes" ) );
        
         // setup our view
         local view = {
             origin = eyes.Pos,
             angles = eyes.Ang,
			 fov = 90, 
         };
        
          //
         return view;
     
      end
      hook.Add( "CalcView", "DeathView", CalcView );



