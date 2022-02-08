-------------------------------
-- RadiationScript
-- Author: SilverKnight
-------------------------------
RAD.ConVars = {  };

RAD.ConVars[ "DefaultHealth" ] = 500; -- How much health do they start with
RAD.ConVars[ "WalkSpeed" ] = 90; -- How fast do they walk
RAD.ConVars[ "CrouchSpeed" ] = 140; -- How fast do they crouchwalk
RAD.ConVars[ "RunSpeed" ] = 230; -- How fast do they run
RAD.ConVars[ "TalkRange" ] = 300; -- This is the range of talking.
RAD.ConVars[ "SuicideEnabled" ] = "0"; -- Can players compulsively suicide by using kill
RAD.ConVars[ "SalaryEnabled" ] = "1"; -- Is salary enabled
RAD.ConVars[ "SalaryInterval" ] = "60"; -- How often is salary given ( Minutes ) -- This cannot be changed after it has been set
RAD.ConVars[ "MaxWeight" ] = "50"; --Max Weight
RAD.ConVars[ "Default_Gravgun" ] = "0"; -- Are players banned from the gravity gun when they first start.
RAD.ConVars[ "Default_Physgun" ] = "0"; -- Are players banned from the physics gun when they first start.
RAD.ConVars[ "Default_Money" ] = "300"; -- How much money do the characters start out with.
RAD.ConVars[ "Default_Title" ] = "S.T.A.L.K.E.R"; -- What is their title when they create their character.
RAD.ConVars[ "Default_Flags" ] = { "citizen" }; -- What flags can the character select when it is first made. ( This does not include public flags ) This cannot be setconvar'd
RAD.ConVars[ "Default_Inventory" ] = {"pda"  }; -- What inventory do characters start out with when they are first made. This cannot be setconvar'd

Msg( "Gamemode file; configuaration.lua loaded\n" )