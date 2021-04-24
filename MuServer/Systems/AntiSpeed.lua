--[[ Anti Speed (BETA) ]]--

AntiSpeed = {}

--[[
Sobre o Anti-Speed:

Eu fiz o mesmo apenas para a SKILL de "Vento ou Fury" do BK!

Caso você saiba mexer pode fazer para outros etc... o limite de 40 Hits foi em meu teste em seu servidor pode ser muito menos ou muito mais!

Não garanto a funcionalidade 100% desse sistema pelo motivo de players possuir velocidades diferentes na internet então existe um "delay".

Mas acredito que vai ajudar um pouco.

Não esqueça caso queira ativar o sistema coloque 1 no SWITCH.
]]--

local ANTI_SPEED_SWITCH = 0
local MAX_HITS_FURY = 40 -- Máximo de hits por segundo com a magia Fury, OBS: você precisa regular para seu servidor.
local BLOCK_TIME_FURY = 5 --Tempo em segundos que vai bloquear o PVP

local UserHandles = {}

function AntiSpeed.CheckUser(aIndex, TargetIndex, MagicNumber)
	local player = User.new(aIndex)
	--local player_target = User.new(TargetIndex)

	if MagicNumber == 43
	then
		if not UserHandles[aIndex]
		then
			UserHandles[aIndex] = {TickTimer = GetTick(), Hits = 0, BlockAttack = false, TimerBlock = GetTick()}
			return
		end
		
		if UserHandles[aIndex].BlockAttack == true
		then
			if math.floor(math.abs(GetTick() - UserHandles[aIndex].TimerBlock) / 1000) < BLOCK_TIME_FURY
			then
				return 1
			else
				UserHandles[aIndex].TickTimer = GetTick()
				UserHandles[aIndex].Hits = 0
				UserHandles[aIndex].BlockAttack = false
				UserHandles[aIndex].TimerBlock = GetTick()
			end
		end
		
		if math.floor(math.abs(GetTick() - UserHandles[aIndex].TickTimer) / 1000) > 1
		then
			if UserHandles[aIndex].Hits > MAX_HITS_FURY
			then
				UserHandles[aIndex].BlockAttack = true
				UserHandles[aIndex].TimerBlock = GetTick()
				
				LogAddC(1, string.format("[%s][%s] Attacking Velocity: %d Suspect!", player:getAccountID(), player:getName(), UserHandles[aIndex].Hits))
				return 1
			else
				UserHandles[aIndex].TickTimer = GetTick()
				UserHandles[aIndex].Hits = 0
				UserHandles[aIndex].BlockAttack = false
				UserHandles[aIndex].TimerBlock = GetTick()
			end
		else
			UserHandles[aIndex].Hits = UserHandles[aIndex].Hits + 1
		end
	end
	
	return
end

function AntiSpeed.PlayerLogout(aIndex, Name, Account)
	if UserHandles[aIndex]
	then
		UserHandles[aIndex] = nil
	end
end

function AntiSpeed.Register()
	if ANTI_SPEED_SWITCH == 0
	then
		return
	end

	GameServerFunctions.RunningSkill(AntiSpeed.CheckUser)
	GameServerFunctions.PlayerLogout(AntiSpeed.PlayerLogout)
end

AntiSpeed.Register()

return AntiSpeed