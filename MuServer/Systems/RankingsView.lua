--[[System Ranking View]]--

RankingsView = {}

local RANKING_VIEW_SWITCH = 0
local RANKING_VIEW_MINUTES = 5 -- A X minutos vai aparecer no global ranking...
local RANKING_VIEW_INFOS = {{Ranking_Value = 1, Ranking_Name = "Top 3 Resets", Ranking_Table = "Character", Ranking_Column = "Resets", Ranking_User = "Name", Ranking_Type = "DESC", Ranking_Count = 3},
{Ranking_Value = 2, Ranking_Name = "Top 3 M.Resets", Ranking_Table = "Character", Ranking_Column = "MResets", Ranking_User = "Name", Ranking_Type = "DESC", Ranking_Count = 3},}

--Variáveis do sistema não mexa!
local RANKING_VIEW_COUNTS = 0
local RANKING_VIEW_NEXT = 1

function RankingsView.PrintRankings()
	if RANKING_VIEW_SWITCH == 0
	then
		return
	end
	
	for i in ipairs(RANKING_VIEW_INFOS) do
		if RANKING_VIEW_INFOS[i].Ranking_Value == RANKING_VIEW_NEXT
		then
			local Query = string.format("SELECT TOP %d %s, %s FROM %s ORDER BY %s %s", RANKING_VIEW_INFOS[i].Ranking_Count, RANKING_VIEW_INFOS[i].Ranking_Column, RANKING_VIEW_INFOS[i].Ranking_User, RANKING_VIEW_INFOS[i].Ranking_Table, RANKING_VIEW_INFOS[i].Ranking_Column, RANKING_VIEW_INFOS[i].Ranking_Type)
			local ret = DataBaseExec(Query)
			
			if ret == 0
			then
				LogAddC(2,string.format("Não foi possível executar a query: %s", Query))
				DataBaseClear()
				return
			end
			
			SendMessageGlobal(string.format("==================="), 0)
			SendMessageGlobal(string.format("%s", RANKING_VIEW_INFOS[i].Ranking_Name), 0)
			
			local Ranking = 1

			while Ranking do
				local nFecth = DataBaseFetch()
				
				if nFecth == SQL_NO_DATA
				then
					break
				end
				
				SendMessageGlobal(string.format("%dº %s - (%d)", Ranking, DataBaseGetStr(RANKING_VIEW_INFOS[i].Ranking_User), DataBaseGetInt(RANKING_VIEW_INFOS[i].Ranking_Column)), 0)
				
				Ranking = Ranking + 1
			end
			
			SendMessageGlobal(string.format("==================="), 0)
			
			DataBaseClear()
		end
	end
	
	RANKING_VIEW_NEXT = RANKING_VIEW_NEXT + 1
	
	if RANKING_VIEW_NEXT > RANKING_VIEW_COUNTS
	then
		RANKING_VIEW_NEXT = 1
	end
end

function RankingsView.Init()
	if RANKING_VIEW_SWITCH == 0
	then
		return
	end
	
	RANKING_VIEW_COUNTS = CountTable(RANKING_VIEW_INFOS)

	Timer.Interval(RANKING_VIEW_MINUTES * 60, RankingsView.PrintRankings)
end

RankingsView.Init()

return RankingsView