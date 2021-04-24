--[[Command: Exchange Coins For Jewels ]]

CommandExchange = {}

function CommandExchange.Exchange(aIndex, Arguments)
	if EXCHANGE_COMMAND_SWITCH == 0
	then
		return
	end

	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if player:getInterfaceUse() > 0 or player:getTeleport() ~= 0 or player:getDieRegen() ~= 0
	then
		SendMessage(string.format(EXCHANGE_MESSAGES[Language][1]), aIndex, 1)
		return 1
	end

	local pInv = Inventory.new(aIndex)
	local String = string.lower(command:getString(Arguments, 1, 0))
	
	for i in ipairs(EXCHANGE_COINS_JEWELS) do
		if String == string.lower(EXCHANGE_COINS_JEWELS[i].String)
		then
			if EXCHANGE_COINS_JEWELS[i].IsJewel == 0
			then
				local CoinType = EXCHANGE_COINS_JEWELS[i].CoinsType
			
				if DataBase.GetValue(EXCHANGE_COMMAND_COIN_TABLE[CoinType], EXCHANGE_COMMAND_COIN_COLUMN[CoinType], EXCHANGE_COMMAND_COIN_WHERE[CoinType], player:getAccountID()) < EXCHANGE_COINS_JEWELS[i].Request
				then
					SendMessage(string.format(EXCHANGE_MESSAGES[Language][1], EXCHANGE_COINS_JEWELS[i].Request, EXCHANGE_COMMAND_COIN_NAME[CoinType], EXCHANGE_COINS_JEWELS[i].TargetName), aIndex, 1)
					return
				end
			else
				local Jewels = 0
				local IsMoreTen = 0
				
				for slot = 12, 75 do
					if pInv:isItem(slot) == 1
					then
						if pInv:getIndex(slot) == GET_ITEM(EXCHANGE_COINS_JEWELS[i].Section, EXCHANGE_COINS_JEWELS[i].Index)
						then
							if pInv:getLevel(slot) == 10
							then
								IsMoreTen = IsMoreTen + 1
							else
								Jewels = Jewels + 1
							end
						end
					end
				end
				
				if Jewels < EXCHANGE_COINS_JEWELS[i].Request
				then
					if IsMoreTen > 0
					then
						if IsMoreTen < math.floor(EXCHANGE_COINS_JEWELS[i].Request / 10)
						then
							SendMessage(string.format(EXCHANGE_MESSAGES[Language][2], EXCHANGE_COINS_JEWELS[i].Name), aIndex, 1)
							return
						end
					else
						SendMessage(string.format(EXCHANGE_MESSAGES[Language][3], EXCHANGE_COINS_JEWELS[i].Name), aIndex, 1)
						return
					end
				end
			end

			for n in ipairs(EXCHANGE_ITENS) do
				if EXCHANGE_ITENS[n].Identification == EXCHANGE_COINS_JEWELS[i].Identification
				then
					if EXCHANGE_ITENS[n].IsJewel == 0
					then
						local DelJewels = 0
						local DelJewelsMoreTen = 0
						
						for slot = 12, 75 do
							if pInv:isItem(slot) == 1
							then
								if pInv:getIndex(slot) == GET_ITEM(EXCHANGE_COINS_JEWELS[i].Section, EXCHANGE_COINS_JEWELS[i].Index)
								then
									if pInv:getLevel(slot) == 10
									then
										if DelJewelsMoreTen < math.floor(EXCHANGE_COINS_JEWELS[i].Request / 10)
										then
											InventoryDeleteItem(aIndex, slot)
											SendInventoryDeleteItem(aIndex, slot)
											
											DelJewelsMoreTen = DelJewelsMoreTen + 1
										end
									else
										if DelJewels < EXCHANGE_COINS_JEWELS[i].Request
										then
											InventoryDeleteItem(aIndex, slot)
											SendInventoryDeleteItem(aIndex, slot)
											
											DelJewels = DelJewels + 1
										end
									end
								end
							end
						end
						
						local CoinTypeExchange = EXCHANGE_ITENS[n].CoinsType
						local Trade = EXCHANGE_ITENS[n].Trade
						
						DataBase.SetAddValue(EXCHANGE_COMMAND_COIN_TABLE[CoinTypeExchange], EXCHANGE_COMMAND_COIN_COLUMN[CoinTypeExchange], Trade, EXCHANGE_COMMAND_COIN_WHERE[CoinTypeExchange], player:getAccountID())
						
						SendMessage(string.format(EXCHANGE_MESSAGES[Language][5], EXCHANGE_COINS_JEWELS[i].Name, EXCHANGE_COINS_JEWELS[i].Request, EXCHANGE_COINS_JEWELS[i].TargetName, Trade), aIndex, 1)
						return
					else
						for loop = 12, 75 do
							if pInv:isItem(loop) ~= 0
							then
								SendMessage(string.format(EXCHANGE_MESSAGES[Language][6]), aIndex, 1)
								return
							end
						end
					
						local CoinType = EXCHANGE_COINS_JEWELS[i].CoinsType
						local Jewels = EXCHANGE_ITENS[n].Trade
						local CreateJewels = math.abs(Jewels / 10)
						
						for loop = 12, 75 do
							if pInv:isItem(loop) == 0
							then
								if CreateJewels >= math.abs(EXCHANGE_COINS_JEWELS[i].Request / 10)
								then
									ItemSerialCreate(aIndex, 236, 0, 0, GET_ITEM(EXCHANGE_ITENS[n].Section, EXCHANGE_ITENS[n].Index), 10, 255, 0, 0, 0, 0)
									
									CreateJewels = CreateJewels - 1
								else
									break
								end
							end
						end
						
						DataBase.SetDecreaseValue(EXCHANGE_COMMAND_COIN_TABLE[CoinType], EXCHANGE_COMMAND_COIN_COLUMN[CoinType], EXCHANGE_COINS_JEWELS[i].Request, EXCHANGE_COMMAND_COIN_WHERE[CoinType], player:getAccountID())
						
						SendMessage(string.format(EXCHANGE_MESSAGES[Language][7], EXCHANGE_COINS_JEWELS[i].Name, EXCHANGE_COINS_JEWELS[i].Request, EXCHANGE_COINS_JEWELS[i].TargetName, Jewels), aIndex, 1)
						return
					end
				end
			end
		end
	end
	
	SendMessage(string.format(EXCHANGE_MESSAGES[Language][8]), aIndex, 1)
	
	pInv = nil
	
end

Commands.Register(EXCHANGE_COMMAND, CommandExchange.Exchange)

return CommandExchange