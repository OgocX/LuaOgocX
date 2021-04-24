--[[Trade System]]--

TradeSystem = {}

local TRADE_SYSTEM_SWITCH = 0
local CONFIG_ITEMS_TRADE = {
{ItemSection = 0, ItemIndex = 0, Level = -1},
}

function TradeSystem.CheckItens(aIndex)
	if TRADE_SYSTEM_SWITCH == 0
	then
		return
	end
	
	local pTrade = Trade.new(aIndex)

	for i = 0, 31 do
		if pTrade:isItem(i) ~= 0
		then
			for n in ipairs(CONFIG_ITEMS_TRADE) do
				if pTrade:getIndex(i) == GET_ITEM(CONFIG_ITEMS_TRADE[n].ItemSection, CONFIG_ITEMS_TRADE[n].ItemIndex)
				then
					if CONFIG_ITEMS_TRADE[n].Level == -1 or pTrade:getLevel(i) == CONFIG_ITEMS_TRADE[n].Level
					then
						return 1
					end
				end
			end
		end
	end
	
	return
end

function TradeSystem.TradeOK(aIndex, TargetIndex)
	if TradeSystem.CheckItens(aIndex) == 1 or TradeSystem.CheckItens(TargetIndex) == 1
	then
		SendMessage(string.format("[Sistema] Troca deste item bloqueada pelo Administrador!"), aIndex, 1)
		SendMessage(string.format("[Sistema] Troca deste item bloqueada pelo Administrador!"), TargetIndex, 1)
		return 1
	end
	
	return
end

GameServerFunctions.PlayerTradeOk(TradeSystem.TradeOK)

return TradeSystem