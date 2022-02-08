RAD.ItemData = {  };

function RAD.LoadItem( filename )

	local path = "items/" .. filename;
	
	ITEM = {  };
	
	include( path );
	
	RAD.ItemData[ ITEM.Class ] = ITEM;
	
end

function RAD.CreateItem( class, pos, ang )

	if( RAD.ItemData[ class ] == nil ) then return; end
	
	local itemtable = RAD.ItemData[ class ];
	
	local item = ents.Create( "item_prop" );
	
	item:SetModel( itemtable.Model );
	item:SetAngles( ang );
	item:SetPos( pos );
	
	for k, v in pairs( itemtable ) do
		item[ k ] = v;
		if( type( v ) == "string" ) then
			item:SetNWString( k, v );
		end
	end
	
	item:Spawn( );
	item:Activate( );
	
end

function ccCreateItem( ply, cmd, args )

	if( ply:IsSuperAdmin( ) ) then
	
		-- Drop the item 80 units infront of him.
		RAD.CreateItem( args[ 1 ], ply:CalcDrop( ), Angle( 0,0,0 ) );
		RAD.DayLog( "itemspawns.txt", "Player: " .. ply:SteamID() .. " " .. ply:Name() .. " created item " .. args[ 1 ])
		
	end
	
end
concommand.Add( "rp_createitem", ccCreateItem );

function RAD.CreateMapItem( class, pos, ang, vel )

	if( RAD.ItemData[ class ] == nil ) then return; end
	
	local itemtable = RAD.ItemData[ class ];
	
	local item = ents.Create( "item_prop" );
	
	item:SetModel( itemtable.Model );
	item:SetAngles( ang );
	item:SetPos( pos );
	
	if( vel ) then
	item:SetVelocity( vel )
	end
	
	for k, v in pairs( itemtable ) do
		item[ k ] = v;
		if( type( v ) == "string" ) then
			item:SetNWString( k, v );
		end
	end
	
	item:Spawn( );
	item:Activate( );
		
end

function ccDropItem( ply, cmd, args )

	local inv = RAD.GetCharField( ply, "inventory" );
	for k, v in pairs( inv ) do
		if( v == args[ 1 ] ) then
			RAD.CreateItem( args[ 1 ], ply:CalcDrop( ), Angle( 0,0,0 ) );
			ply:TakeItem( args[ 1 ] );
		    local radarrp = RecipientFilter()
	        radarrp:AddAllPlayers()
        if( !ply:HasItem( "pda" ) ) then
             umsg.Start("pda_info", radarrp)
             umsg.Long( ply:EntIndex() )
             umsg.Bool( false )
             umsg.End()
             //local PDAPlayers[ ply:EntIndex() ] = false
	end
			return;
		end
		
     end	
end
concommand.Add( "rp_dropitem", ccDropItem );

UnusableItems = { "item_ziptie" }

function ccUseInv( ply, cmd, args )

	local inv = RAD.GetCharField( ply, "inventory" );
	for k, v in pairs( inv ) do
		if( v == args[ 1 ] ) then
	
		if(table.HasValue(UnusableItems, args[ 1 ])) then 
			RAD.SendChat( ply, "This item cannot be used." );
			return; 
		end
	
    local itemtable = RAD.ItemData[ args[ 1 ] ];
	
	local item = ents.Create( "item_prop" );
	item:SetModel( itemtable.Model );
	item:SetPos( Vector( 0, 0, 0 ) );
	item:SetAngles( Vector( 0, 0, 0 ) );
	item:SetColor( Color( 0, 0, 0, 0 ) );

	for k, v in pairs( itemtable ) do
		item[ k ] = v;
		if( type( v ) == "string" ) then
			item:SetNWString( k, v );
		end
	end

	item:Spawn( );
	item:Activate( );
	item:UseItem( ply );
	item:Remove()
			if( RAD.ItemData[ args[ 1 ] ].IsPrimaryWeapon ) then
			local weaponname = string.gsub(args[1],"FRE","")
			local weaponname = string.gsub(weaponname,"MILL","")
			local weaponname = string.gsub(weaponname,"DUTY","")
			if RAD.GetCharField(ply, "wepitem" ) == "none" then
				ply:GetTable().ForceGive = true
				ply:Give(weaponname);
				ply:GetTable().ForceGive = false
				ply:TakeItem( weaponname )
				RAD.SetCharField(ply, "wepitem", weaponname)
				item:Remove()
				return;
			else
				RAD.SendChat( ply, "You Already Have A Primary Weapon!" ); return; end
			end
			if( RAD.ItemData[ args[ 1 ] ].IsSecondaryWeapon ) then
			local weaponname = string.gsub(args[1],"FRE","")
			local weaponname = string.gsub(weaponname,"MILL","")
			local weaponname = string.gsub(weaponname,"DUTY","")
			if RAD.GetCharField(ply, "wepitem2" ) == "none" then
				ply:GetTable().ForceGive = true
				ply:Give(weaponname);
				ply:GetTable().ForceGive = false
				ply:TakeItem( weaponname )
				RAD.SetCharField(ply, "wepitem2", weaponname)
				item:Remove()
				return;
			else
				RAD.SendChat( ply, "You Already Have A Secondary Weapon!" ); return; end
			end
			if( string.find( args[1], "suit") != nil  ) then
				RAD.SetCharField(ply, "suit", args[1])
			end
	if( RAD.ItemData[ args[ 1 ] ].ItemTakeOnUse )then 
	ply:TakeItem( args[ 1 ] ) 	
			end 
	return;
		end
	end
	
end
concommand.Add( "rp_useinvitem", ccUseInv );

function ccBuyItem( ply, cmd, args )
	
	if( RAD.ItemData[ args[ 1 ] ] != nil ) then
		if( RAD.Teams[ ply:Team( ) ][ "business" ] ) then
		
			if( table.HasValue(RAD.Teams[ ply:Team( ) ][ "item_groups" ], RAD.ItemData[ args[ 1 ] ].ItemGroup) and !ply:HasItem('cca_permit') ) then
		
				if( RAD.ItemData[ args[ 1 ] ].Purchaseable and tonumber(RAD.GetCharField(ply, "money" )) >= RAD.ItemData[ args[ 1 ] ].Price ) then
				
					ply:ChangeMoney( 0 - RAD.ItemData[ args[ 1 ] ].Price );
					RAD.CreateItem( args[ 1 ], ply:CalcDrop( ), Angle( 0,0,0 ) );
			
				else
					
					RAD.SendChat( ply, "You do not have enough money to purchase this item!" );
					
				end
				
			elseif( ply:HasItem('cca_permit') and RAD.ItemData[ args[ 1 ] ].ItemGroup == 1 ) then
			
			if( RAD.ItemData[ args[ 1 ] ].Purchaseable and tonumber(RAD.GetCharField(ply, "money" )) >= RAD.ItemData[ args[ 1 ] ].Price ) then
				
					ply:ChangeMoney( 0 - RAD.ItemData[ args[ 1 ] ].Price );
					RAD.CreateItem( args[ 1 ], ply:CalcDrop( ), Angle( 0,0,0 ) );
			
			else
					
					RAD.SendChat( ply, "You do not have enough money to purchase this item!" );
			end
					
			else
		
			RAD.SendChat( ply, "You cannot purchase this item!" );
			
			end

				
			end
			
		else
		
			RAD.SendChat( ply, "You do not have a CCA Permit!" );
			
		end
end

concommand.Add( "rp_buyitem", ccBuyItem );

function ccSellItem( ply, cmd, args )

	local inv = RAD.GetCharField( ply, "inventory" );
	for k, v in pairs( inv ) do
		if( v == args[ 1 ] ) then
			if( RAD.Teams[ ply:Team( ) ][ "business" ] ) then
				if( RAD.ItemData[ args[ 1 ] ].Purchaseable ) then
					local sellprice = math.ceil(RAD.ItemData[ args[ 1 ] ].Price / 2)
					ply:ChangeMoney( sellprice );
					ply:TakeItem( args[ 1 ] );
					
					RAD.SendChat( ply, "Item sold for $" .. sellprice .. " Rubles.");
					
					return;
					
				else
					
					RAD.SendChat( ply, " " );
					
				end
				
			else
				
				RAD.SendChat( ply, " " );
				
			end
			
		else
			
			RAD.SendChat( ply, " " );
			
			
		end
	end
end

concommand.Add( "rp_sellitem", ccSellItem );







