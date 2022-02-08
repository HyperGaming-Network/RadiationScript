-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- cl_charactercreate.lua
-- Houses some functions for the character creation.
-------------------------------
TeamTable = {};

function SetUpTeam(data)

	local newteam = {}
	newteam.id = data:ReadLong();
	newteam.name = data:ReadString();
	newteam.r = data:ReadLong();
	newteam.g = data:ReadLong();
	newteam.b = data:ReadLong();
	newteam.a = data:ReadLong();
	newteam.public = data:ReadBool();
	newteam.salary = data:ReadLong();
	newteam.flagkey = data:ReadString();
	newteam.business = data:ReadBool();
	
	team.SetUp(newteam.id, newteam.name, Color(newteam.r,newteam.g,newteam.b,newteam.a));
	TeamTable[newteam.id] = newteam;
	
end
usermessage.Hook("setupteam", SetUpTeam);

ChosenModel = "";
ExistingChars = {  }
models = {};

function ReceiveChar( data )

	local n = data:ReadLong( );
	ExistingChars[ n ] = {  }
	ExistingChars[ n ][ 'name' ] = data:ReadString( );
	ExistingChars[ n ][ 'model' ] = data:ReadString( );
	ExistingChars[ n ][ 'flags' ] = data:ReadString( );
	
end
usermessage.Hook( "ReceiveChar", ReceiveChar );
function RemoveChar( data )

	local n = data:ReadLong( );
		ExistingChars[ n ] = ExistingChars[table.getn( ExistingChars)]
		table.remove( ExistingChars,table.getn( ExistingChars))	
end
usermessage.Hook( "RemoveChar", RemoveChar );
local function CharacterCreatePanel( )

	CreatePlayerMenu( )
	PlayerMenu:ShowCloseButton( false )
	PropertySheet:SetActiveTab( PropertySheet.Items[ 2 ].Tab );
	PropertySheet.SetActiveTab = function( ) end;
	
	InitHUDMenu( );
	
end
usermessage.Hook( "charactercreate", CharacterCreatePanel );