--[[ Track System ]]--

Track = {}

function Track.Command(aIndex, Arguments)
	if TRACK_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), TRACK_GAME_MASTER_LEVEL) == 0
	then
		return
	end
	
	local Name = command:getString(Arguments, 1, 0)
	local TargetIndex = GetIndex(Name)
	
	if TargetIndex == -1
	then
		SendMessage(string.format(TRACK_MESSAGES[Language][1], Name), aIndex, 1)
		return
	end
	
	Teleport(TargetIndex,player:getMapNumber(), player:getX(), player:getY())
	
	player = nil
end

Commands.Register(TRACK_COMMAND, Track.Command)

return Track