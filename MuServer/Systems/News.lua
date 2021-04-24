--[[
Configurações News
]]--

News = {}

local TotalNews = 0
local NextNews = 1

function News.Start()
	if NEWS_SWITCH == 0
	then
		return
	end
	
	Timer.Interval(NEWS_TIMER_INTERVAL, News.DisplayerGame)

	local TipFind = 0
	
	for i in pairs(NEWS_CONFIGURATIONS) do
		if TipFind == 1
		then
			break;
		end
		
		for v in pairs(NEWS_CONFIGURATIONS[i]) do
			TotalNews = TotalNews + 1
			TipFind = 1
		end
	end
end

function News.DisplayerGame()
	local NewsFind = 0
	
	for i in pairs(NEWS_CONFIGURATIONS) do
		if NewsFind == 1
		then
			break;
		end
		
		for v in pairs(NEWS_CONFIGURATIONS[i]) do
			if NEWS_CONFIGURATIONS[i][v][1] == NextNews
			then
				Message.SendGlobalMultLangTips(NEWS_CONFIGURATIONS, v, 2, 0)
				Message.SendGlobalMultLangTips(NEWS_CONFIGURATIONS, v, 3, 0)
				Message.SendGlobalMultLangTips(NEWS_CONFIGURATIONS, v, 4, 0)
				Message.SendGlobalMultLangTips(NEWS_CONFIGURATIONS, v, 5, 0)
				Message.SendGlobalMultLangTips(NEWS_CONFIGURATIONS, v, 6, 0)
				NewsFind = 1
				break;
			end
		end
	end
	
	NextNews = NextNews + 1
	
	if NextNews > TotalNews
	then
		NextNews = 1
	end
end

News.Start()

return News