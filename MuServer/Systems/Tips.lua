--[[
Configurações Dicas in-game
]]--

Tips = {}

local TotalTips = 0
local NextTips = 1

function Tips.Init()
	if TIPS_SWITCH == 0
	then
		return
	end
	
	Timer.Interval(TIPS_TIMER_INTERVAL, Tips.DisplayerGame)
	
	local TipFind = 0
	
	for i in pairs(TIPS_CONFIGURATIONS) do
		if TipFind == 1
		then
			break;
		end
		
		for v in pairs(TIPS_CONFIGURATIONS[i]) do
			TotalTips = TotalTips + 1
			TipFind = 1
		end
	end
end

function Tips.DisplayerGame()
	local TipFind = 0
	
	for i in pairs(TIPS_CONFIGURATIONS) do
		if TipFind == 1
		then
			break;
		end
		
		for v in pairs(TIPS_CONFIGURATIONS[i]) do
			if TIPS_CONFIGURATIONS[i][v][1] == NextTips
			then
				if #TIPS_CONFIGURATIONS[i][v][2] > 0
				then
					TipFind = 1
					Message.SendGlobalMultLangTips(TIPS_CONFIGURATIONS, v, 2, TIPS_COLOR)
					break;
				end
			end
		end
	end
	
	NextTips = NextTips + 1
	
	if NextTips > TotalTips
	then
		NextTips = 1
	end
end

Tips.Init()

return Tips