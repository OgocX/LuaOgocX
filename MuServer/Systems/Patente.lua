--[[ Max 15 Patentes ]]--
local PATENT_SWITCH = 0

--PatentType , 0 = TGA , 1 = Model
--PatentNumber, Start on 1 in bouth model and tga

local PATENTE_PLAYER_INFO = {

{MinResets = 0, MaxResets = 20, PatentNumber = 1, PatentType = 1},
{MinResets = 21, MaxResets = 80, PatentNumber = 1, PatentType = 0},
{MinResets = 81, MaxResets = 500, PatentNumber = 2, PatentType = 0},
{MinResets = 501, MaxResets = 50000, PatentNumber = 3, PatentType = 0},

}

local PatentPlayer = {}

function PatentPlayer.SetPatentPlayer(index)
	local player = User.new(index)
	
	local Name = player:getName()
	local Resets = player:getReset()
	
	for key in ipairs(PATENTE_PLAYER_INFO) do
		info = PATENTE_PLAYER_INFO[key]
		
		if Resets >= info.MinResets and Resets <= info.MaxResets
		then
			if player:getPatent() ~= info.PatentNumber
			then
				player:setPatent(info.PatentNumber)
				player:setPatentType(info.PatentType)
				return 1
			end
		end
	end
	
	return 0
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

function PatentPlayer.Init()
	if PATENT_SWITCH == 0
	then
		return
	end
	
	PatentPlayer.UpdateCharacterOnline()
	Timer.Interval(30 * 60, PatentPlayer.UpdateCharacterOnline)
	GameServerFunctions.EnterCharacter(PatentPlayer.SetPatentPlayer)
end

PatentPlayer.Init()

return PatentPlayer