--[[Map System]]--

MapSystem = {}

local MAP_SYSTEM_SWITCH = 1

--[[
-- 1 Não pode
-- 0 Pode
--]]

local CONFIG_MAPS = {
{MapNumber = 0, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 1, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 2, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 3, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 4, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 5, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 6, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 7, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 8, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 9, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 10, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 11, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 12, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 13, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 14, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 15, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 16, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 17, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 18, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 19, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
{MapNumber = 20, BlockPvP = 0, BlockTrade = 0, UpSystem = 0, Reflet = 0, War = 0},
}

function MapSystem.Init()
	if MAP_SYSTEM_SWITCH == 0
	then
		return
	end
	
	--Detect Attack MapSystem
	GameServerFunctions.PlayerAttack(MapSystem.CanAttack)
	--Detect Send Trade
	GameServerFunctions.PlayerSendTrade(MapSystem.CanUseTrade)
	--Detect Up
	GameServerFunctions.PlayerLevelUp(MapSystem.CanUp)
	--Detect Send Reflet
	GameServerFunctions.BlockReflet(MapSystem.Reflet)
	--Detect Send War
	GameServerFunctions.DeclareWar(MapSystem.DeclareWar)
end

function MapSystem.CanAttack(aIndex, TargetIndex)
	local player = User.new(aIndex)
	local UserMap = player:getMapNumber()

	for i in ipairs(CONFIG_MAPS) do
		if CONFIG_MAPS[i].MapNumber == UserMap
		then
			if CONFIG_MAPS[i].BlockPvP == 1
			then
				return 1
			end
		end
	end
	
	return
end

function MapSystem.CanUp(aIndex)
	local player = User.new(aIndex)
	local UserMap = player:getMapNumber()

	for i in ipairs(CONFIG_MAPS) do
		if CONFIG_MAPS[i].MapNumber == UserMap
		then
			if CONFIG_MAPS[i].UpSystem == 1
			then
				return 1
			end
		end
	end
	
	return
end

function MapSystem.CanUseTrade(aIndex, TargetIndex)
	local player = User.new(aIndex)
	local UserMap = player:getMapNumber()

	for i in ipairs(CONFIG_MAPS) do
		if CONFIG_MAPS[i].MapNumber == UserMap
		then
			if CONFIG_MAPS[i].BlockTrade == 1
			then
				return 1
			end
		end
	end
	
	return
end

function MapSystem.Reflet(aIndex)
	local player = User.new(aIndex)
	local UserMap = player:getMapNumber()

	for i in ipairs(CONFIG_MAPS) do
		if CONFIG_MAPS[i].MapNumber == UserMap
		then
			if CONFIG_MAPS[i].Reflet == 1
			then
				return 1
			end
		end
	end
	
	return
end

function MapSystem.DeclareWar(aIndex)
	local player = User.new(aIndex)
	local UserMap = player:getMapNumber()

	for i in ipairs(CONFIG_MAPS) do
		if CONFIG_MAPS[i].MapNumber == UserMap
		then
			if CONFIG_MAPS[i].War == 1
			then
				return 1
			end
		end
	end
	
	return
end

MapSystem.Init()

return MapSystem