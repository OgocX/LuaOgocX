--[[Moves Customs]]--

MoveSystem = {}

function MoveSystem.CheckMove(aIndex, Command, Arguments)
	if MOVES_CUSTOMS_SWITCH ~= 1
	then
		return 0
	end

	for i in ipairs(MOVES_CUSTOMS) do
		if Command == MOVES_CUSTOMS[i].Move
		then
			local player = User.new(aIndex)
			local Language = player:getLanguage()
			local pInv = Inventory.new(aIndex)
			local Name = player:getName()
			
			local vip = player:getVip()
			local Resets = player:getReset()
			local MResets = player:getMasterReset()

			if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getTeleport() ~= 0 or player:getDieRegen() ~= 0
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][1]), aIndex, 1)
				return 1
			end
		
			if MOVES_CUSTOMS[i].MinLevel ~= -1 and player:getLevel() < MOVES_CUSTOMS[i].MinLevel
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][2], MOVES_CUSTOMS[i].MinLevel), aIndex, 1)
				return 1
			end
			
			if MOVES_CUSTOMS[i].MaxLevel ~= -1 and player:getLevel() > MOVES_CUSTOMS[i].MaxLevel
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][3], MOVES_CUSTOMS[i].MaxLevel), aIndex, 1)
				return 1
			end
			
			if MOVES_CUSTOMS[i].Map == 10 and pInv:isItem(7) == 0
			then
				if pInv:isItem(8) == 0 or pInv:getIndex(8) ~= GET_ITEM(13, 3) and pInv:getIndex(8)
				then
					SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][4]), aIndex, 1)
					return 1
				end
			end
			
			if MOVES_CUSTOMS[i].Map == 7 and pInv:isItem(8) ~= 0
			then
				if pInv:getIndex(8) == GET_ITEM(13, 2) or pInv:getIndex(8) == GET_ITEM(13, 3)
				then
					SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][5]), aIndex, 1)
					return 1
				end
			end
			
			if vip < MOVES_CUSTOMS[i].VipType
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][6]), aIndex, 1)
				return 1
			end
			
			if player:getMoney() < MOVES_CUSTOMS[i].Price
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][7], MOVES_CUSTOMS[i].Price), aIndex, 1)
				return 1
			end
			
			if player:getPKLevel() > 4 and MOVES_CUSTOMS[i].Pk == 0
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][8]), aIndex, 1)
				return 1
			end
			
			if MOVES_CUSTOMS[i].MinReset ~= -1 and Resets < MOVES_CUSTOMS[i].MinReset
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][9], MOVES_CUSTOMS[i].MinReset), aIndex, 1)
				return 1
			end
			
			if MOVES_CUSTOMS[i].MaxReset ~= -1 and Resets > MOVES_CUSTOMS[i].MaxReset
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][10], MOVES_CUSTOMS[i].MaxReset), aIndex, 1)
				return 1
			end
			
			if MOVES_CUSTOMS[i].MinMReset ~= -1 and MResets < MOVES_CUSTOMS[i].MinMReset
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][11], MOVES_CUSTOMS[i].MinMReset), aIndex, 1)
				return 1
			end
			
			if MOVES_CUSTOMS[i].MaxMReset ~= -1 and MResets > MOVES_CUSTOMS[i].MaxMReset
			then
				SendMessage(string.format(MOVE_CUSTOM_MESSAGE[Language][12], MOVES_CUSTOMS[i].MaxMReset), aIndex, 1)
				return 1
			end
			
			local setmoney = player:getMoney() - MOVES_CUSTOMS[i].Price
			player:setMoney(setmoney)
			MoneySend(aIndex)
							
			Teleport(aIndex, MOVES_CUSTOMS[i].Map, MOVES_CUSTOMS[i].CoordX, MOVES_CUSTOMS[i].CoordY)
			return 1
		end
	end
		
	return 0
end

Commands.CallCommand(MoveSystem.CheckMove)

return MoveSystem