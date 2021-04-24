--[[ Anti Move-Speed System]]

--[[

OBSERVAÇÃO!!!!

Esse sistema não garante a detecção 100% de speed por meio de andar!

o mesmo pode ser eficaz detectando uma porcentagem dos players, não garanto que detecte todos players que utilizem speed.
]]--

MoveSpeed = {}

local ANTI_MOVE_SPEED_SWITCH = 0
local ANTI_MOVE_SPEED_MAX = 15 --Coordenadas por segundo que vai aceitar do player...
local ANTI_MOVE_SPEED_TIME_BLOCK = 5 --Tempo em segundos que vai bloquear o player de andar...

local HANDLES_PLAYER_MOVE = {}

function MoveSpeed.Start()
	if ANTI_MOVE_SPEED_SWITCH == 0
	then
		return
	end

	GameServerFunctions.PlayerMove(MoveSpeed.PlayerMove)
	GameServerFunctions.PlayerLogout(MoveSpeed.PlayerLogout)
	GameServerFunctions.CharacterMove(MoveSpeed.CharacterMove)
	GameServerFunctions.PlayerCanMove(MoveSpeed.PlayerCanMove)
end

function MoveSpeed.CharacterMove(aIndex, map, x, y)
	if HANDLES_PLAYER_MOVE[aIndex]
	then
		HANDLES_PLAYER_MOVE[aIndex] = nil
	end
end

function MoveSpeed.PlayerLogout(aIndex, Name, Account)
	if HANDLES_PLAYER_MOVE[aIndex]
	then
		HANDLES_PLAYER_MOVE[aIndex] = nil
	end
end

function MoveSpeed.PlayerCanMove(aIndex)
	if HANDLES_PLAYER_MOVE[aIndex]
	then
		local player = HANDLES_PLAYER_MOVE[aIndex]
	
		if player.BlockMove == true
		then
			if math.floor(math.abs(GetTick() - player.TimeBlockMove) / 1000) < ANTI_MOVE_SPEED_TIME_BLOCK
			then
				return 1
			else
				player.TimeMove = GetTick()
				player.Moves = 0
				player.BlockMove = false
				player.TimeBlockMove = 0
			end
		end
	end
	
	return
end

function MoveSpeed.PlayerMove(aIndex, map, x, y, sx, sy)
	if not HANDLES_PLAYER_MOVE[aIndex]
	then
		HANDLES_PLAYER_MOVE[aIndex] = {TimeMove = GetTick(), Moves = 0, BlockMove = false, TimeBlockMove = 0}
	else
		local player = HANDLES_PLAYER_MOVE[aIndex]
		
		if player.BlockMove == true
		then
			return
		end
		
		if math.floor(math.abs(GetTick() - player.TimeMove) / 1000) > ANTI_MOVE_SPEED_MAX
		then
			if player.Moves > 1
			then
				player.BlockMove = true
				player.TimeBlockMove = GetTick()
				return
			else
				player.TickTimer = GetTick()
				player.Moves = 0
				player.BlockMove = false
				player.TimeBlockMove = 0
			end
		else
			player.Moves = player.Moves + 1
		end
	end
end

MoveSpeed.Start()

return MoveSpeed