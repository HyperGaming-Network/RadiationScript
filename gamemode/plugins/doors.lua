PLUGIN.Name = "Doors"; -- What is the plugin name
PLUGIN.Author = "LastExile"; -- Author of the plugin
PLUGIN.Description = "For Doors"; -- The description or purpose of the plugin

RAD.Doors = {}

function RAD.LoadDoors()

	if(file.Exists("RadiationScript/MapData/" .. game.GetMap() .. ".txt")) then

		local rawdata = file.Read("RadiationScript/MapData/" .. game.GetMap() .. ".txt");
		local tabledata = util.KeyValuesToTable(rawdata);
		
		RAD.Doors = tabledata;
		
	end
	
end

function RAD.GetDoorGroup(entity)
		
	local pos = entity:GetPos();
	local doorgroups = {};

	for k, v in pairs(RAD.Doors) do
		
		if(tonumber(v["x"]) == math.ceil(tonumber(pos.x)) and tonumber(v["y"]) == math.ceil(tonumber(pos.y)) and tonumber(v["z"]) == math.ceil(tonumber(pos.z))) then
			
			table.insert(doorgroups, v["group"]);
				
		end
			
	end

	return doorgroups;

end

local function ccLockDoor( ply, cmd, args )
	
	local entity = ents.GetByIndex( tonumber( args[ 1 ] ) );
	
	if( RAD.IsDoor( entity ) ) then
	
    	if( entity.owner == ply or ply:OwnsDoor( entity) ) then
		
			entity:Fire( "lock", "", 0 );

        elseif( ply:IsInDoorGroup( entity ) ) then
		
		entity:Fire( "lock", "", 0 );
			
		else
		
			RAD.SendChat( ply, "This is not your door!" );
			
		end
		
	end

end
concommand.Add( "rp_lockdoor", ccLockDoor );

local function ccUnLockDoor( ply, cmd, args )
	
	local entity = ents.GetByIndex( tonumber( args[ 1 ] ) );
	
	if( RAD.IsDoor( entity ) ) then


		if( entity.owner == ply or ply:OwnsDoor( entity) ) then 
			
		entity:Fire( "unlock", "", 0 );
			
	    elseif( ply:IsInDoorGroup( entity ) ) then
		
		entity:Fire( "unlock", "", 0 );
		

		else
		
			RAD.SendChat( ply, "This is not your door!" );
			
		end
		
	end

end
concommand.Add( "rp_unlockdoor", ccUnLockDoor );

local function ccPickLockDoor( ply, cmd, args )
	
	local entity = ents.GetByIndex( tonumber( args[ 1 ] ) );

	if( RAD.IsDoor( entity ) ) then
	
		if( ply:HasItem("lockpicks") ) then
		
		    if(ply:GetNWInt("picklocking") == 1) then RAD.SendChat( ply, "You're already picklocking a door!" ); return; end

		local function picklock(ply)

			local rand = math.random(1,6)

			if( rand == 3 ) then
			entity:Fire( "unlock", "", 0 );
			entity:Fire( "toggle", "", 0 );
		
			ply:ConCommand("say /me Successfully picklocks the door.");
			RAD.SendChat( ply, "You picklocked the door!" );
			else
			RAD.SendChat( ply, "Picklocking failed." );
			end
			timer.Destroy("door_"..ply:Nick());
			ply:SetNWInt("picklocking", 0);

        end
			

			
		    ply:SetNWInt("picklocking", 1);
			ply:ConCommand("say /me Tries to picklock the door.");
			timer.Create( "door_"..ply:Nick(), 4, 0, picklock, ply );

			
		else
		
			RAD.SendChat( ply, "You need to have picklocks to pick the door." );
			
		end
		
	end

end
concommand.Add( "rp_picklock", ccPickLockDoor );

local function ccOpenDoor( ply, cmd, args )

	local entity = ply:GetEyeTrace().Entity;

	if( entity != nil and entity:IsValid( ) and RAD.IsDoor( entity ) and ply:GetPos( ):Distance( entity:GetPos( ) ) < 200 ) then
	
		local pos = entity:GetPos( );
		
		for k, v in pairs( RAD.Doors ) do
		
			if( tonumber( v[ "x" ] ) == math.ceil( tonumber( pos.x ) ) and tonumber( v[ "y" ] ) == math.ceil( tonumber( pos.y ) ) and tonumber( v[ "z" ] ) == math.ceil( tonumber( pos.z ) ) ) then
			
				for k2, v2 in pairs( RAD.Teams[ ply:Team( ) ][ "door_groups" ] ) do
				
					if( tonumber( v[ "group" ] ) == tonumber( v2 ) ) then
					
						entity:Fire( "toggle", "", 0 );
						
					end
					
				end
				
			end
			
		end
		
	end
	
end
concommand.Add( "rp_opendoor", ccOpenDoor );

local function ccPurchaseDoor( ply, cmd, args )
	local door = ents.GetByIndex( tonumber( args[ 1 ] ) );
	
	local pos = door:GetPos( );
	
	for k, v in pairs( RAD.Doors ) do
		
		if( tonumber( v[ "x" ] ) == math.ceil( tonumber( pos.x ) ) and tonumber( v[ "y" ] ) == math.ceil( tonumber( pos.y ) ) and tonumber( v[ "z" ] ) == math.ceil( tonumber( pos.z ) ) ) then
		
			RAD.SendChat( ply, "This is not a purchaseable door!" );
			return;
			
		end
		
	end
	
	if( RAD.IsDoor( door ) ) then

		if( door.owner == nil ) then
		
			if( tonumber( RAD.GetCharField( ply, "money" ) ) >= 50 ) then
				
				-- Enough money to start off, let's start the rental.
				ply:ChangeMoney( -50 );
				door.owner = ply;
				ply.door = door;
				
				
			end
			
		elseif( door.owner == ply ) then
		
			door.owner = nil;
			door:GetTable().CoOwners = nil --Remove all the co-owners aswell
			RAD.SendChat( ply, "Door Unowned" );
			
		else
		
			RAD.SendChat( ply, "This door is already rented by someone else!" );
			
		end
	
	end
	
end
concommand.Add( "rp_purchasedoor", ccPurchaseDoor );


local function ccAddDoorOwner( ply, cmd, args )
	  local trace = { } 
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 75;
	trace.filter = ply;
		local tr = util.TraceLine(trace);
	local door = tr.Entity
	local target = RAD.FindPlayer( args[ 1 ] )
	if( RAD.IsDoor( door ) ) then

		if( door.owner == ply ) then -- if the player using the cmd is the owner
		
		if( door:GetTable().CoOwners == nil ) then door:GetTable().CoOwners = { } end
		 
		door:GetTable().CoOwners[#door:GetTable().CoOwners + 1] = target;
			
			 
		else -- if it isnt the owner
			
			RAD.SendChat( ply, "You can only add CoOwners if you bought the door!" );
			
		end
	
	end
	
end
concommand.Add( "rp_adddoorowner", ccAddDoorOwner );

local function ccRemoveDoorOwner( ply, cmd, args )
	  	local trace = { } 
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 75;
	trace.filter = ply;
		local tr = util.TraceLine(trace);
	local door = tr.Entity
	local target = RAD.FindPlayer( args[ 2 ] )
	if( RAD.IsDoor( door ) ) then

		if( door.owner == ply ) then -- if the player using the cmd is the owner
		 
		  for k, v in pairs( door:GetTable().CoOwners ) do
		    if( v == target ) then -- if the coowner is the target
		     door:GetTable().CoOwners[ k ] = nil --remove him.
			 return
		    end
          end
			 
		else -- if it isnt the owner
			
			RAD.SendChat( ply, "You can only remove CoOwners if you bought the door!" );
			
		end
	
	end
	
end
concommand.Add( "rp_removedoorowner", ccRemoveDoorOwner );

local function ccDoorTitle( ply, cmd, args )

	local trace = { } 
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 75;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local title = args[ 1 ];
	
	if( string.len( title ) > 25 ) then
	
		RAD.SendChat( ply, "Door Title is too long! Max 24 characters" );
		return;
		
	end
	
	if( RAD.IsDoor( tr.Entity ) ) then

		if( tr.Entity.owner == ply or ply:OwnsDoor( tr.Entity ) ) then -- if the player using the cmd is the owner
		
		tr.Entity:SetNWString( "doortitle", title );
			
			 
		else
			
			RAD.SendChat( ply, "You don't own this door!" );
			
		end
	
	end
	
end
concommand.Add( "rp_doortitle", ccDoorTitle );
