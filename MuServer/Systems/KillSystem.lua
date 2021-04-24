KillSystem = {}

local kills_pks = {}
local kills_heros = {}

function KillSystem.KillPlayer(aIndex, TargetIndex)
	local player = User.new(aIndex)
	local target_player = User.new(TargetIndex)
	
	local Name = player:getName(aIndex)
	
	if player:getPKLevel() >= 4 and target_player:getPKLevel() <= 3
	then
		if has_key(kills_pks, Name) == false
		then
			InsertKey(kills_pks, Name)
			kills_pks[Name] = 1
		else
			kills_pks[Name] = kills_pks[Name] + 1
		end
	elseif player:getPKLevel() <= 2 and target_player:getPKLevel() >= 4
	then
		if has_key(kills_heros, Name) == false
		then
			InsertKey(kills_heros, Name)
			kills_heros[Name] = 1
		else
			kills_heros[Name] = kills_heros[Name] + 1
		end
	end
end

function KillSystem.PlayerLogout(aIndex, Name)
	--Adicionar PK na DB após o player sair
	if has_key(kills_pks, Name) == true
	then
		for i = 0 , #COLUMN_PK do
			DataBase.SetAddValue(TABLE_PK, COLUMN_PK[i], kills_pks[Name], WHERE_PK, Name)
		end
		
		RemoverTable(kills_pks, Name)
	end
	
	--Adicionar Hero na DB após o player sair
	if has_key(kills_heros, Name) == true
	then
		for i = 0 , #COLUMN_HERO do
			DataBase.SetAddValue(TABLE_HERO, COLUMN_HERO[i], kills_heros[Name], WHERE_HERO, Name)
		end
		
		RemoverTable(kills_heros, Name)
	end
end

function KillSystem.PlayerPkClear(aIndex)
	local player = User.new(aIndex)
	
	local Name = player:getName()
	
	--Adicionar PK na DB após o player sair
	if has_key(kills_pks, Name) == true
	then
		for i = 0 , #COLUMN_PK do
			DataBase.SetAddValue(TABLE_PK, COLUMN_PK[i], kills_pks[Name], WHERE_PK, Name)
		end
		
		RemoverTable(kills_pks, Name)
	end
	
	--Adicionar Hero na DB após o player sair
	if has_key(kills_heros, Name) == true
	then
		for i = 0 , #COLUMN_HERO do
			DataBase.SetAddValue(TABLE_HERO, COLUMN_HERO[i], kills_heros[Name], WHERE_HERO, Name)
		end
		
		RemoverTable(kills_heros, Name)
	end
end

GameServerFunctions.PlayerDie(KillSystem.KillPlayer)
GameServerFunctions.PlayerLogout(KillSystem.PlayerLogout)

return KillSystem