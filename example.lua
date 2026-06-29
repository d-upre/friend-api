local OnFriend = loadstring(game:HttpGet("https://raw.githubusercontent.com/d-upre/friend-api/refs/heads/main/api.lua"))()

OnFriend.Event:Connect(function(Sender, Receiver, Status)
	if Status == 0 then
		warn(`{Sender.Name} sent a friend request to {Receiver.Name}!`)
	elseif Status == 1 then
		warn(`{Sender.Name} declined a friend request from {Receiver.Name}!`)
	elseif Status == 2 then
		warn(`{Sender.Name} accepted a friend request from {Receiver.Name}!`)
	elseif Status == 3 then
		warn(`{Sender.Name} unfriended {Receiver.Name}!`)
	end
end)
