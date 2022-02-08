models = {  
	"models/srp/bandit1.mdl",
	"models/srp/bandit2.mdl",
	"models/srp/bandit3.mdl",
	"models/srp/bandit4.mdl",
	"models/srp/rookie1.mdl",
	"models/srp/rookie2.mdl",
	"models/srp/rookie2.mdl",
	"models/srp/rookie3.mdl",
	"models/srp/rookie4.mdl",
	"models/srp/rookie5.mdl",
	"models/srp/rookie6.mdl",
	"models/srp/rookie7.mdl",
	"models/srp/rookie8.mdl"
}

InventoryTable = {}
HasDetector = false
function AddItem(data)
	local itemdata = {}
	itemdata.Name = data:ReadString();
	itemdata.Class = data:ReadString();
	itemdata.Description = data:ReadString();
	itemdata.Model = data:ReadString();
	
	table.insert(InventoryTable, itemdata);
	if( itemdata.Class == artdetector ) then
	HasDetector = True
	end
end
usermessage.Hook("addinventory", AddItem);

function ClearItems()
	
	InventoryTable = {}
	
end
usermessage.Hook("clearinventory", ClearItems);

BusinessTable = {};

function AddBusinessItem(data)
	local itemdata = {}
	itemdata.Name = data:ReadString();
	itemdata.Class = data:ReadString();
	itemdata.Description = data:ReadString();
	itemdata.Model = data:ReadString();
	itemdata.Price = data:ReadLong();
	
	table.insert(BusinessTable, itemdata);
end
usermessage.Hook("addbusiness", AddBusinessItem);

function ClearBusinessItems()
	
	BusinessTable = {}
	
end
usermessage.Hook("clearbusiness", ClearBusinessItems);

function IsCombine( ent )

if( team.GetName( ent:Team() ) == "Dispatch Controller" ) then return true; end

return false;
end

function IsMutant( ent )

if( team.GetName( ent:Team() ) == "Bloodsucker" ) then return true; end
if( team.GetName( ent:Team() ) == "Controller" ) then return true; end

return false;
end

function IsTrader( ent )

if( team.GetName( ent:Team() ) == "Trader" ) then return true; end

return false;
end

function InitHiddenButton()
	HiddenButton = vgui.Create("DButton")
	HiddenButton:SetSize(ScrW(), ScrH());
	HiddenButton:SetText("");
	HiddenButton:SetDrawBackground(false);
	HiddenButton:SetDrawBorder(false);
	HiddenButton.DoRightClick = function()
		local Vect = gui.ScreenToVector(gui.MouseX(), gui.MouseY());
		local tracedata = {};
		tracedata.start = LocalPlayer():GetShootPos();
		tracedata.endpos = LocalPlayer():GetShootPos() + (Vect * 100);
		tracedata.filter = LocalPlayer();
		local trace = util.TraceLine(tracedata);
		
		local ContextMenu = DermaMenu()
		
		if(trace.HitNonWorld) then
			local target = trace.Entity;
			
			if( !LocalPlayer():Alive() ) then return false; end
			if( LocalPlayer():GetNWInt( "tiedup" ) == 1 ) then return false; end
			
				if(RAD.IsDoor(target)) then
					ContextMenu:AddOption("Rent/Unrent Door", function() LocalPlayer():ConCommand("rp_purchasedoor " .. target:EntIndex()) end);
					ContextMenu:AddOption("Lock", function() LocalPlayer():ConCommand("rp_lockdoor " .. target:EntIndex()) end);
					ContextMenu:AddOption("Unlock", function() LocalPlayer():ConCommand("rp_unlockdoor " .. target:EntIndex()) end);
                    ContextMenu:AddOption("Picklock", function() LocalPlayer():ConCommand("rp_picklock " .. target:EntIndex()) end);
				elseif(target:GetClass() == "item_prop") then
					ContextMenu:AddOption("Pick Up", function() LocalPlayer():ConCommand("rp_pickup " .. target:EntIndex()) end); 
					ContextMenu:AddOption("Use", function() LocalPlayer():ConCommand("rp_useitem " .. target:EntIndex()) end);
                elseif(target:GetClass() == "y_helicopter") then
				ContextMenu:AddOption("Hmm...", function() LocalPlayer():ConCommand("say Obviously doesn't belong to me..") end);
				elseif(target:GetClass() == "stalkerradio") then
				ContextMenu:AddOption("Hmm...", function() LocalPlayer():ConCommand("say Maybe Exile will add a function later...") end);
				elseif( target:GetNWBool( "container" ) == true ) then
				//ContextMenu:AddOption("Search", function() LocalPlayer():ConCommand("rp_search " .. target:EntIndex()) end);
				ContextMenu:AddOption("Examine", function() LocalPlayer():ConCommand("say /it It might have something inside it...") end);
				elseif(target:IsPlayer()) then
					local function PopupCredits()
						local CreditPanel = vgui.Create( "DFrame" );
						CreditPanel:SetPos(gui.MouseX(), gui.MouseY());
						CreditPanel:SetSize( 200, 175 )
						CreditPanel:SetTitle( "Give " .. target:Nick() .. " Rubles");
						CreditPanel:SetVisible(true);
						CreditPanel:SetDraggable(true);
						CreditPanel:ShowCloseButton(true);
						CreditPanel:MakePopup();
						
						local Credits = vgui.Create( "DNumSlider", CreditPanel );
						Credits:SetPos( 25, 50 );
						Credits:SetWide(150);
						Credits:SetText("Rubles to Give");
						Credits:SetMin( 0 );
						Credits:SetMax( tonumber(LocalPlayer():GetNWString("money")) );
						Credits:SetDecimals( 0 );
						
						local Give = vgui.Create( "DButton", CreditPanel );
						Give:SetText("Give");
						Give:SetPos( 25, 125 );
						Give:SetSize( 150, 25 );
						Give.DoClick = function()
							LocalPlayer():ConCommand("rp_givemoney " .. target:EntIndex() .. " " .. Credits:GetValue());
							CreditPanel:Remove();
							CreditPanel = nil;
						end
					end
					ContextMenu:AddOption("Give Rubles", PopupCredits);
					ContextMenu:AddOption("Tie Up", function() LocalPlayer():ConCommand("rp_ziptie " .. target:EntIndex()) end);
					ContextMenu:AddOption("Search", function() LocalPlayer():ConCommand("rp_searchplayer " .. target:EntIndex()) end);
					if(target:GetNWInt("tiedup") == 1) then
					ContextMenu:AddOption("Untie", function() LocalPlayer():ConCommand("rp_ziptie " .. target:EntIndex()) end);
					end

					end
				end
				
			ContextMenu:Open();
		end	
end

function CreateModelWindow()

	if(ModelWindow) then
	
		ModelWindow:Remove();
		ModelWindow = nil;
		
	end

	ModelWindow = vgui.Create( "DFrame" )
	ModelWindow:SetTitle("Base Clothing");

	local mdlPanel = vgui.Create( "DModelPanel", ModelWindow )
	mdlPanel:SetSize( 300, 300 )
	mdlPanel:SetPos( 10, 20 )
	mdlPanel:SetModel( models[1] )
	mdlPanel:SetAnimSpeed( 0.0 )
	mdlPanel:SetAnimated( false )
	mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel:SetFOV( 70 )

	local RotateSlider = vgui.Create("DNumSlider", ModelWindow);
	RotateSlider:SetMax(360);
	RotateSlider:SetMin(0);
	RotateSlider:SetText("Rotate");
	RotateSlider:SetDecimals( 0 );
	RotateSlider:SetWidth(300);
	RotateSlider:SetPos(10, 290);

	local BodyButton = vgui.Create("DButton", ModelWindow);
	BodyButton:SetText("Body");
	BodyButton.DoClick = function()

		mdlPanel:SetCamPos( Vector( 50, 0, 50) );
		mdlPanel:SetLookAt( Vector( 0, 0, 50) );
		mdlPanel:SetFOV( 70 );
		
	end
	BodyButton:SetPos(10, 40);

	local FaceButton = vgui.Create("DButton", ModelWindow);
	FaceButton:SetText("Face");
	FaceButton.DoClick = function()

		mdlPanel:SetCamPos( Vector( 50, 0, 60) );
		mdlPanel:SetLookAt( Vector( 0, 0, 60) );
		mdlPanel:SetFOV( 40 );
		
	end
	FaceButton:SetPos(10, 60);

	local FarButton = vgui.Create("DButton", ModelWindow);
	FarButton:SetText("Far");
	FarButton.DoClick = function()

		mdlPanel:SetCamPos( Vector( 100, 0, 30) );
		mdlPanel:SetLookAt( Vector( 0, 0, 30) );
		mdlPanel:SetFOV( 70 );
		
	end
	FarButton:SetPos(10, 80);
	
	local OkButton = vgui.Create("DButton", ModelWindow);
	OkButton:SetText("OK");
	OkButton.DoClick = function()

		 LocalPlayer():ConCommand("rp_mymodel " .. tostring(mdlPanel.Entity:GetModel()))  

		ModelWindow:Remove();
		ModelWindow = nil;
		
	end
	OkButton:SetPos(10, 100);

	function mdlPanel:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, RotateSlider:GetValue(), 0) )
		
	end

	local i = 1;
	
	local LastMdl = vgui.Create( "DSysButton", ModelWindow )
	LastMdl:SetType("left");
	LastMdl.DoClick = function()

		i = i - 1;
		
		if(i == 0) then
			i = #models;
		end
		
		mdlPanel:SetModel(models[i]);
		
	end

	LastMdl:SetPos(10, 165);

	local NextMdl = vgui.Create( "DSysButton", ModelWindow )
	NextMdl:SetType("right");
	NextMdl.DoClick = function()

		i = i + 1;

		if(i > #models) then
			i = 1;
		end
		
		mdlPanel:SetModel(models[i]);

	end
	NextMdl:SetPos( 245, 165);
	ModelWindow:SetSize( 320, 330 )
	ModelWindow:Center()	
	ModelWindow:MakePopup()
	ModelWindow:SetKeyboardInputEnabled( false )
	
end

function InitHUDMenu()

	InitHiddenButton();

	HUDMenu = vgui.Create( "HudPanel" )
	HUDMenu:SetPos( ScrW() - 130 - 5, 5 )
	HUDMenu:SetSize( 130, 150 )
	HUDMenu:SetTitle( "Identification Card" )
	HUDMenu:SetVisible( false )
	HUDMenu:SetDraggable( false )
	HUDMenu:ShowCloseButton( false )

	local label = vgui.Create("DLabel", HUDMenu);
	label:SetWide(0);
	label:SetPos(5, 25);
	label:SetText("Name: " .. LocalPlayer():Nick());

	local label2 = vgui.Create("DLabel", HUDMenu);
	label2:SetWide(0);
	label2:SetPos(5, 40);
	label2:SetText("Title: " .. LocalPlayer():GetNWString("title"));
	
	local label3 = vgui.Create("DLabel", HUDMenu);
	label3:SetWide(0);
	label3:SetPos(5, 55);
	label3:SetText("Faction: " .. team.GetName(LocalPlayer():Team()));
	
	local label4 = vgui.Create("DLabel", HUDMenu);
	label4:SetWide(0);
	label4:SetPos(5, 70);
	label4:SetText(LocalPlayer():GetNWString("money") .. " Rubles");

		local spawnicon = vgui.Create( "DModelPanel", HUDMenu )
		spawnicon:SetModel( LocalPlayer():GetModel() )
		spawnicon:SetPos( 1, 21 )
		spawnicon:SetSize( 128, 128 )
		spawnicon:SetFOV( 70 )
		spawnicon:SetToolTip(LocalPlayer():Nick());

	
	    function spawnicon:LayoutEntity(Entity)

		spawnicon:RunAnimation()
	    spawnicon:SetModel(LocalPlayer():GetModel())

	    end

		
	local FadeSize = 320;
	
	function UpdateGUIData()
		label:SetText("Name: " .. LocalPlayer():Nick());

		label2:SetText("Title: " .. LocalPlayer():GetNWString("title"));
		
		label3:SetText("Faction: " .. team.GetName(LocalPlayer():Team()));
		
		label4:SetText(LocalPlayer():GetNWString("money") .. " Dollars")

		spawnicon:SetModel( LocalPlayer():GetModel() );
		spawnicon:SetToolTip( LocalPlayer():Nick() );
	end
	
	spawnicon.OnCursorEntered = function ()
	
		spawnicon:SetPos(FadeSize - 129, 21);
		HUDMenu:SetSize(FadeSize, 150);
		HUDMenu:SetPos(ScrW() - FadeSize - 5, 5 );
		
		label:SetWide(FadeSize - 128);
		label2:SetWide(FadeSize - 128);
		label3:SetWide(FadeSize - 128);
		label4:SetWide(FadeSize - 128);
		
		UpdateGUIData();
	end
	
	spawnicon.OnCursorExited = function ()
	
		spawnicon:SetPos(125 - 129, 21);
		HUDMenu:SetSize(125, 150);
		HUDMenu:SetPos(ScrW() - 125 - 5, 5 );
		
		label:SetWide(125 - 128);
		label2:SetWide(125 - 128);
		label3:SetWide(125 - 128);
		label4:SetWide(125 - 128);
	
		UpdateGUIData();
	end

end

function CreatePlayerMenu()
	if(PlayerMenu) then
		PlayerMenu:Remove();
		PlayerMenu = nil;
	end
	
	PlayerMenu = vgui.Create( "InvisiblePanel" )
	PlayerMenu:SetPos( ScrW() / 2 - 320, ScrH() / 2 - 240 )
	PlayerMenu:SetSize( 640, 480 )
	PlayerMenu:SetTitle( "Player Control Panel" )
	PlayerMenu:SetVisible( true )
	PlayerMenu:SetDraggable( false )
	PlayerMenu:ShowCloseButton( true )
	PlayerMenu:SetBackgroundBlur( true );
	PlayerMenu:MakePopup()
	
	
local CloseFunction = PlayerMenu.btnClose.DoClick
PlayerMenu.btnClose.DoClick = function()
    CloseFunction()
    PlayerMenu = nil
end
	
	PropertySheet = vgui.Create( "DPropertySheet" )
	PropertySheet:SetParent(PlayerMenu)
	PropertySheet:SetPos( 2, 30 )
	PropertySheet:SetSize( 636, 448 )
	
	local PlayerInfo = vgui.Create( "DPanelList" )
	PlayerInfo:SetPadding(20);
	PlayerInfo:SetSpacing(20);
	PlayerInfo:EnableHorizontal(false);
	
	local icdata = vgui.Create( "DForm" );
	icdata:SetPadding(4);
	icdata:SetName(LocalPlayer():Nick() or "");
	
	local FullData = vgui.Create("DPanelList");
	FullData:SetSize(0, 84);
	FullData:SetPadding(10);
	
	local DataList = vgui.Create("DPanelList");
	DataList:SetSize(0, 64);
	
	local spawnicon = vgui.Create( "SpawnIcon");
	spawnicon:SetModel(LocalPlayer():GetModel());
	spawnicon:SetSize( 64, 64 );
	DataList:AddItem(spawnicon);
	
	
	
	local DataList2 = vgui.Create( "DPanelList" )
	
	local label2 = vgui.Create("DLabel");
	label2:SetText("Title: " .. LocalPlayer():GetNWString("title"));
	DataList2:AddItem(label2);
	
	local label3 = vgui.Create("DLabel");
	label3:SetText("Class: " .. team.GetName(LocalPlayer():Team()));
	DataList2:AddItem(label3);

	local Divider = vgui.Create("DHorizontalDivider");
	Divider:SetLeft(spawnicon);
	Divider:SetRight(DataList2);
	Divider:SetLeftWidth(64);
	Divider:SetHeight(64);
	
	DataList:AddItem(spawnicon);
	DataList:AddItem(DataList2);
	DataList:AddItem(Divider);

	FullData:AddItem(DataList)
	
	icdata:AddItem(FullData)
	
	local vitals = vgui.Create( "DForm" );
	vitals:SetPadding(4);
	vitals:SetName("Vital Signs");
	
	local VitalData = vgui.Create("DPanelList");
	VitalData:SetAutoSize(true)
	VitalData:SetPadding(10);
	vitals:AddItem(VitalData);
	
	local healthstatus = ""
	local hp = LocalPlayer():Health();
	
	if(!LocalPlayer():Alive()) then healthstatus = "Dead";
	elseif(hp > 95) then healthstatus = "Healthy";
	elseif(hp > 50 and hp < 95) then healthstatus = "OK";
	elseif(hp > 30 and hp < 50) then healthstatus = "Near Death";
	elseif(hp > 1 and hp < 30) then healthstatus = "Death Imminent"; end
	
	local health = vgui.Create("DLabel");
	health:SetText("Vitals: " .. healthstatus);
	VitalData:AddItem(health);
	
	PlayerInfo:AddItem(icdata)
	PlayerInfo:AddItem(vitals)
	
	CharPanel = vgui.Create( "DPanelList" )
	CharPanel:SetPadding(20);
	CharPanel:SetSpacing(20);
	CharPanel:EnableHorizontal(false);
	
	local newcharform = vgui.Create( "DForm" );
	newcharform:SetPadding(4);
	newcharform:SetName("New Character");
	newcharform:SetAutoSize(true);
	
	local CharMenu = vgui.Create( "DPanelList" )
	newcharform:AddItem(CharMenu);
	CharMenu:SetSize( 316, 386 )
	CharMenu:SetPadding(10);
	CharMenu:SetSpacing(20);
	CharMenu:EnableVerticalScrollbar();
	CharMenu:EnableHorizontal(false);

	local label = vgui.Create("DLabel");
	CharMenu:AddItem(label);
	label:SetSize(400, 25);
	label:SetPos(5, 25);
	label:SetText("S.T.A.L.K.E.R. Roleplay");
	label:SetFont("MelonMedium");
	
	local labelz = vgui.Create("DLabel");
	CharMenu:AddItem(labelz);
	labelz:SetSize(400, 25);
	labelz:SetPos(5, 30);
	labelz:SetText("www.HyperGamer.Net");
	labelz:SetFont("MelonMedium");

	local info = vgui.Create( "DForm" );
	info:SetName("Personal Information");
	CharMenu:AddItem(info);

	local label = vgui.Create("DLabel");
	info:AddItem(label);
	label:SetSize(30,25);
	label:SetPos(150, 50);
	label:SetText("First: ");

	local firstname = vgui.Create("DTextEntry");
	info:AddItem(firstname);
	firstname:SetSize(100,25);
	firstname:SetPos(185, 50);
	firstname:SetText("");

	local label = vgui.Create("DLabel");
	info:AddItem(label);
	label:SetSize(30,25);
	label:SetPos(5, 50);
	label:SetText("Last: ");

	local lastname = vgui.Create("DTextEntry");
	info:AddItem(lastname);
	lastname:SetSize(100,25);
	lastname:SetPos(40, 50);
	lastname:SetText("");

	local label = vgui.Create("DLabel");
	info:AddItem(label);
	label:SetSize(100,25);
	label:SetPos(5, 80);
	label:SetText("Title: ");

	local title = vgui.Create("DTextEntry");
	info:AddItem(title);
	title:SetSize(205, 25);
	title:SetPos(80, 80);
	title:SetText("Loner");

	local spawnicon = nil;

	local modelform = vgui.Create( "DForm" );
	modelform:SetPadding(4);
	modelform:SetName("Appearance");
	CharMenu:AddItem(modelform);

	local OpenButton = vgui.Create( "DButton" );
	OpenButton:SetText("Clothing");
	OpenButton.DoClick = CreateModelWindow;
	modelform:AddItem(OpenButton);

	local apply = vgui.Create("DButton");
	apply:SetSize(100, 25);
	apply:SetText("Apply");
	apply.DoClick = function ( btn )

		if(firstname:GetValue() == "" or lastname:GetValue() == "") then
			LocalPlayer():PrintMessage(3, "You must enter a first and last name!");
			return;
		end
		
		LocalPlayer():ConCommand("rp_startcreate");
		LocalPlayer():ConCommand("rp_setmodel \"" .. ChosenModel .. "\"");
		LocalPlayer():ConCommand("rp_changename \"" .. firstname:GetValue() .. " " .. lastname:GetValue() .. "\"");
		LocalPlayer():ConCommand("rp_title \"" .. string.sub(title:GetValue(), 1, 32) .. "\"");
		LocalPlayer().MyModel = ""
		LocalPlayer():ConCommand("rp_finishcreate");
		
		PlayerMenu:Remove();
		PlayerMenu = nil;
		
	end
	CharMenu:AddItem(apply);

	local selectcharform = vgui.Create( "DForm" );
	selectcharform:SetPadding(4);
	selectcharform:SetName("Select Character");
	selectcharform:SetSize(316, 386);

	local charlist = vgui.Create( "DPanelList" );
	
	charlist:SetSize( 316, 386 )
	charlist:SetPadding(10);
	charlist:SetSpacing(20);
	charlist:EnableVerticalScrollbar();
	charlist:EnableHorizontal(true);

	
	local n = 1;
	if(ExistingChars[n] != nil) then

		mdlPanel = vgui.Create( "DModelPanel" )
		mdlPanel:SetSize( 280, 280 )
		mdlPanel:SetModel( ExistingChars[n]['model'] )
		mdlPanel:SetAnimSpeed( 0.0 )
		mdlPanel:SetAnimated( false )
		mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
		mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
		mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
		mdlPanel:SetCamPos( Vector( 100, 0, 40 ) )
		mdlPanel:SetLookAt( Vector( 0, 0, 40 ) )
		mdlPanel:SetFOV( 70 )
		surface.CreateFont("stalker2",10,25,false,false,"stalkersmaller")
            surface.CreateFont("stalker2",12,25,false,false,"stalkersmall")
            surface.CreateFont("stalker2",20,100,false,false,"stalkerlarge")
            surface.CreateFont("stalker2",40,100,false,false,"stalker3")
            surface.CreateFont("stalker2",25,400,false,false,"stalker")
			surface.SetTextColor(Color(255,255,255,255));
			surface.SetFont("stalkersmall");
			surface.SetTextPos((280 - surface.GetTextSize(ExistingChars[n]['name'])) / 2, 260);
			surface.DrawText(ExistingChars[n]['name'])
		
		function mdlPanel:OnMousePressed()
		
			LocalPlayer():ConCommand("rp_selectchar " .. n);
			LocalPlayer().MyModel = ""
			PlayerMenu:Remove();
			PlayerMenu = nil;

			
		end

		function mdlPanel:LayoutEntity(Entity)

			self:RunAnimation();
			
		end
		
		function InitAnim()
		
			if(mdlPanel.Entity) then
			
				local iSeq = mdlPanel.Entity:LookupSequence( "idle_angry" );
				mdlPanel.Entity:ResetSequence(iSeq);
			
			end
			
		end
		
		InitAnim()
		charlist:AddItem(mdlPanel);
/*
					local DelButton = vgui.Create( "DButton" );
	DelButton:SetText("Delete Character");
	//DelButton:SetSize( 40, 30);


	DelButton.DoClick = function ()
	LocalPlayer():ConCommand("dev_DelCharNum " .. n);
			LocalPlayer().MyModel = ""
			PlayerMenu:Remove();
			PlayerMenu = nil;	
	end
		DelButton:SetParent(charlist);
		DelButton:SetPos( 200, 200);
	
		*/
	// end 
	end
	
	local chars = vgui.Create("DListView");
	chars:SetSize(250, 100);
	chars:SetMultiSelect(false)
	chars:AddColumn("Character Name");
	
	function chars:DoDoubleClick(LineID, Line)
	
	/*	n = LineID;
		if( ExistingChars[n] ) then
		mdlPanel:SetModel(ExistingChars[n]['model']);
		InitAnim();
		else
		for i = n, 10 do
		if( ExistingChars[i] ) then
		n = i
		mdlPanel:SetModel(ExistingChars[n]['model']);
		InitAnim();
		break;
		end
		end
		end */
		n = LineID;
		mdlPanel:SetModel(ExistingChars[n]['model']);
		InitAnim();
	end
	//for i=1,10 do
	//	chars:AddLine(" ");
	//end
	
	for k, v in pairs(ExistingChars) do
	
		chars:AddLine(v['name']);
		//local line = chars:GetLine(k)
		//line:SetValue(1,v['name'])
	end
	
	selectcharform:AddItem(chars);
	selectcharform:AddItem(charlist)
	
	
	local divider = vgui.Create("DHorizontalDivider");
	divider:SetLeft(newcharform);
	divider:SetRight(selectcharform);
	divider:SetLeftWidth(316); 

	CharPanel:AddItem(newcharform);
	CharPanel:AddItem(selectcharform);
	CharPanel:AddItem(divider);
	
	--------------------
	-- Class menu
	--------------------
	
	local divider = vgui.Create("DHorizontalDivider");
	divider:SetLeft(newcharform);
	divider:SetRight(selectcharform);
	divider:SetLeftWidth(316); 

	CharPanel:AddItem(newcharform);
	CharPanel:AddItem(selectcharform);
	CharPanel:AddItem(divider);
	
	Commands = vgui.Create( "DPanelList" )
	Commands:SetPadding(20);
	Commands:SetSpacing(20);
	Commands:EnableHorizontal(true);
	Commands:EnableVerticalScrollbar(true);

	local mdlPanel118 = vgui.Create( "DModelPanel" )
	mdlPanel118:SetSize( 180, 180 )
	mdlPanel118:SetModel( "models/srp/specnaz.mdl" )
	mdlPanel118:SetAnimSpeed( 0.0 )
	mdlPanel118:SetAnimated( false )
	mdlPanel118:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel118:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel118:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel118:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel118:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel118:SetFOV( 70 )
	mdlPanel118:SetToolTip("DUTY/Freedom/Military/Monolith");
	function mdlPanel118:OnMousePressed()
		     local MenuButtonOptions = DermaMenu() // Creates the menu 
     MenuButtonOptions:AddOption("DUTYIER", function() 		  LocalPlayer():ConCommand("rp_flag duty"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions:AddOption("DUTY Officer", function() 	LocalPlayer():ConCommand("rp_flag dutyofficer"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions:AddOption("DUTY Leader", function() 	LocalPlayer():ConCommand("rp_flag dutyleader"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions:AddOption("Freedomer", function() 	LocalPlayer():ConCommand("rp_flag freedom"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end )
	 MenuButtonOptions:AddOption("Freedom Officer", function() 	LocalPlayer():ConCommand("rp_flag freedomofficer"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions:AddOption("Freedom Leader", function() 	LocalPlayer():ConCommand("rp_flag freedomleader"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions:AddOption("Military", function() 	LocalPlayer():ConCommand("rp_flag military"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions:AddOption("Military Officer", function() 	LocalPlayer():ConCommand("rp_flag militaryofficer"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions:AddOption("Military Leader", function() 	LocalPlayer():ConCommand("rp_flag militaryleader"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions:AddOption("Monolith", function() 	LocalPlayer():ConCommand("rp_flag mono"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions:AddOption("Monolith Officer", function() 	LocalPlayer():ConCommand("rp_flag monoofficer"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions:AddOption("Monolith Leader", function() 	LocalPlayer():ConCommand("rp_flag monoleader"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 

     MenuButtonOptions:Open() // Open the menu AFTER adding your options 
		
		UpdateGUIData();
	end
    Commands:AddItem(mdlPanel118);
	
	function mdlPanel118:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )
	
	end

	local mdlPanel400 = vgui.Create( "DModelPanel" )
	mdlPanel400:SetSize( 180, 180 )
	mdlPanel400:SetModel( "models/stalker/bandit.mdl" )
	mdlPanel400:SetAnimSpeed( 0.0 )
	mdlPanel400:SetAnimated( false )
	mdlPanel400:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel400:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel400:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel400:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel400:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel400:SetFOV( 70 )
	mdlPanel400:SetToolTip("Bandits");
	function mdlPanel400:OnMousePressed()
		     local MenuButtonOptions2 = DermaMenu() // Creates the menu 
     MenuButtonOptions2:AddOption("Experienced Bandit", function() 	LocalPlayer():ConCommand("rp_flag ebandit"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions2:AddOption("Veteran Bandit", function() 	LocalPlayer():ConCommand("rp_flag vbandit"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions2:AddOption("Master Bandit", function() 	LocalPlayer():ConCommand("rp_flag mbandit"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
    
     MenuButtonOptions2:Open() // Open the menu AFTER adding your options 
		
		UpdateGUIData();
	end
    Commands:AddItem(mdlPanel400);
	
	function mdlPanel400:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )
		
	end

	local mdlPanel40 = vgui.Create( "DModelPanel" )
	mdlPanel40:SetSize( 180, 180 )
	mdlPanel40:SetModel( "models/srp/stalker_antigas_killer.mdl" )
	mdlPanel40:SetAnimSpeed( 0.0 )
	mdlPanel40:SetAnimated( false )
	mdlPanel40:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel40:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel40:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel40:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel40:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel40:SetFOV( 70 )
	mdlPanel40:SetToolTip("Mercs");
	function mdlPanel40:OnMousePressed()
			     local MenuButtonOptions3 = DermaMenu() // Creates the menu 
     MenuButtonOptions3:AddOption("Military Merc", function() 	LocalPlayer():ConCommand("rp_flag militarymerc"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions3:AddOption("Experienced Merc", function() 	LocalPlayer():ConCommand("rp_flag emerc"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions3:AddOption("Veteran Merc", function() 	LocalPlayer():ConCommand("rp_flag vmerc"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions3:AddOption("Master Merc", function() 	LocalPlayer():ConCommand("rp_flag mmerc"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions3:Open() // Open the menu AFTER adding your options 
		UpdateGUIData();
	end
    Commands:AddItem(mdlPanel40);
	
	function mdlPanel40:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )

	end
		
					local mdlPanel4011 = vgui.Create( "DModelPanel" )
	mdlPanel4011:SetSize( 180, 180 )
	mdlPanel4011:SetModel( "models/srp/scientist.mdl" )
	mdlPanel4011:SetAnimSpeed( 0.0 )
	mdlPanel4011:SetAnimated( false )
	mdlPanel4011:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel4011:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel4011:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel4011:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel4011:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel4011:SetFOV( 70 )
	mdlPanel4011:SetToolTip("Ecologists");
	function mdlPanel4011:OnMousePressed()
			     local MenuButtonOptions5 = DermaMenu() // Creates the menu 
     MenuButtonOptions5:AddOption("Ecologist Team Leader", function() 	LocalPlayer():ConCommand("rp_flag ecoleader"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions5:AddOption("Ecologist", function() 	LocalPlayer():ConCommand("rp_flag eco"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions5:AddOption("Scientist", function() 	LocalPlayer():ConCommand("rp_flag sci"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions5:Open() // Open the menu AFTER adding your options 
		UpdateGUIData();
	end
    Commands:AddItem(mdlPanel4011);
	
	function mdlPanel4011:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )

	end
		

	local mdlPanel40121 = vgui.Create( "DModelPanel" )
	mdlPanel40121:SetSize( 180, 180 )
	mdlPanel40121:SetModel( "models/srp/blood_sucker.mdl" )
	mdlPanel40121:SetAnimSpeed( 0.0 )
	mdlPanel40121:SetAnimated( false )
	mdlPanel40121:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel40121:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel40121:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel40121:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel40121:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel40121:SetFOV( 70 )
	mdlPanel40121:SetToolTip("Monsters");
	function mdlPanel40121:OnMousePressed()
			     local MenuButtonOptions7 = DermaMenu() // Creates the menu 
     MenuButtonOptions7:AddOption("Zombified Stalker", function() 	LocalPlayer():ConCommand("rp_flag zombst"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions7:AddOption("Bloodsucker", function() 	LocalPlayer():ConCommand("rp_flag blood"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions7:AddOption("Bloodsucker Variant", function() 	LocalPlayer():ConCommand("rp_flag blood2"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
	 MenuButtonOptions7:AddOption("snork", function() 	LocalPlayer():ConCommand("rp_flag snork"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions7:AddOption("Controller", function() 	LocalPlayer():ConCommand("rp_flag controller"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end )
     MenuButtonOptions7:AddOption("Abyss", function() 	LocalPlayer():ConCommand("rp_flag abyss"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 	 
     MenuButtonOptions7:Open() // Open the menu AFTER adding your options 
		UpdateGUIData();
	end
    Commands:AddItem(mdlPanel40121);
	
	function mdlPanel40121:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )

	end

			local mdlPanel40111 = vgui.Create( "DModelPanel" )
	mdlPanel40111:SetSize( 180, 180 )
	mdlPanel40111:SetModel( "models/srp/bandit1.mdl" )
	mdlPanel40111:SetAnimSpeed( 0.0 )
	mdlPanel40111:SetAnimated( false )
	mdlPanel40111:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel40111:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel40111:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel40111:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel40111:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel40111:SetFOV( 70 )
	mdlPanel40111:SetToolTip("Misc Factions");
	function mdlPanel40111:OnMousePressed()
			     local MenuButtonOptions6 = DermaMenu() // Creates the menu 
     MenuButtonOptions6:AddOption("Veteran Loner", function() 	LocalPlayer():ConCommand("rp_flag vloner"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions6:AddOption("Experienced Stalker", function() 	LocalPlayer():ConCommand("rp_flag estalker"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions6:AddOption("Veteran Stalker", function() 	LocalPlayer():ConCommand("rp_flag vstalker"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 
     MenuButtonOptions6:AddOption("Loner", function() 	LocalPlayer():ConCommand("rp_flag loner"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end )
     MenuButtonOptions6:AddOption("Trader", function() 	LocalPlayer():ConCommand("rp_flag trader"); PlayerMenu:Remove(); PlayerMenu = nil; UpdateGUIData(); end ) 	 
     MenuButtonOptions6:Open() // Open the menu AFTER adding your options 
		UpdateGUIData();
	end
    Commands:AddItem(mdlPanel40111);
	
	function mdlPanel40111:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )

	end
	
	--------------------
	-- Inventory menu
	--------------------
	
	Inventory = vgui.Create( "DPanelList" )
	Inventory:SetPadding(20);
	Inventory:SetSpacing(20);
	Inventory:EnableHorizontal(true);
	Inventory:EnableVerticalScrollbar(true);
	
	for k, v in pairs(InventoryTable) do

	local spawnicon = vgui.Create( "DModelPanel" )
	spawnicon:SetSize( 128, 128 );
	spawnicon:SetModel( v.Model )
	spawnicon:SetAnimSpeed( 0.0 )
	spawnicon:SetAnimated( false )
	spawnicon:SetAmbientLight( Color( 50, 50, 50 ) )
	spawnicon:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	spawnicon:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	spawnicon:SetCamPos( Vector( 0, 0, 40 ) )
	spawnicon:SetLookAt( Vector( 0, 0, 40 ) )
	spawnicon:SetFOV( 70 )
	spawnicon:SetToolTip(v.Description)
		
		local function DeleteMyself()
			spawnicon:Remove()
			PlayerMenu:Remove();
			PlayerMenu = nil;
		end
		
		spawnicon.DoClick = function ( btn )
		if( LocalPlayer():GetNWInt( "tiedup" ) == 1 ) then return false; end
			local ContextMenu = DermaMenu()
			ContextMenu:AddOption("Use", function() LocalPlayer():ConCommand("rp_useinvitem " .. v.Class) surface.PlaySound( "/hgn/stalker/pda/inv_use.mp3" ); DeleteMyself(); end);
			ContextMenu:AddOption("Drop", function() LocalPlayer():ConCommand("rp_dropitem ".. v.Class) surface.PlaySound( "/hgn/stalker/pda/inv_drop.mp3" ); DeleteMyself(); end);
			if(team.GetName(LocalPlayer():Team()) == "Trader") then ContextMenu:AddOption("Sell", function() LocalPlayer():ConCommand("rp_sellitem ".. v.Class); DeleteMyself(); end);
			end
			ContextMenu:Open();
		end
		
		spawnicon.PaintOver = function()
			surface.SetTextColor(Color(255,255,255,255));
			surface.SetFont("DefaultSmall");
			surface.SetTextPos(64 - surface.GetTextSize(v.Name) / 2, 5);
			surface.DrawText(v.Name)
		end
		
		spawnicon.PaintOverHovered = function()
			surface.SetTextColor(Color(255,255,255,255));
			surface.SetFont("DefaultSmall");
			surface.SetTextPos(64 - surface.GetTextSize(v.Name) / 2, 5);
			surface.DrawText(v.Name)
		end
		
		spawnicon.LayoutEntity = function( self, ent )
		
			ent:SetAngles( Angle( 0, 90, 100 ) );
		
		end

		Inventory:AddItem(spawnicon);
	end
	
	--------------------
	-- Business menu
	--------------------
	
	Business = vgui.Create( "DPanelList" )
	Business:SetPadding(20);
	Business:SetSpacing(20);
	Business:EnableHorizontal(true);
	Business:EnableVerticalScrollbar(true);
	if(TeamTable[LocalPlayer():Team()] != nil) then
		if(TeamTable[LocalPlayer():Team()].business) then
			for k, v in pairs(BusinessTable) do

	local spawnicon = vgui.Create( "DModelPanel" )
	spawnicon:SetSize( 128, 128 );
	spawnicon:SetModel( v.Model )
	spawnicon:SetAnimSpeed( 0.0 )
	spawnicon:SetAnimated( false )
	spawnicon:SetAmbientLight( Color( 50, 50, 50 ) )
	spawnicon:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	spawnicon:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	spawnicon:SetCamPos( Vector( 0, 0, 40 ) )
	spawnicon:SetLookAt( Vector( 0, 0, 40 ) )
	spawnicon:SetFOV( 70 )
	spawnicon:SetToolTip(v.Description .. "  " .. v.Price .. "RU")
				
				spawnicon.DoClick = function ( btn )
				
					local ContextMenu = DermaMenu()
						if(tonumber(LocalPlayer():GetNWString("money")) >= v.Price) then
							ContextMenu:AddOption("Purchase", function() LocalPlayer():ConCommand("rp_buyitem " .. v.Class); end);
						else
							ContextMenu:AddOption("Not enough money!");
						end
					ContextMenu:Open();
					
				end
				
				spawnicon.PaintOver = function()
					surface.SetTextColor(Color(255,255,255,255));
					surface.SetFont("DefaultSmall");
					surface.SetTextPos(64 - surface.GetTextSize(v.Name ) / 2, 5);
					surface.DrawText(v.Name .. " (RU" .. v.Price .. ")")
				end
				
				spawnicon.PaintOverHovered = function()
					surface.SetTextColor(Color(255,255,255,255));
					surface.SetFont("DefaultSmall");
					surface.SetTextPos(64 - surface.GetTextSize(v.Name ) / 2, 5);
					surface.DrawText(v.Name )
				end
				
		spawnicon.LayoutEntity = function( self, ent )
		
			ent:SetAngles( Angle( 0, 90, 100 ) );
		
		end
				
				Business:AddItem(spawnicon);
			end
		elseif(!TeamTable[LocalPlayer():Team()].business) then
			local label = vgui.Create("DLabel")
			label:SetText("You do not have access to this tab!");
			label:SetWide(400);
			
			Business:AddItem(label);
		end
	end
	--------------------
	-- Scoreboard
	--------------------
	Scoreboard = vgui.Create( "DPanelList" )
	Scoreboard:EnableVerticalScrollbar(true);
	Scoreboard:SetPadding(0);
	Scoreboard:SetSpacing(0);
	
	for k, v in pairs(player.GetAll()) do
		local DataList = vgui.Create("DPanelList");
		DataList:SetAutoSize( false )
        DataList:SetSize( 200, 80 )
		
		local CollapsableCategory = vgui.Create("DCollapsibleCategory");
		CollapsableCategory:SetExpanded( 1 )
		CollapsableCategory:SetLabel( v:Nick() );
		Scoreboard:AddItem(CollapsableCategory);

		local spawnicon = vgui.Create( "SpawnIcon");
		spawnicon:SetModel(v:GetModel());
		spawnicon:SetSize( 64, 64 );
		DataList:AddItem(spawnicon);
		
		local DataList2 = vgui.Create( "DPanelList" )
		DataList2:SetAutoSize( true )
		
		local label = vgui.Create("DLabel");
		label:SetText("OOC Name: " .. v:Name());
		DataList2:AddItem(label);
		
		local label2 = vgui.Create("DLabel");
		label2:SetText("Title: " .. v:GetNWString("title"));
		DataList2:AddItem(label2);

		local label3 = vgui.Create("DLabel");
		label3:SetText("Ping: " .. v:Ping());
		DataList2:AddItem(label3);
		
		local Divider = vgui.Create("DHorizontalDivider");
		Divider:SetLeft(spawnicon);
		Divider:SetRight(DataList2);
		Divider:SetLeftWidth(64);
		Divider:SetHeight(64);
		
		DataList:AddItem(spawnicon);
		DataList:AddItem(DataList2);
		DataList:AddItem(Divider);
		
		CollapsableCategory:SetContents(DataList);
	end
	
	local Help = vgui.Create( "DPanelList" )
	Help:SetPadding(20);
	Help:EnableHorizontal(false);
	Help:EnableVerticalScrollbar(true);
	
	local function AddHelpLine(text)
			local label = vgui.Create("DLabel");
			label:SetText(text);
			label:SizeToContents();
			Help:AddItem(label);
	end
	
	local lines = {
	"Welcome to S.T.A.L.K.E.R Roleplay/RPG, if your reading this, then you need help",
    "1. Missing Content, Errors? Materials, Your missing the content pack, go download it from the forums",
	"2. New to Roleplay? Contact a Admin, or one of our respected players, they will help teach you"
	}

	for k, v in pairs(lines) do
		AddHelpLine(v);
	end
	
	PropertySheet:AddSheet( "Profile", PlayerInfo, "gui/silkicons/user", false, false, "General information.") surface.PlaySound( "/hgn/stalker/pda/pda_open.mp3" ) ;
	PropertySheet:AddSheet( "Character Bio", CharPanel, "gui/silkicons/group", false, false, "Switch to another character or create a new one.") ;
	PropertySheet:AddSheet( "Factions", Commands, "gui/silkicons/wrench", false, false, "Execute some common commands or set your flag.");
	PropertySheet:AddSheet( "Inventory", Inventory, "gui/silkicons/box", false, false, "View your inventory.")
	PropertySheet:AddSheet( "Supplies", Business, "gui/silkicons/box", false, false, "Purchase items.");
	PropertySheet:AddSheet( "Contacts", Scoreboard, "gui/silkicons/application_view_detail", false, false, "View the scoreboard.");
	PropertySheet:AddSheet( "Help", Help, "gui/silkicons/magnifier", false, false, "Get some help with STALKER!");	

end
usermessage.Hook("playermenu", CreatePlayerMenu);

function GoCommands(data)
    CreatePlayerMenu();
	PropertySheet:SetActiveTab( PropertySheet.Items[ 3 ].Tab );
	surface.PlaySound( "/hgn/stalker/pda/pda_open.mp3" ) 
end
usermessage.Hook("GoCommands", GoCommands);

function GoScore(data)
    CreatePlayerMenu();
	PropertySheet:SetActiveTab( PropertySheet.Items[ 6 ].Tab );
	surface.PlaySound( "/hgn/stalker/pda/pda_open.mp3" )  
end
usermessage.Hook("GoScore", GoScore);

function GoInv(data)
    CreatePlayerMenu();
	PropertySheet:SetActiveTab( PropertySheet.Items[ 4 ].Tab );
	surface.PlaySound( "/hgn/stalker/pda/pda_open.mp3" ) 
end
usermessage.Hook("GoInv", GoInv);

function GoInv2()
if (input.IsKeyDown(KEY_I)) and (LocalPlayer():KeyDown( IN_SPEED ) ) and not (PlayerMenu) then
if (LocalPlayer():GetNWInt( "chatopen" ) == 1 ) then return false;

else
    CreatePlayerMenu();
	PropertySheet:SetActiveTab( PropertySheet.Items[ 4 ].Tab );
	surface.PlaySound( "/hgn/stalker/pda/pda_open.mp3" ) 
	
end end end
hook.Add("Think", "GoInv2", GoInv2)