--[[ Command Skin ]]--

Skin = {}

function Skin.Command(aIndex, Arguments)
	if SKIN_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), SKIN_GAME_MASTER_LEVEL) == 0
	then
		return
	end
	
	local Name = command:getString(Arguments, 1, 0)
	local TargetIndex = GetIndex(Name)
	
	if TargetIndex == -1
	then
		SendMessage(string.format(SKIN_MESSAGES[Language][1], Name), aIndex, 1)
		return
	end
	
	local Skin = command:getNumber(Arguments, 2)
	local player_target = User.new(TargetIndex)
	
	player_target:setSkin(Skin)
	ViewportCreate(TargetIndex)

	player_target = nil
	player = nil
end

Commands.Register(SKIN_COMMAND, Skin.Command)

return Skin