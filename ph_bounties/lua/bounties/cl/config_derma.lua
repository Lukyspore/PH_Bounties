--This function darws the Config box derma.--
local function DrawConfigDerma()
	local MainConfigDerma = vgui.Create( "DFrame" )	-- The name DermaPanel to store the value DFrame.
	MainConfigDerma:SetSize( Scrw*0.2, Scrh*0.47 ) 				-- Sets the size to 500x by 300y.
	MainConfigDerma:SetPos(Scrw*0.5-(Scrw*0.2/2),Scrh*0.5-(Scrh*0.47/2))
	MainConfigDerma:SetTitle( "" )					-- Set the title to nothing.
	MainConfigDerma:SetDraggable( false )			-- Makes it so you carnt drag it.
	MainConfigDerma:MakePopup()		
	MainConfigDerma:ShowCloseButton(false)
	MainConfigDerma.Paint = function( self, w, h )	-- Paint function w, h = how wide and tall it is.
		draw.RoundedBoxEx( 5, 0, 0, w, h, Color(33,33,33,150),false,false,true,true )
	end

	local MainTopConfigDerma = vgui.Create( "DFrame" )	-- The name DermaPanel to store the value DFrame.
	MainTopConfigDerma:SetSize( Scrw*0.2, Scrh*0.03 ) 				-- Sets the size to 500x by 300y.
	MainTopConfigDerma:SetPos(Scrw*0.5-(Scrw*0.2/2),Scrh*0.24)
	MainTopConfigDerma:SetTitle( "" )					-- Set the title to nothing.
	MainTopConfigDerma:SetDraggable( false )			-- Makes it so you carnt drag it.
	MainTopConfigDerma:MakePopup()		
	MainTopConfigDerma:ShowCloseButton(true)
	MainTopConfigDerma.Paint = function( self, w, h )	-- Paint function w, h = how wide and tall it is.
		draw.RoundedBoxEx( 5, 0, 0, w, h, Dark,true,true,false,false )
	end
	MainTopConfigDerma.OnClose = function(  )	-- Paint function w, h = how wide and tall it is.
		MainConfigDerma:Close()
	end

	local ConfigLabel = vgui.Create( "DLabel", MainTopConfigDerma )
	ConfigLabel:SetPos( Scrw*0.005, Scrh*0.005 )
	ConfigLabel:SetSize(Scrw*0.15, Scrh*0.02)
	ConfigLabel:SetText( "Bounty Config" )
	ConfigLabel:SetFont("BountyHunt26")


	local ChanceLabel = vgui.Create( "DLabel", MainConfigDerma )
	ChanceLabel:SetPos( Scrw*0.005, Scrh*0.02 )
	ChanceLabel:SetSize(Scrw*0.15, Scrh*0.02)
	ChanceLabel:SetText( "Chance of starting new bounty:" )
	ChanceLabel:SetFont("BountyHunt20")

	local ChanceProcentLabel = vgui.Create( "DLabel", MainConfigDerma )
	ChanceProcentLabel:SetPos( Scrw*0.18, Scrh*0.02 )
	ChanceProcentLabel:SetSize(Scrw*0.15, Scrh*0.02)
	ChanceProcentLabel:SetText( "%" )
	ChanceProcentLabel:SetFont("BountyHunt20")

	local ChanceTextEntry = vgui.Create( "DTextEntry", MainConfigDerma )
	ChanceTextEntry:SetPos(Scrw*0.145, Scrh*0.02)
	ChanceTextEntry:SetSize(Scrw*0.035, Scrh*0.02)
	ChanceTextEntry:SetNumeric(true)
	ChanceTextEntry:DockMargin( 0, 5, 0, 0 )
	ChanceTextEntry:SetValue( Config_Table.Chance )
	ChanceTextEntry:SetFont("BountyHunt22_Medium")
	ChanceTextEntry:SetTextColor(White)
	ChanceTextEntry:SetDrawBackground(false)
	 ChanceTextEntry.OnChange = function(self)
	 local txt =tonumber(self:GetValue())
	 	if txt == nil then self:SetText("0") self:SetValue("0") self:SetCaretPos( 2 ) return end
	 	if txt > 100 then self:SetText("100") self:SetValue("100") self:SetCaretPos( 3 ) return end
	 end


	 local MinimumLabel = vgui.Create( "DLabel", MainConfigDerma )
	MinimumLabel:SetPos( Scrw*0.005, Scrh*0.05 )
	MinimumLabel:SetSize(Scrw*0.15, Scrh*0.02)
	MinimumLabel:SetText( "Minimum bounty payout:" )
	MinimumLabel:SetFont("BountyHunt20")

	local MinimumPointsLabel = vgui.Create( "DLabel", MainConfigDerma )
	MinimumPointsLabel:SetPos( Scrw*0.17, Scrh*0.05 )
	MinimumPointsLabel:SetSize(Scrw*0.15, Scrh*0.02)
	MinimumPointsLabel:SetText( "Points" )
	MinimumPointsLabel:SetFont("BountyHunt20")

	local MinimumTextEntry = vgui.Create( "DTextEntry", MainConfigDerma )
	MinimumTextEntry:SetPos(Scrw*0.13, Scrh*0.05)
	MinimumTextEntry:SetSize(Scrw*0.04, Scrh*0.02)
	MinimumTextEntry:SetNumeric(true)
	MinimumTextEntry:DockMargin( 0, 5, 0, 0 )
	MinimumTextEntry:SetValue( Config_Table.Min )
	MinimumTextEntry:SetFont("BountyHunt22_Medium")
	MinimumTextEntry:SetTextColor(White)
	MinimumTextEntry:SetDrawBackground(false)
	 MinimumTextEntry.OnChange = function(self)
	 local txt = tonumber(self:GetValue())
	 	if txt == nil then self:SetText("1") self:SetValue("1") self:SetCaretPos( 2 ) return end
	 end

	 local MaximumLabel = vgui.Create( "DLabel", MainConfigDerma )
	MaximumLabel:SetPos( Scrw*0.005, Scrh*0.08 )
	MaximumLabel:SetSize(Scrw*0.15, Scrh*0.02)
	MaximumLabel:SetText( "Maximum bounty payout:" )
	MaximumLabel:SetFont("BountyHunt20")

	local MaximumPointsLabel = vgui.Create( "DLabel", MainConfigDerma )
	MaximumPointsLabel:SetPos( Scrw*0.17, Scrh*0.08 )
	MaximumPointsLabel:SetSize(Scrw*0.15, Scrh*0.02)
	MaximumPointsLabel:SetText( "Points" )
	MaximumPointsLabel:SetFont("BountyHunt20")

	local MaximumTextEntry = vgui.Create( "DTextEntry", MainConfigDerma )
	MaximumTextEntry:SetPos(Scrw*0.13, Scrh*0.08)
	MaximumTextEntry:SetSize(Scrw*0.04, Scrh*0.02)
	MaximumTextEntry:SetNumeric(true)
	MaximumTextEntry:DockMargin( 0, 5, 0, 0 )
	MaximumTextEntry:SetValue( Config_Table.Max )
	MaximumTextEntry:SetFont("BountyHunt22_Medium")
	MaximumTextEntry:SetTextColor(White)
	MaximumTextEntry:SetDrawBackground(false)
	 MaximumTextEntry.OnChange = function(self)
	 local txt =tonumber(self:GetValue())
	 	if txt == nil then self:SetText("1") self:SetValue("1") self:SetCaretPos( 2 ) return end
	 end

	 local PSVersionLabel = vgui.Create( "DLabel", MainConfigDerma )
	PSVersionLabel:SetPos( Scrw*0.005, Scrh*0.11 )
	PSVersionLabel:SetSize(Scrw*0.15, Scrh*0.02)
	PSVersionLabel:SetText( "Pointshop version support:" )
	PSVersionLabel:SetFont("BountyHunt20")

	local PSComboBox = vgui.Create( "DComboBox", MainConfigDerma )
	PSComboBox:SetPos( Scrw*0.13, Scrh*0.11 )
	PSComboBox:SetSize( Scrw*0.05, Scrh*0.02 )
	PSComboBox:SetFont("BountyHunt20")
	PSComboBox:SetTextColor(White)
	PSComboBox:SetValue( "PS1" )
	PSComboBox:AddChoice( "PS1" )
	PSComboBox:AddChoice( "PS2" )
	PSComboBox.Paint = function( self, w, h )	-- Paint function w, h = how wide and tall it is.
		draw.RoundedBox( 14, 0, 0, w, h, Dark)
	end

	 local StaffLabel = vgui.Create( "DLabel", MainConfigDerma )
	StaffLabel:SetPos( Scrw*0.005, Scrh*0.14 )
	StaffLabel:SetSize(Scrw*0.15, Scrh*0.02)
	StaffLabel:SetText( "Admin ranks:" )
	StaffLabel:SetFont("BountyHunt20")

	local StaffTextEntry = vgui.Create( "DTextEntry", MainConfigDerma )
	StaffTextEntry:SetPos(Scrw*0.06, Scrh*0.14)
	StaffTextEntry:SetSize(Scrw*0.13, Scrh*0.02)
	StaffTextEntry:DockMargin( 0, 5, 0, 0 )
	StaffTextEntry:SetValue( Config_Table.Staff )
	StaffTextEntry:SetFont("BountyHunt22_Medium")
	StaffTextEntry:SetTextColor(White)
	StaffTextEntry:SetDrawBackground(false)
	StaffTextEntry.OnChange = function(self)
	 local txt = self:GetValue()
	 	if #txt == 0 then self:SetText(Config_Table.Staff) self:SetValue(Config_Table.Staff) self:SetCaretPos( #Config_Table.Staff ) return end
	 end

	 local FastDLLabel = vgui.Create( "DLabel", MainConfigDerma )
	FastDLLabel:SetPos( Scrw*0.005, Scrh*0.17 )
	FastDLLabel:SetSize(Scrw*0.15, Scrh*0.02)
	FastDLLabel:SetText( "FastDL:" )
	FastDLLabel:SetFont("BountyHunt20")

	local FastDLCheckBox = MainConfigDerma:Add( "DCheckBox" ) -- Create the checkbox
	FastDLCheckBox:SetPos( Scrw*0.15, Scrh*0.173 ) -- Set the position
	FastDLCheckBox:SetValue( Config_Table.FastDL ) -- Initial "ticked" value

	local LogsLabel = vgui.Create( "DLabel", MainConfigDerma )
	LogsLabel:SetPos( Scrw*0.005, Scrh*0.2 )
	LogsLabel:SetSize(Scrw*0.15, Scrh*0.02)
	LogsLabel:SetText( "Keep logs:" )
	LogsLabel:SetFont("BountyHunt20")

	local LogsCheckBox = MainConfigDerma:Add( "DCheckBox" ) -- Create the checkbox
	LogsCheckBox:SetPos( Scrw*0.15, Scrh*0.203 ) -- Set the position
	LogsCheckBox:SetValue( Config_Table.Logs ) -- Initial "ticked" value

	local ShowSpecLabel = vgui.Create( "DLabel", MainConfigDerma )
	ShowSpecLabel:SetPos( Scrw*0.005, Scrh*0.23 )
	ShowSpecLabel:SetSize(Scrw*0.15, Scrh*0.02)
	ShowSpecLabel:SetText( "Show hud in Spectate mode:" )
	ShowSpecLabel:SetFont("BountyHunt20")

	local ShowSpecCheckBox = MainConfigDerma:Add( "DCheckBox" ) -- Create the checkbox
	ShowSpecCheckBox:SetPos( Scrw*0.15, Scrh*0.233 ) -- Set the position
	ShowSpecCheckBox:SetValue( Config_Table.Show_inSpec ) -- Initial "ticked" value

	local MainColorLabel = vgui.Create( "DLabel", MainConfigDerma )
	MainColorLabel:SetPos( Scrw*0.11, Scrh*0.29 )
	MainColorLabel:SetSize(Scrw*0.15, Scrh*0.02)
	MainColorLabel:SetText( "Main Color:" )
	MainColorLabel:SetFont("BountyHunt20")

	local MainColorMixer = vgui.Create("DColorMixer", MainConfigDerma)
	MainColorMixer:SetSize(Scrw*0.08, Scrh*0.09)
	MainColorMixer:SetPos(Scrw*0.11, Scrh*0.31)
	MainColorMixer:SetPalette(false)  			-- Show/hide the palette 				DEF:true
	MainColorMixer:SetAlphaBar(true) 			-- Show/hide the alpha bar 				DEF:true
	MainColorMixer:SetWangs(true) 				-- Show/hide the R G B A indicators 	DEF:true
	MainColorMixer:SetColor(Config_Table.MainColor) 	-- Set the default color

	local SecColorLabel = vgui.Create( "DLabel", MainConfigDerma )
	SecColorLabel:SetPos( Scrw*0.007, Scrh*0.29 )
	SecColorLabel:SetSize(Scrw*0.15, Scrh*0.02)
	SecColorLabel:SetText( "Secoundary Color:" )
	SecColorLabel:SetFont("BountyHunt20")

	local SecondColorMixer = vgui.Create("DColorMixer", MainConfigDerma)
	SecondColorMixer:SetSize(Scrw*0.08, Scrh*0.09)
	SecondColorMixer:SetPos(Scrw*0.007, Scrh*0.31)
	SecondColorMixer:SetPalette(false)  			-- Show/hide the palette 				DEF:true
	SecondColorMixer:SetAlphaBar(true) 			-- Show/hide the alpha bar 				DEF:true
	SecondColorMixer:SetWangs(true) 				-- Show/hide the R G B A indicators 	DEF:true
	SecondColorMixer:SetColor(Config_Table.SecoundaryColor) 	-- Set the default color

	local ShowPopUpLabel = vgui.Create( "DLabel", MainConfigDerma )
	ShowPopUpLabel:SetPos( Scrw*0.005, Scrh*0.26 )
	ShowPopUpLabel:SetSize(Scrw*0.15, Scrh*0.02)
	ShowPopUpLabel:SetText( "Show PopUps:" )
	ShowPopUpLabel:SetFont("BountyHunt20")

	local ShowPopUpCheckBox = MainConfigDerma:Add( "DCheckBox" ) -- Create the checkbox
	ShowPopUpCheckBox:SetPos( Scrw*0.15, Scrh*0.263 ) -- Set the position
	ShowPopUpCheckBox:SetValue( Config_Table.Show_PopUps ) -- Initial "ticked" value

	local SaveButton = vgui.Create( "DButton", MainConfigDerma )
	SaveButton:SetText( "Save" )
	SaveButton:SetPos( Scrw*0.014, Scrh*0.42 )
	SaveButton:SetSize( Scrw*0.17, Scrh*0.03 )
	SaveButton:SetFont("BountyHunt20")
	SaveButton:SetTextColor(White)
	SaveButton.DoClick = function()
		MainConfigDerma:Close()
		MainTopConfigDerma:Close()
		Config_Table.Chance = ChanceTextEntry:GetValue()
		Config_Table.Min = MinimumTextEntry:GetValue()
		Config_Table.Max = MaximumTextEntry:GetValue()
		Config_Table.PSVersion = PSComboBox:GetValue()
		Config_Table.Staff = StaffTextEntry:GetValue()
		Config_Table.FastDL = FastDLCheckBox:GetChecked()
		Config_Table.Logs = LogsCheckBox:GetChecked()
		Config_Table.Show_inSpec = ShowSpecCheckBox:GetChecked()
		Config_Table.MainColor = MainColorMixer:GetColor()
		Config_Table.SecoundaryColor = SecondColorMixer:GetColor()
		Config_Table.Show_PopUps = ShowPopUpCheckBox:GetChecked()
		net.Start("Config_Save")
			net.WriteString(util.TableToJSON(Config_Table))
		net.SendToServer()
		notification.AddLegacy( "New config has been saved.", NOTIFY_GENERIC, 4 )
	end
	SaveButton.Paint = function( self, w, h )	-- Paint function w, h = how wide and tall it is.
		draw.RoundedBox( 10, 0, 0, w, h, Dark)
	end


end

--This net message recives info from the server with the newest config table. And it draws the config derma right after.--
net.Receive("Config_Return", function()
Config_Table = util.JSONToTable(net.ReadString())
local num = net.ReadInt(4)
if num == 1 then 
DrawConfigDerma()
else
DarkGreyColor = Config_Table.MainColor
LightGreyColor = Config_Table.SecoundaryColor
end
end)

--This net message recives info from the server with the error message about player not being an admin.--
net.Receive("Config_error", function()
	notification.AddLegacy( "You need to be an admin to perform this command.", NOTIFY_ERROR, 4 )
end)