SpawnMonster = {}

function SpawnMonster.Command(aIndex, Arguments)
    local player = User.new(aIndex)
	
	if player:getAuthority() ~= 32 and CheckGameMasterLevel(player:getAccountID(), player:getName(), SPAWN_MONSTER_GAME_MASTER_LEVEL) == 0
	then
		return
	end

    local class = command:getNumber(Arguments, 1)
	local map = command:getNumber(Arguments, 2)
	local x = command:getNumber(Arguments, 3)
    local y = command:getNumber(Arguments, 4)

    local index = AddMonster(map)
		
    if index == -1
    then
        LogAdd(string.format("Problem when creating the monster :%d", class))
        return
    end
		
    local monster = User.new(index)
    
    SetPositionMonster(index, map)
    SetMonster(index, class)

    monster:setX(x)
    monster:setY(y)

    monster = nil
end

if SPAWN_MONSTER_SWITCH ~= 0
then
    Commands.Register(SPAWN_MONSTER_SYNTAX, SpawnMonster.Command)
end

return SpawnMonster