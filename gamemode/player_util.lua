-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- player_util.lua
-- Useful functions for players.
-------------------------------

function RAD.SendChat( ply, msg )

	ply:PrintMessage( 3, msg );
	
end

function RAD.SendConsole( ply, msg )

	ply:PrintMessage( 2, msg );
	
end

function RAD.DeathMode( ply )
    local ply_pos = ply:GetPos()
	local ply_ang = ply:GetAngles()
	local ply_mdl = ply:GetModel()
	
	local inv = RAD.GetCharField( ply, "inventory" );
	local invamt = table.Count(inv)
	
	local rag = ents.Create("prop_ragdoll")
	rag:SetPos(ply_pos)
	rag:SetAngles(ply_ang - Angle(ply_ang.p,0,0))
	rag:SetModel(ply_mdl)
	rag:Spawn()
	
	ply:SetNWInt( "deathmode", 1 )
	ply:SetNWInt( "deadmoderemaining", 60 );
	
	ply.deathtime = 0;
	ply.nextsecond = CurTime( ) + 1;

	local plyvel = ply:GetVelocity()
	
	for i = 1, rag:GetPhysicsObjectCount() do
		local bone = rag:GetPhysicsObjectNum(i)
		
		if bone and bone.IsValid and bone:IsValid() then
			local bonepos, boneang = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			
			bone:SetPos(bonepos)
			bone:SetAngle(boneang)
			
			bone:AddVelocity(plyvel)
		end
	end
	
	if ply:IsOnFire() then rag:Ignite(math.Rand(6, 8), 0) end
	
	ply:SpectateEntity(rag)
	ply:Spectate(OBS_MODE_CHASE)
	
	local function RemoveRagdoll( )
		
		if( rag and rag:IsValid() ) then
		
			rag:Remove( );
			rag = nil;
			
		end
		
	end
	
	timer.Simple( 1200, RemoveRagdoll );
	
end
	

local meta = FindMetaTable( "Player" );

function meta:IsInDoorGroup( entity )

        if( RAD.IsDoor( entity ) ) then

        local pos = entity:GetPos( );
		
		for k, v in pairs( RAD.Doors ) do
		
			if( tonumber( v[ "x" ] ) == math.ceil( tonumber( pos.x ) ) and tonumber( v[ "y" ] ) == math.ceil( tonumber( pos.y ) ) and tonumber( v[ "z" ] ) == math.ceil( tonumber( pos.z ) ) ) then
			
				for k2, v2 in pairs( RAD.Teams[ self:Team( ) ][ "door_groups" ] ) do
				
					if( tonumber( v[ "group" ] ) == tonumber( v2 ) ) then
					
						return true;
						
					end
					
				end
				
			end
			
		end

end
		return false;
end

function meta:HasFlag(flag)

	local flags = RAD.GetCharField(self, "flags" );
 for k,v in pairs(flags) do
    if(table.HasValue(flags, flag)) then return true; end
    return false;
 end

end

function meta:IsCombine()

if(self:HasFlag("cp") or self:HasFlag("dispatch") or self:HasFlag("t") or self:HasFlag("ow") or self:HasFlag("elite") or self:HasFlag("ca") ) then return true; end

return false;

end

function meta:HasItem(item)

	local inv = RAD.GetCharField( self, "inventory" );

		if( table.HasValue(inv, item) ) then
			return true;
		end

	return false;

end

function meta:MaxHealth( )

	return self:GetNWFloat("MaxHealth");
	
end

function meta:ChangeMaxHealth( amt )

	self:SetNWFloat("MaxHealth", self:MaxHealth() + amt);
	
end

function meta:MaxArmor( )

	return self:GetNWFloat("MaxArmor");
	
end

function meta:ChangeMaxArmor( amt )

	self:SetNWFloat("MaxArmor", self:MaxArmor() + amt);
	
end

function meta:MaxWalkSpeed( )

	return self:GetNWFloat("MaxWalkSpeed");
	
end

function meta:ChangeMaxWalkSpeed( amt )

	self:SetNWFloat("MaxWalkSpeed", self:MaxWalkSpeed() + amt);
	
end

function meta:MaxRunSpeed( )

	return self:GetNWFloat("MaxRunSpeed");
	
end

function meta:ChangeMaxRunSpeed( amt )

	self:SetNWFloat("MaxRunSpeed", self:MaxRunSpeed() + amt);
	
end

function meta:GiveItem( class )

	local inv = RAD.GetCharField( self, "inventory" );
	table.insert( inv, class );
	RAD.SetCharField( self, "inventory", inv);
	self:RefreshInventory( );

end

function meta:TakeItem( class )
	local inv = RAD.GetCharField(self, "inventory" );
	
	for k, v in pairs( inv ) do
		if( v == class ) then
			inv[ k ] = nil;
			RAD.SetCharField( self, "inventory", inv);
			self:RefreshInventory( );
			return;
		end
	end
	
end

function meta:ClearInventory( )
	umsg.Start( "clearinventory", self )
	umsg.End( );
end

function meta:RefreshInventory( )
	self:ClearInventory( )
	
	for k, v in pairs( RAD.GetCharField( self, "inventory" ) ) do

		umsg.Start( "addinventory", self );
			umsg.String( RAD.ItemData[ v ].Name );
			umsg.String( RAD.ItemData[ v ].Class );
			umsg.String( RAD.ItemData[ v ].Description );
			umsg.String( RAD.ItemData[ v ].Model );
		umsg.End( );

	end
end

--[[function meta:RefreshContainer( )

for k,v in pairs( prop.inventory ) do

		umsg.Start( "addinventory", self );
			umsg.String( RAD.ItemData[ v ].Name );
			umsg.String( RAD.ItemData[ v ].Class );
			umsg.String( RAD.ItemData[ v ].Description );
			umsg.String( RAD.ItemData[ v ].Model );
		umsg.End( );
	end
end ]]

function meta:ClearBusiness( )
	umsg.Start( "clearbusiness", self )
	umsg.End( );
end

function meta:RefreshBusiness( )
	self:ClearBusiness( )
		
	if(RAD.Teams[self:Team()] == nil) then return; end -- Team not assigned
	
	for k, v in pairs( RAD.ItemData ) do
	
	if( v.Purchaseable and self:HasItem( "cca_permit" ) and v.ItemGroup == 1 ) then
				umsg.Start( "addbusiness", self );
				umsg.String( v.Name );
				umsg.String( v.Class );
				umsg.String( v.Description );
				umsg.String( v.Model );
				umsg.Long( v.Price );
			umsg.End( );
	 end
	
		if( v.Purchaseable and table.HasValue( RAD.Teams[self:Team()]["item_groups"], v.ItemGroup ) ) then
		
			umsg.Start( "addbusiness", self );
				umsg.String( v.Name );
				umsg.String( v.Class );
				umsg.String( v.Description );
				umsg.String( v.Model );
				umsg.Long( v.Price );
			umsg.End( );
			
		end

	end
end

function meta:ChangeMoney( amount )

RAD.SetCharField( self, "money", RAD.GetCharField( self, "money" ) + amount );
self:SetNWString("money", RAD.GetCharField( self, "money" ) );

end

function meta:SaveWeaponSlots()
	
end

function RAD.MakeDirectoryExist( dir )

	if( not file.Exists( dir ) ) then
		
		file.CreateDir( dir );
	
	end

end

function RAD.IncludeResourcesInFolder( dir )

	local files = file.FindInLua( "Radiationscript/content/" .. dir .. "*" );
	
	for k, v in pairs( files ) do

		if( string.find( v, "vmt" ) or string.find( v, "vtf" ) or string.find( v, "mdl" ) or string.find( v, "wav" ) or string.find( v, "mp3" ) ) then
		
			resource.AddFile( dir .. v );
		
		end
	
	end

end

function RAD.DrugPlayer( pl, mul )

	mul = mul / 10 * 2;

	pl:ConCommand("pp_motionblur 1")
	pl:ConCommand("pp_motionblur_addalpha " .. 0.05 * mul)
	pl:ConCommand("pp_motionblur_delay " .. 0.035 * mul)
	pl:ConCommand("pp_motionblur_drawalpha 1.00")
	pl:ConCommand("pp_dof 1")
	pl:ConCommand("pp_dof_initlength 9")
	pl:ConCommand("pp_dof_spacing 8")

	local IDSteam = string.gsub(pl:SteamID(), ":", "")

	timer.Create(IDSteam, 40 * mul, 1, RAD.UnDrugPlayer, pl)
end

function RAD.UnDrugPlayer(pl)
	pl:ConCommand("pp_motionblur 0")
	pl:ConCommand("pp_dof 0")
end

local function ResetPly(pl)
if(pl:Alive() and pl:IsPlayer()) then
pl:ConCommand("play npc/combine_soldier/zipline_clothing1.wav")
RAD.SetCharField(pl, "suit", " ")
pl:GetTable().HealthRecov = 2
pl:SetColor( 255, 255, 255, 255 )
	pl:GetTable().BurnScale = 1
	pl:GetTable().AcidScale = 1
	pl:GetTable().PsiScale = 1
	pl:GetTable().DmgScale = 1
	pl:GetTable().RadiationScale = 1
pl:SetModel( "models/srpmodels/loner1.mdl" );
RAD.SetCharField(pl, "model", "models/srpmodels/loner1.mdl" );
    end
end

function RAD.DropSuit (pl)
	if( RAD.GetCharField(pl, "suit") != " " ) then
	//RAD.SetCharField(ply, "suit", " ")
        RAD.CreateItem( RAD.GetCharField(pl, "suit"), pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif (pl:GetModel() == "models/srp/bio_suit.mdl") then
        RAD.CreateItem( "suit_seva", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_mili.mdl") then
        RAD.CreateItem( "suit_skat", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood.mdl") then
        RAD.CreateItem( "suit_sunrise", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_monolith.mdl") then
        RAD.CreateItem( "suit_monosuit", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/stalker/monolith.mdl") then
        RAD.CreateItem( "suit_monosuit2", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/bio_mono.mdl") then
        RAD.CreateItem( "suit_monoseva", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/mastermonolith.mdl") then
        RAD.CreateItem( "suit_exoskeleton", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/mastermercenary.mdl") then
        RAD.CreateItem( "suit_mercexo", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_antigas_killer.mdl") then
        RAD.CreateItem( "suit_merc", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/stalker_antigas_killer_fr.mdl") then
        RAD.CreateItem( "suit_french", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/bio_free.mdl") then
        RAD.CreateItem( "suit_freedomseva", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/masterfreedom.mdl") then
        RAD.CreateItem( "suit_freedomexo", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_svob1.mdl") then
        RAD.CreateItem( "suit_freedom4", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/freedom/freedom.mdl") then
        RAD.CreateItem( "suit_freedom3", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/freedom/exofreedom.mdl") then
        RAD.CreateItem( "suit_freedom2", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_svob.mdl") then
        RAD.CreateItem( "suit_freedom1", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/masterstalker.mdl") then
        RAD.CreateItem( "suit_exo", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_ecologist2.mdl") then
        RAD.CreateItem( "suit_eco3", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_ecologist1.mdl") then
        RAD.CreateItem( "suit_eco2", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_ecologist.mdl") then
        RAD.CreateItem( "suit_eco1", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/bio_duty.mdl") then
        RAD.CreateItem( "suit_dutyseva", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/masterduty.mdl") then
        RAD.CreateItem( "suit_dutyexo", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_duty.mdl") then
        RAD.CreateItem( "suit_duty3", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/duty/duty.mdl") then
        RAD.CreateItem( "suit_duty2", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/duty/bullet.mdl") then
        RAD.CreateItem( "suit_duty1", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_antigas_killer3.mdl") then
        RAD.CreateItem( "suit_camomerc", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_bandit_veteran.mdl") then
        RAD.CreateItem( "suit_ban2", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/stalker_bandit_veteran2.mdl") then
        RAD.CreateItem( "suit_ban1", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/masterduty.mdl") then
        RAD.CreateItem( "suit_dutyexo", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/stalker_hood_duty.mdl") then
        RAD.CreateItem( "suit_duty3", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/duty/duty.mdl") then
        RAD.CreateItem( "suit_duty2", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/stalker_bes.mdl") then
        RAD.CreateItem( "suit_stalker", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/bandit1.mdl") then
        RAD.CreateItem( "suit_bandit1", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/bandit2.mdl") then
        RAD.CreateItem( "suit_bandit2", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/bandit3.mdl") then
        RAD.CreateItem( "suit_bandit3", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/bandit4.mdl") then
        RAD.CreateItem( "suit_bandit4", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/rookie1.mdl") then
        RAD.CreateItem( "suit_rookie1", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/rookie2.mdl") then
        RAD.CreateItem( "suit_rookie2", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/rookie3.mdl") then
        RAD.CreateItem( "suit_rookie3", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/rookie4.mdl") then
        RAD.CreateItem( "suit_rookie4", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/rookie5.mdl") then
        RAD.CreateItem( "suit_rookie5", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/rookie6.mdl") then
        RAD.CreateItem( "suit_rookie6", pl:CalcDrop( ), Angle( 0,0,0 ) );
    elseif
       (pl:GetModel() == "models/srp/rookie7.mdl") then
        RAD.CreateItem( "suit_rookie7", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/rookie8.mdl") then
        RAD.CreateItem( "suit_rookie8", pl:CalcDrop( ), Angle( 0,0,0 ) );
	elseif
       (pl:GetModel() == "models/srp/rookie9.mdl") then
        RAD.CreateItem( "suit_rookie9", pl:CalcDrop( ), Angle( 0,0,0 ) );  
	pl:PrintMessage( 3, "Your Not Wearing A Droppable Suit!" );
         end
	ResetPly(pl)
	   end
concommand.Add( "rp_dropsuit", RAD.DropSuit )




function BloodSetInit( pl )
pl:GetTable().BleedAmt = 0
pl.DropBlood = CurTime() + 30
pl:GetTable().HealthRecov = 2
end
hook.Add( "PlayerInitialSpawn", "BloodSetInit", BloodSetInit )



function DroppingBlood()
for k,pl in pairs (player.GetAll()) do
	if CurTime() >= pl.DropBlood then
		pl.DropBlood = CurTime() + 30
		if( pl:Health() <  80 ) then
		pl:SetHealth(pl:Health() + pl:GetTable().HealthRecov)
		end
		pl:SetHealth(pl:Health() - pl:GetTable().BleedAmt)
		
		local Randy = math.random()
		if( Randy == 1) then
			 pl:GetTable().BleedAmt = pl:GetTable().BleedAmt - 1
		end
		// Msg( pl:GetTable().BleedAmt )
		umsg.Start("bleed_info", pl)
			 umsg.Long( pl:GetTable().BleedAmt )
		umsg.End()
		end
		if( 1 > pl:Health() ) then
		if( pl:Alive() ) then
		pl:Kill()
		pl:GetTable().BleedAmt = 0
		end
		end
	 end
end
hook.Add("Think", "DroppingBlood", DroppingBlood)
DNG123 = 0
DNG1234 = 0
function BleedDamage( ply, hitgroup, dmginfo )
end
hook.Add("ScalePlayerDamage","BleedDamage",BleedDamage)

function GM:EntityTakeDamage( ply, inflictor, attacker, amount, dmginfo )
 
	if ply:IsPlayer() then
 
		if( dmginfo:GetDamageType() == 0) then
	 		dmginfo:ScaleDamage( ply:GetTable().RadiationScale )
		elseif( dmginfo:GetDamageType() == 8) then
			dmginfo:ScaleDamage( ply:GetTable().BurnScale )
		elseif( dmginfo:GetDamageType() == 1048576) then
			dmginfo:ScaleDamage( ply:GetTable().AcidScale )
		elseif( dmginfo:GetDamageType() == 256) then
			dmginfo:ScaleDamage( ply:GetTable().ElectricScale )
		elseif( dmginfo:GetDamageType() == 262144) then
			dmginfo:ScaleDamage( ply:GetTable().PsiScale )
		else
	 		dmginfo:ScaleDamage( ply:GetTable().DmgScale )
		end    
		if( dmginfo:GetAttacker():IsPlayer() ) then
		local rand1 = math.random(2)
		if( rand1 == 1) then
			 if ( hitgroup == HITGROUP_HEAD ) then
 
				ply:GetTable().BleedAmt = ply:GetTable().BleedAmt + dmginfo:GetDamage() / 5
	
					if( ply:GetTable().BleedAmt < 1 ) then
						ply:GetTable().BleedAmt = 1
					end
 			else
				ply:GetTable().BleedAmt = ply:GetTable().BleedAmt + dmginfo:GetDamage() / 10
					if( ply:GetTable().BleedAmt < 1 ) then
						ply:GetTable().BleedAmt = 1
					end
	 			end
			end


		end


	end 
 
end