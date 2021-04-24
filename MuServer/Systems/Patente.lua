--[[ Max 15 Patentes ]]--

local PATENTE_PLAYER_INFO = {{MinResets = 0, MaxResets = 20, PatentNumber = 1},
{MinResets = 21, MaxResets = 80, PatentNumber = 2},
{MinResets = 81, MaxResets = 500, PatentNumber = 3},
{MinResets = 501, MaxResets = 50000, PatentNumber = 4},}

local PatentPlayer = {}

function PatentPlayer.SetPatentPlayer(index)
	local player = User.new(index)
	
	local Name = player:getName()
	local Resets = DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name)
	
	for key in ipairs(PATENTE_PLAYER_INFO) do
		info = PATENTE_PLAYER_INFO[key]
		
		if Resets >= info.MinResets and Resets <= info.MaxResets
		then
			if player:getPatent() ~= info.PatentNumber
			then
				player:setPatent(info.PatentNumber)
				return 1
			end
		end
	end
	
	
	
	return
end

function PatentPlayer.UpdateCharacterOnline()
	for i = OBJECT_START_USER, MAX_OBJECT do
		local player = User.new(i)
		
		if player:getConnected() == 3
		then
			if PatentPlayer.SetPatentPlayer(i) == 1
			then
				ViewportCreate(i)
			end
		end
		
		
	end
	
	collectgarbage()
end

PatentPlayer.UpdateCharacterOnline()
Timer.Interval(30 * 60, PatentPlayer.UpdateCharacterOnline)
GameServerFunctions.EnterCharacter(PatentPlayer.SetPatentPlayer)

return PatentPlayer