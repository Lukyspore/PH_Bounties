--All needed variables--
Scrw, Scrh = ScrW(), ScrH()
local ply

LightGreyColor = Color(33, 33, 33,150)
DarkGreyColor = Color(33, 33, 33,250)
Dark = Color(33, 33, 33,255)
White = Color(255,255,255,255)

local BoxLerpW = -(Scrw*1)
local PopUpH = -(Scrh*1)

local NewBounty = false
local BountyPlayerName
local BountyMoney = 500

local PopUp_Bool = false
local RemovePopUp_Bool = false

--Creates temp table that will be filled with info later.--
Config_Table = {}

local w
local text
local textW
local text2

surface.CreateFont("BountyHunt28", {font = "Montserrat ExtraBold",    size = Scrw*0.0145,     weight = 500})
surface.CreateFont("BountyHunt26", {font = "Montserrat ExtraBold",    size = Scrw*0.0135,     weight = 500})
surface.CreateFont("BountyHunt24", {font = "Montserrat ExtraBold",    size = Scrw*0.0125,     weight = 500})
surface.CreateFont("BountyHunt20", {font = "Montserrat ExtraBold",    size = Scrw*0.0105,     weight = 500})

surface.CreateFont("BountyHunt26_Medium", {font = "Montserrat Medium",    size = Scrw*0.0135,     weight = 500})
surface.CreateFont("BountyHunt22_Medium", {font = "Montserrat Medium",    size = Scrw*0.0115,     weight = 500})

--Updates needed variables like font,lerp to new screen resolution.--
hook.Add( "OnScreenSizeChanged", "OnScreenSizeChanged_ChnageFont", function()
Scrw, Scrh = ScrW(), ScrH()
surface.CreateFont("BountyHunt28", {font = "Montserrat ExtraBold",    size = Scrw*0.0145,     weight = 500})
surface.CreateFont("BountyHunt26", {font = "Montserrat ExtraBold",    size = Scrw*0.0135,     weight = 500})
surface.CreateFont("BountyHunt24", {font = "Montserrat ExtraBold",    size = Scrw*0.0125,     weight = 500})
surface.CreateFont("BountyHunt20", {font = "Montserrat ExtraBold",    size = Scrw*0.0105,     weight = 500})

surface.CreateFont("BountyHunt26_Medium", {font = "Montserrat Medium",    size = Scrw*0.0135,     weight = 500})
surface.CreateFont("BountyHunt22_Medium", {font = "Montserrat Medium",    size = Scrw*0.0115,     weight = 500})

BoxLerpW = -(Scrw*1)

PopUpH= -(Scrh*1)
end)

--This function creates main bounty hud in the bottom left corner.--
local function BountyUI()
BoxLerpW = Lerp(FrameTime() *3,BoxLerpW,Scrw * .200)
draw.RoundedBoxEx( 5, Scrw * .002, Scrh*0.791,BoxLerpW ,Scrh*0.03 , DarkGreyColor,true,true,false,false )
draw.RoundedBoxEx( 5, Scrw * .002, Scrh*0.82,BoxLerpW ,Scrh*0.05 , LightGreyColor,false,false,true,true )
draw.SimpleText("Bounty","BountyHunt28", BoxLerpW*0.4, Scrh * .79,White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
draw.SimpleText("Target: ","BountyHunt24", BoxLerpW*0.05, Scrh * .82,White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
draw.SimpleText("Reward: ","BountyHunt24", BoxLerpW*0.05, Scrh * .84,White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

draw.SimpleText(BountyPlayerName,"BountyHunt26_Medium", BoxLerpW*0.24, Scrh * .82,White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
draw.SimpleText(BountyMoney.." Points","BountyHunt26_Medium", BoxLerpW*0.275, Scrh * .84,White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

--This function creates those popups at the top of the screen.--
local function PopUp()
PopUpH = Lerp(FrameTime() * 2,PopUpH,Scrh*0.1)

draw.RoundedBoxEx( 8, Scrw * .5-(Scrw*w/2), PopUpH,Scrw* w,Scrh*0.07 , LightGreyColor,true,true,true,true )
draw.SimpleText(text,"BountyHunt28", Scrw*textW, PopUpH+Scrh*0.01,White, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
draw.SimpleText(text2,"BountyHunt28", Scrw*textW, PopUpH+Scrh*0.035,White, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end

--This function removes the popups from the screen using lerp.--
local function RemovePopUp()
PopUpH = Lerp(FrameTime() * 2,PopUpH,-(Scrh*1))
if PopUpH < -(Scrw*0.2515625) then
RemovePopUp_Bool = false
PopUp_Bool = false
PopUpH = -(Scrh*1)
	if NewOnGoingPopUp == true then 
		PopUp_Bool = true
		NewOnGoingPopUp = false
		timer.Simple(5, function() RemovePopUp_Bool = true end )
	end
end
end

--This function removes main hud from the screen when the bounty is finished.--
local function removeGUI()
BoxLerpW = Lerp(FrameTime() * 2,BoxLerpW,-(Scrw*1))
if BoxLerpW < -(Scrw*0.1208) then
RemoveBountyGUI = false
NewBounty = false 
BoxLerpW = -(Scrw*1)
end
end

--This function is drawing individual parts of the hud.--
local function BountyHuntGUI()
	if ply == nil then 
		ply = LocalPlayer()
	end
	if Config_Table.Show_inSpec == false and team.GetName(ply:Team()) == "Spectator" or Config_Table.Show_inSpec == false and ply:Alive() == false then return end
	if NewBounty == true then BountyUI() end
	if Config_Table.Show_PopUps == true then
		if PopUp_Bool == true then PopUp() end
		if RemovePopUp_Bool == true then RemovePopUp() end
	end
	if RemoveBountyGUI == true then removeGUI() end
end

local function BountyHuntDrawGUI()
	if not LocalPlayer():IsValid() then return end

	BountyHuntGUI()
end
hook.Add("HUDPaint", "DrawBountyHuntGUI", BountyHuntDrawGUI)

--This concommand adds the stop bounty command.--
concommand.Add("stop_bounty", function(ply)
net.Start("Bounty_Stop")
net.SendToServer()
end)

--This concommand adds the start bounty command.--
concommand.Add("start_bounty", function(ply,cmd,args)
net.Start("Bounty_Start")
	net.WriteString(util.TableToJSON(args))
net.SendToServer()
end)

--This net message recives msg from the server to print out to the client console.--
net.Receive("Bounty_message", function()
	local msg = net.ReadString()
print(msg)
end)

--This net message recives info from the server about new bounty.--
net.Receive("NewBounty", function ()
BountyPlayerName = net.ReadString()
BountyMoney = net.ReadInt(32)
NewBounty = true
		PopUp_Bool = true
		w = 0.26
		text = "New bounty of "..BountyMoney.." Points has been set on "
		textW = 0.5
		text2 = BountyPlayerName
		timer.Simple(5, function() RemovePopUp_Bool = true end )
end)

--This net message recives info from the server about player commiting sucided. It makes sure that the hud will be removed.--
net.Receive("PlayerSucided", function()
RemoveBountyGUI = true
		PopUp_Bool = true 
		w = 0.220
		text = "Bounty suspect committed suicide."
		textW = 0.5
		text2 = "Bounty ended."
		timer.Simple(5, function() RemovePopUp_Bool = true end )
end)

--This net message recives info from the server about player disconnecting from the server. It makes sure that the hud will be removed.--
net.Receive("PlayerDisconnected", function()
RemoveBountyGUI = true
		PopUp_Bool = true 
		w = 0.19
		text = "Bounty suspect disconnected."
		textW = 0.5
		text2 = "Bounty ended."
		timer.Simple(5, function() RemovePopUp_Bool = true end )
end)

--This net message recives info from the server about round ending with no bounty claimer.--
net.Receive("BountyNotDone", function()
RemoveBountyGUI = true
end)

--This net message recives info from the server about some player claiming the bounty.--
net.Receive("BountyDone", function()
RemoveBountyGUI = true
		PopUp_Bool = true
		w = 0.200
		text = "The Bounty has been claimed by "
		textW = 0.5
		text2 = net.ReadString()
		timer.Simple(5, function() RemovePopUp_Bool = true end)
end)

--This net message recives info from the server about the config color.--
net.Receive("NewColor",function()
Config_Table = util.JSONToTable(net.ReadString())

DarkGreyColor = Config_Table.MainColor
LightGreyColor = Config_Table.SecoundaryColor
end)