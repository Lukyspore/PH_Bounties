--Spooling all needed net strings--
util.AddNetworkString("NewBounty")
util.AddNetworkString("BountyDone")
util.AddNetworkString("BountyNotDone")
util.AddNetworkString("PlayerDisconnected")
util.AddNetworkString("PlayerSucided")
util.AddNetworkString("Bounty_Stop")
util.AddNetworkString("Bounty_message")
util.AddNetworkString("Bounty_Start")
util.AddNetworkString("NewColor")

--All needed variables--
local NewBounty = false
local BountyPlayer
local BountyMoney = 0
local BountyCreator

--This function starts the bounty. It picks a random person from the prop team and it picks a random amount of points. 
--Then it sends a net message to the client about new bounty.--
function StartBounty()
	local TeamPlayers = team.GetPlayers(TEAM_PROPS)
	local number_of_players = 0

	for k,v in pairs(TeamPlayers) do
		number_of_players = k
	end
	if number_of_players == 0 then return end

	local randPlayer = math.Round(math.Rand(1,number_of_players))
	BountyPlayer = TeamPlayers[randPlayer]
	if BountyPlayer:Alive() == false then
		math.randomseed(os.time())
		randPlayer = math.Round(math.Rand(1,number_of_players))
		BountyPlayer = TeamPlayers[randPlayer]
	end

	BountyMoney = math.Round(math.Rand(config_table.Min,config_table.Max))
	

	net.Start("NewBounty")
		net.WriteString(BountyPlayer:Name())
		net.WriteInt(BountyMoney,32)
	net.Broadcast()
	print("[PH Bounties] New bounty has been set on "..BountyPlayer:Name().." with bounty "..BountyMoney)

	NewBounty = true

	if config_table.Logs == true then
		file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt", "\n--------\n-New Bounty- \nTarget: "..BountyPlayer:Name().."\nReward: "..BountyMoney.."\nCreator: "..BountyCreator.."\nTime: "..os.date( "%H:%M:%S"))
	end
end

--This hook is called everytime round has ended. It checks if someone claimed the bounty.
--If not it calls a bounty end and sends a new net message to the client.--
hook.Add("PH_RoundEnd", "PH_RoundEnd", function()
	if NewBounty == true then 
		net.Start("BountyNotDone")
		net.Broadcast()
		NewBounty = false
		print("[PH Bounties] Round ended no one claimed the bounty.")
		if config_table.Logs == true then 
			file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt", "\n--------\n-Bounty Cancled- \nNo one claimed the bounty.".."\nTime: "..os.date( "%H:%M:%S"))
		end
	end
end)

hook.Add("PH_RoundStart", "PH_RoundStart", function()
	math.randomseed(os.time())
    local chanceOfBOunty = math.Rand(1,100)

    if chanceOfBOunty > 100-config_table.Chance then 
    	BountyCreator = "Server"
    	StartBounty()
    end
end)

--This hook is called when a prop is killed. If prop has been killed and the prop was the bounty player
--Then it gives out the props to the winner. And ends the bounty.--
hook.Add( "PH_OnPropKilled", "PDeath", function( victim, attacker )
    if BountyPlayer == victim and attacker ~= BountyPlayer and NewBounty == true then 
    	if config_table.PSVersion == "PS1" then 
    		attacker:PS_GivePoints(BountyMoney)
   		else
   			attacker:PS2_AddStandardPoints(BountyMoney)
   		end
	NewBounty = false

    net.Start("BountyDone")
		net.WriteString(attacker:Name())
	net.Broadcast()
	print("Bounty has been claimed by "..attacker:Name())

		if config_table.Logs == true then 
			file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt", "\n--------\n-Bounty Finished- \nBounty Claimer: "..attacker:Name().."\nTime: "..os.date( "%H:%M:%S"))
		end
    end
end )

--This hook is called when someone dies. It checks if the attacker was the bounty player and if so.
--Then it ends the bounty with a suicide message.--
hook.Add( "PlayerDeath", "PHDeath", function( victim, inflictor, attacker )
     if attacker == BountyPlayer and NewBounty == true then 
    	net.Start("PlayerSucided")
		net.Broadcast()
		print("[PH Bounties] Bounty player killed himself. Bounty ended.")

		NewBounty = false

		if config_table.Logs == true then 
			file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt", "\n--------\n-Bounty Cancled- \nBounty player commited suicide. No one claimed the bounty.\nTime: "..os.date( "%H:%M:%S"))
		end
    end
end )

--This hook is called when someone disconnects. It checks if the disconnect player was the bounty player and if so.
--Then it ends the bounty with a player disconnected message.--
hook.Add( "PlayerDisconnected", "PDisconnect", function( ply )
    if ply == BountyPlayer then
    	net.Start("PlayerDisconnected")
		net.Broadcast()
		print("[PH Bounties] Bounty player disconnected. Bounty ended.")

		NewBounty = false

		if config_table.Logs == true then 
			file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt", "\n--------\n-Bounty Cancled- \nBounty player disconnected from the server. No one claimed the bounty.\nTime: "..os.date( "%H:%M:%S"))
		end
     end
end )

--This hook is called when someone spawns for the first time. It checks if there is already a bounty going on if so.
--It sends him a net message with all necessary info.--
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", function( ply )
	net.Start("NewColor")
		net.WriteString(util.TableToJSON(config_table))
	net.Send(ply)
	if NewBounty == true then 
	net.Start("NewBounty")
		net.WriteString(BountyPlayer:Name())
		net.WriteInt(BountyMoney,32)
	net.Send(ply)
end
end )

--This net message recives info from the client about client using bounty stop command. 
--It checks if the client is an admin and if so it lets him end the round.--
net.Receive("Bounty_Stop", function(len, ply)
if table.HasValue(util.JSONToTable(config_table.Staff), ply:GetNWString("usergroup")) then
if NewBounty == true then 

		net.Start("BountyNotDone")
		net.Broadcast()
		NewBounty = false
		print("[PH Bounties] Bounty has been stopped by "..ply:Name())
		if config_table.Logs == true then 
			file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt", "\n--------\n-Bounty Cancled- \n"..ply:Name().." Stopped the bounty.\nTime: "..os.date( "%H:%M:%S"))
		end
else
	net.Start("Bounty_message")
		net.WriteString("[PH Bounties] There are no active bounties.")
	net.Send(ply)
end
else
	net.Start("Bounty_message")
		net.WriteString("[PH Bounties] You need to be an admin to perform this command.")
	net.Send(ply)
end
end)

--This net message recives info from the client about client using bounty start command. 
--It checks if the client is an admin and if so it lets him end the round.--
net.Receive("Bounty_Start", function(len,ply)
if table.HasValue(util.JSONToTable(config_table.Staff), ply:GetNWString("usergroup")) then
	if NewBounty == false then 
	local Arg = util.JSONToTable(net.ReadString())
		if Arg[1] ~= nil && Arg[2] ~= nil then
			
			if Arg[1] == "*" then
				local TeamPlayers = team.GetPlayers(TEAM_PROPS)
				local number_of_players = 0

				for k,v in pairs(TeamPlayers) do
					number_of_players = k
				end
				if number_of_players == 0 then return end

				local randPlayer = math.Round(math.Rand(1,number_of_players))
				BountyPlayer = TeamPlayers[randPlayer]
				if BountyPlayer:Alive() == false then
					math.randomseed(os.time())
					randPlayer = math.Round(math.Rand(1,number_of_players))
					BountyPlayer = TeamPlayers[randPlayer]
				end
			else
				for k,v in pairs(player.GetAll()) do
					if v:Name() == Arg[1] then 
						BountyPlayer = v
						break
					end
				end
			end

			if Arg[2] == "*" then 
				BountyMoney = math.Round(math.Rand(config_table.Min,config_table.Max))
			else
				BountyMoney = tonumber(Arg[2])
			end

			if team.GetName(BountyPlayer:Team()) == "Hunters" then 
				net.Start("Bounty_message")
					net.WriteString("[PH Bounties] You can't set bounty on a hunter.")
				net.Send(ply)
			return end

			if BountyPlayer == nil then 
				net.Start("Bounty_message")
					net.WriteString("[PH Bounties] There is no one on the server with that name.")
				net.Send(ply)
			return end

			if BountyPlayer:Alive() == false then 
				net.Start("Bounty_message")
					net.WriteString("[PH Bounties] You can't set bounty on a dead player.")
				net.Send(ply)
			return end

			if type(BountyMoney) ~= "number" then 
				net.Start("Bounty_message")
					net.WriteString("[PH Bounties] The bounty amount has to be a number.")
				net.Send(ply)
			return end

			BountyCreator = ply:Name()
			net.Start("NewBounty")
				net.WriteString(BountyPlayer:Name())
				net.WriteInt(BountyMoney,32)
			net.Broadcast()
			print("[PH Bounties] New bounty has been set on "..BountyPlayer:Name().." with bounty "..BountyMoney)

			NewBounty = true

			net.Start("Bounty_message")
				net.WriteString("[PH Bounties] Started new bounty with given arguments")
			net.Send(ply)
			if config_table.Logs == true then 
				file.Append("ph_bounties/logs/"..os.date( "%d_%m_%Y" )..".txt","\n--------\n-New Bounty- \nTarget: "..BountyPlayer:Name().."\nReward: "..BountyMoney.."\nCreator: "..BountyCreator.."\nTime: "..os.date( "%H:%M:%S"))
			end

		else
			net.Start("Bounty_message")
				net.WriteString("[PH Bounties] Invalid syntax.")
			net.Send(ply)
		end

	else
		net.Start("Bounty_message")
			net.WriteString("[PH Bounties] There is already an active bounty.")
		net.Send(ply)
	end
else
	net.Start("Bounty_message")
		net.WriteString("[PH Bounties] You need to be an admin to perform this command.")
	net.Send(ply)
end
end)

--This concommand adds server console command that shows current bounty status.--
concommand.Add("bounty_status", function()
	if NewBounty == true then
		print("Target: "..BountyPlayer:Name().."\nReward: "..BountyMoney.."\nCreator: "..BountyCreator)
	else 
		print("[PH Bounties] There are no active bounties.")
	end
end)

--This hook just prints addon initialization to the server console.
hook.Add( "Initialize", "some_unique_name", function()
	print("[Bounty Hunt] Successfully loaded.")
end )

