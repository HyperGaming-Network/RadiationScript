//Initial effect
function EFFECT:Init( data )
	
	local NumParticles = 2
	
	local emitter = ParticleEmitter( data:GetOrigin() )
	
		for i=0, NumParticles do

			local Pos = ( data:GetOrigin() ) //+ Vector( math.Rand(-5,5), math.Rand(-5,5), 0 ) )
		
			local particle = emitter:Add( "particle/particle_smokegrenade", Pos )
			if (particle) then
				
				particle:SetVelocity( Vector(math.Rand(-500,500),math.Rand(-500,500),math.Rand(100, 200 ))  )
				
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand(12, 14) )
				
			//	local rand = math.random(242,255)
			//	if math.random(1,12) == 12 then rand = math.random(210,232) end
				particle:SetColor(50,250,10)			

				particle:SetStartAlpha( 130 )
				particle:SetEndAlpha( 0 )
				
				local Size = math.Rand(20,30)
				particle:SetStartSize( Size )
				particle:SetEndSize( Size - 10 )
				
				particle:SetRoll( math.Rand(-360, 360) )
				particle:SetRollDelta( math.Rand(-0.21, 0.21) )
				
				particle:SetAirResistance( math.Rand(520,620) )
				
				particle:SetGravity( Vector( 0, 0, math.Rand(-32, -64) ) )

				particle:SetCollide( true )
				particle:SetBounce( 0.42 )

				particle:SetLighting(1)
			
			end
			
		end
		
	emitter:Finish()
	
end

//Not used
function EFFECT:Think( )
	return false
end

//Not used
function EFFECT:Render()
end
