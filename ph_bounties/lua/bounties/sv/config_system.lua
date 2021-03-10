--Spooling all needed net strings--
util.AddNetworkString("Config_Return")
util.AddNetworkString("Config_Save")
util.AddNetworkString("Config_error")

--Creates generic config table.--
config_table = {
	Chance = "50",
	Min = "500",
	Max = "1000",
	PSVersion = "PS1",
	Staff = util.TableToJSON({"admin","superadmin"}),
	FastDL = true,
	Logs = true,
	Show_inSpec = false,
	Show_PopUps = true,
	MainColor = Color(33, 33, 33,250),
	SecoundaryColor = Color(33, 33, 33,150),
}


--This function is called every time the server starts. It checks if the necessary directory exits.
--If not it creates a new one.--
local function CreateDirs()
	if file.Exists("ph_bounties", "DATA") == false then 
		file.CreateDir("ph_bounties")
		file.CreateDir("ph_bounties/logs")
		file.Write("ph_bounties/config.txt",util.TableToJSON(config_table))
	end
end

--This function is called every time the server starts. It loads the existing config from the server.--
local function Load_Config()
	if file.Exists("ph_bounties", "DATA") then 
		config_table = util.JSONToTable(file.Read("ph_bounties/config.txt","DATA"))
	end
end

CreateDirs()
Load_Config()

--This net message recives info from the client about client saving new config. 
--It saves the newest config in the save file in Data/ph_bounties/config.txt--
net.Receive("Config_Save", function()
config_table = util.JSONToTable(net.ReadString())

file.Write("ph_bounties/config.txt",util.TableToJSON(config_table))

net.Start("Config_Return")
	net.WriteString(util.TableToJSON(config_table))
	net.WriteInt(3,4)
net.Broadcast()
end)

hook.Add("PlayerSay", "OpenHUD", function( ply, text )
	if text == "!bounty_config" or text == "/bounty_config" then
		if table.HasValue(util.JSONToTable(config_table.Staff), ply:GetNWString("usergroup")) then
			net.Start("Config_Return")
				net.WriteString(util.TableToJSON(config_table))
				net.WriteInt(1,4)
			net.Send(ply)
			return ""
		else 
			net.Start("Config_error")
			net.Send(ply)
			return ""
		end
	end
end)