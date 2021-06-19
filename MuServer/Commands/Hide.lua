Hide = {}

function Hide.Command(aIndex, Arguments)
    local player = User.new(aIndex)
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), HIDE_COMMAND_GAME_MASTER_LEVEL) == 0
	then
		return
	end

    if CheckBuffPlayer(player:getIndex(), 18) == 0
    then
        AddEffect(player:getIndex(),0,18,0,0,0,0,0)

        ViewportDestroy(player:getIndex())
    else
        RemoveEffect(player:getIndex(), 18)

        ViewportCreate(player:getIndex())
    end

    player = nil
end

if HIDE_COMMAND_SWITCH ~= 0
then
    Commands.Register(HIDE_COMMAND_SYNTAX, Hide.Command)
end

return Hide