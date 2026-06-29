local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Callback = Instance.new("BindableEvent")
local Log = {}

local function HandlePlayer(Player)
	Log[Player] = {}

	for _, Target in Players:GetPlayers() do
		Log[Player][Target] = Player:GetFriendStatus(Target)
	end

	local C C = Players.PlayerAdded:Connect(function(Target)
		if not Players:FindFirstChild(Player.Name) then
			C:Disconnect()
			return
		end

		Log[Player][Target] = Player:GetFriendStatus(Target)
	end)

	Player.FriendStatusChanged:Connect(function(Target, New)
		if New.Value == 4 then
			Callback:Fire(Target, Player, 0)
			Player.FriendStatusChanged:Connect(function(NewTarget, NewStatus)
				if NewTarget == Target then
					if NewStatus.Value == 1 then
						Callback:Fire(Player, Target, 1)
					end
					
					if NewStatus.Value == 2 then
						Callback:Fire(Player, Target, 2)
					end
				end
			end)
		end
	end)

	if Player == LocalPlayer then return end

	local Old = Log[Player][Target]
	if not Old then return end

	if Old.Value == 2 and New.Value == 1 then
		Callback:Fire(Player, Target, 3)
	end

	Log[Player][Target] = New
end

for _, Player in Players:GetPlayers() do
	HandlePlayer(Player)
end

Players.PlayerAdded:Connect(HandlePlayer)

Players.PlayerRemoving:Connect(function(Player)
	if Log[Player] then
		Log[Player] = nil
	end

	for _, Data in Log do
		local Found = Data[Player]
		if Found then
			Found = nil
		end
	end
end)

return Callback
