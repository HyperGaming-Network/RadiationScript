-------------------------------
-- RadiationScript
-- Author: SilverKnight
-- Project Start: 5/24/2008
-- hooks.lua
-- A hook system for plugins and other things.
-------------------------------

RAD.Hooks = {  };
RAD.TeamHooks = { };

function RAD.CallTeamHook( hook_name, ply, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 ) -- Holy shit what a hacky method fo sho.
	
	local team = RAD.NilFix(RAD.Teams[ply:Team()], nil);
	if( team == nil ) then

		return; -- Team hasn't even been set yet!
		
	end
	
	-- Look through the Hooks table for any hooks that should be called
	for _, hook in pairs( RAD.TeamHooks ) do
	
		if( hook.hook_name == hook_name and team.flag_key == hook.flag_key) then
			
			local unique = RAD.NilFix(hook.unique_name, "");
			local func = RAD.NilFix(hook.callback, function() end);
			
			--RAD.DayLog( "script.txt", "Running team hook " .. unique );
			
			local override = RAD.NilFix(func( ply, RAD.NilFix(arg1, nil), RAD.NilFix(arg2, nil), RAD.NilFix(arg3, nil), RAD.NilFix(arg4, nil), RAD.NilFix(arg5, nil), RAD.NilFix(arg6, nil), RAD.NilFix(arg7, nil), RAD.NilFix(arg8, nil), RAD.NilFix(arg9, nil), RAD.NilFix(arg10, nil)), 1);
			
			if( override == 0 ) then return 0; end
			
		end
		
	end
	
	return 1;
	
end

function RAD.AddTeamHook( hook_name, unique_name, callback, flagkey )
	
	local hook = {  };
	hook.hook_name = hook_name;
	hook.unique_name = unique_name;
	hook.callback = callback;
	hook.flag_key = flagkey;
	
	table.insert(RAD.TeamHooks, hook);
	
	--RAD.DayLog( "script.txt", "Adding team hook " .. unique_name .. " ( " .. hook_name .. " | " .. flagkey .. " )" );
	
end

-- This is to be called within RAD functions
-- It will basically run through a table of hooks and call those functions if it matches the hook name.
-- If the hook returns a value of 0, it will not call any more hooks.
function RAD.CallHook( hook_name, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 ) -- Holy shit what a hacky method fo sho.
	
	-- Look through the Hooks table for any hooks that should be called
	for _, hook in pairs( RAD.Hooks ) do
	
		if( hook.hook_name == hook_name ) then
			
			local unique = RAD.NilFix(hook.unique_name, "");
			local func = RAD.NilFix(hook.callback, function() end);
			
			--RAD.DayLog( "script.txt", "Running hook " .. unique );
			
			RAD.NilFix(func( RAD.NilFix(arg1, nil), RAD.NilFix(arg2, nil), RAD.NilFix(arg3, nil), RAD.NilFix(arg4, nil), RAD.NilFix(arg5, nil), RAD.NilFix(arg6, nil), RAD.NilFix(arg7, nil), RAD.NilFix(arg8, nil), RAD.NilFix(arg9, nil), RAD.NilFix(arg10, nil)), 1);
			
			if( override == 0 ) then return 0; end
			
		end
		
	end
	
	return 1;
	
end

function RAD.AddHook( hook_name, unique_name, callback )
	
	local hook = {  };
	hook.hook_name = hook_name;
	hook.unique_name = unique_name;
	hook.callback = callback;
	
	table.insert(RAD.Hooks, hook);
	
	--RAD.DayLog( "script.txt", "Adding hook " .. unique_name .. " ( " .. hook_name .. " )" );
	
end
