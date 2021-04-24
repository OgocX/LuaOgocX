--[[ BootSystem ]]--

BootSystem = {}

BOOT_SYSTEM_SWITCH = 0

--[[

Sobre o sistema:

Esse sistema apenas coloca personagens online, ele vai ficar logado no lugar onde a conta esta registrada na Character, caso tenha item vai aparecer etc...

E um sistema de "Boot", você precisa colocar contas existentes na "InjectPlayers", você pode configurar as contas com itens etc e colocar para logar no mesmo.

O limite de contas e o limite de usuários online da licença.

O sistema aceita /move, caso você esteja com o char STAFF e utilizar o move nele vai funcionar...
--]]

--Obs: Adicione aqui apenas personagens que exista na Character, AccountCharacter etc...
InjectPlayers = {{Account = "ogocx", Password = "1", Character = "Ogoc"},}

local BotHandles = {}

function BootSystem.Add(index, account, password, name)
	gObjAdd(0, "127.0.0.1", index)
	
	local player = User.new(index)
	
	player:setLoginMessageSend(1)

	player:setLoginMessageCount(1)

	player:setCheckSumTime(GetTick())
	
	player:setConnectCheckTime(GetTick())

	AccountInfoSend(index, account, password)

	Timer.TimeOut(2, BootSystem.AddCharacter, index, account, password, name)

	BotHandles[index] = {aIndex = index}
end

function BootSystem.AddCharacter(index, account, password, name)
	local player = Player.new(index)

	if player:getConnected() ~= 2
	then
		gObjDel(index)
		BotHandles[index] = nil
		LogAddC(2, string.format("Não foi possível criar o Boot [%s]", name))
		return
	end

	CharacterInfoSend(index, name, account)
end

function BootSystem.GetSlot()
	return SearchIndex(0, "127.0.0.1")
end

function BootSystem.Checking()
	for i = OBJECT_START_USER, MAX_OBJECT do
		local player = User.new(i)
		
		if player:getConnected() == 3
		then
			if BotHandles[i]
			then
				player:setCheckSumTime(GetTick())
				player:setConnectCheckTime(GetTick())
			end
		end
	end
end

function BootSystem.CharacterMove(aIndex, map, x, y)
	if BotHandles[aIndex]
	then
		local player = User.new(aIndex)
		
		player:setX(x)
		
		player:setTX(x)
		
		player:setY(y)
		
		player:setTY(y)
		
		player:setMapNumber(map)
		
		player:setTeleport(0)
		
		player:setPathCount(0)
		
		player:setRegenMapNumber(map)
		
		player:setRegenMapX(x)
		
		player:setRegenMapY(y)
		
		player:setRegen(0)
		
		ViewportCreate(aIndex)
		return 1
	end
	
	return
end

function BootSystem.ClearBoot()
	for i = OBJECT_START_USER, MAX_OBJECT do
		local player = User.new(i)
		if player:getConnected() ~= 0
		then
			for n in ipairs(InjectPlayers) do
				if InjectPlayers[n].Account == player:getAccountID()
				then
					gObjDel(i)
				end
			end
		end
	end
end

function BootSystem.CreateBoot()
	Timer.Interval(1, BootSystem.Checking)

	for i in ipairs(InjectPlayers) do
		local index = BootSystem.GetSlot()
	
		if index ~= -1
		then
			BootSystem.Add(index, InjectPlayers[i].Account, InjectPlayers[i].Password, InjectPlayers[i].Character)
		end
	end
end

function BootSystem.IsBoot(aIndex)
	for i in pairs(BotHandles) do
		if BotHandles[i].aIndex == aIndex
		then
			return 1
		end
	end
	
	return -1
end

function BootSystem.Start()
	if BOOT_SYSTEM_SWITCH == 0
	then
		return
	end

	BootSystem.ClearBoot()
	BootSystem.CreateBoot()
end

Timer.TimeOut(2, BootSystem.Start)
GameServerFunctions.CharacterMove(BootSystem.CharacterMove)

return BootSystem