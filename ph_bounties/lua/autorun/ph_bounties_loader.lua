--This includes or necessary files to the server side and client side.--
if file.Exists("ph_bounties", "DATA") then 
	config_table = util.JSONToTable(file.Read("ph_bounties/config.txt","DATA"))
end
if SERVER then	
	include("bounties/sv/config_system.lua")
	include("bounties/sv/bountyhunt_system.lua")

	AddCSLuaFile("bounties/cl/bountyhunt_gui.lua")
	AddCSLuaFile("bounties/cl/config_derma.lua")
	if config_table.FastDL == true then 
		resource.AddFile("resource/fonts/Montserrat-Medium.ttf")
		resource.AddFile("resource/fonts/Montserrat-ExtraBold.ttf")
	else
		resource.AddWorkshop("2346631655")
	end
elseif CLIENT then
	include("bounties/cl/bountyhunt_gui.lua")
	include("bounties/cl/config_derma.lua")
end