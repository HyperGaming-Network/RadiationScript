PLUGIN.Name = "Core Plugin"; -- What is the plugin name
PLUGIN.Author = "SilverKnight"; -- Author of the plugin
PLUGIN.Description = "Configures the gamemode on a deeper level."; -- The description or purpose of the plugin

RAD.AddDataField( 1, "characters", { } );

-- Character Fields
RAD.AddDataField( 2, "name", "Set Your Name" ); -- Let's hope this never gets used.
RAD.AddDataField( 2, "model", "models/srp/bandit1.mdl" );
RAD.AddDataField( 2, "wepitem", "none" );
RAD.AddDataField( 2, "suit", " " );
RAD.AddDataField( 2, "wepitem2", "none" );
RAD.AddDataField( 2, "title", RAD.ConVars[ "Default_Title" ] ); -- What is their default title.
RAD.AddDataField( 2, "money", RAD.ConVars[ "Default_Money" ] ); -- How much money do players start out with.
RAD.AddDataField( 2, "flags", RAD.ConVars[ "Default_Flags" ] ); -- What flags do they start with.
RAD.AddDataField( 2, "inventory", RAD.ConVars[ "Default_Inventory" ] ); -- What inventory do they start with

function GM:PlayerCanPickupWeapon( ply, ent )

	if( ply:GetTable().ForceGive ) then
		return true;
	end

	if( ply:KeyDown( IN_USE ) ) then
	
	local tr = ply:GetEyeTrace();

	if( ValidEntity( tr.Entity ) and tr.Entity:IsWeapon() and tr.Entity:GetPos():Distance( ply:EyePos() ) < 70 and tr.Entity == ent ) then

	ply:GetTable().ForceGive = true
	ply:Give( ent:GetClass() );
    ply:GetTable().ForceGive = false
	
	
	tr.Entity:Remove();
	
	end
	
	end
			
	return false;

end
