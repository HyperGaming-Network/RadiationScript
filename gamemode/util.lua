-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- util.lua
-- Contains important server functions.
-------------------------------

function FreezeRagdoll( ent )

	
	if( ent:GetTable().StatueInfo ) then
		return;
	end
 	 
 	ent:GetTable().StatueInfo = {} 
 	ent:GetTable().StatueInfo.Welds = {} 
 	 
 	local bones = ent:GetPhysicsObjectCount() 
 	 
 	local forcelimit = 0 
 	 

 	for bone=1, bones do 
 	 
 		local bone1 = bone - 1 
 		local bone2 = bones - bone 
 		 

 		if ( !ent:GetTable().StatueInfo.Welds[bone2] ) then 
 		 
 			local constraint1 = constraint.Weld( ent, ent, bone1, bone2, forcelimit ) 
 			 
 			if ( constraint1 ) then 
 			 
 				ent:GetTable().StatueInfo.Welds[bone1] = constraint1 
 			 
 			end 
 			 
 		end 
 		 
 		local constraint2 = constraint.Weld( ent, ent, bone1, 0, forcelimit ) 
 		 
 		if ( constraint2 ) then 
 		 
 			ent:GetTable().StatueInfo.Welds[bone1+bones] = constraint2 
 		 
 		end 
 		 
 	end 

end


function string.explode(str)

	local rets = {};
	
	for i=1, string.len(str) do
	
		rets[i] = string.sub(str, i, i);
		
	end
	
	return rets;

end

function RAD.ReferenceFix(data)

	if(type(data) == "table") then
	
		return table.Copy(data);
		
	else
	
		return data;
		
	end
	
end

function RAD.NilFix(val, default)

	if(val == nil) then
	
		return default;
	
	else
	
		return val;
		
	end
	
end

function RAD.FindPlayer(name)

	local ply = nil;
	local count = 0;
	
	for k, v in pairs(player.GetAll()) do
	
		if(string.find(v:Nick(), name) != nil) then
			
				ply = v;
				
		end
			
		if(string.find(v:Name(), name) != nil) then
			
			ply = v;
				
		end
			
	end
	
	return ply;
	
end
