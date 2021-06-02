StoreSearch = {}

function StoreSearch.OpenList(player)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    StoreSearch.SendStoreList(player)
end

function StoreSearch.GetItemListFromPlayer(player, PacketName)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    local NameTarget = GetCharPacketLength(PacketName, -1, 10)
    local CheckTargetIndex = GetWordPacket(PacketName, -1)

    ClearPacket(PacketName)

    local TargetIndex = GetIndex(NameTarget)

    if TargetIndex == -1
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][2]), player:getIndex(), 1)
        return
    end

    if CheckTargetIndex ~= TargetIndex
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][3]), player:getIndex(), 1)
        return
    end

    local target_player = User.new(TargetIndex)

    if target_player:getShopOpen() ~= 1
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][4]), player:getIndex(), 1)
        return
    end

    StoreSearch.SendListItem(player, target_player)

    target_player = nil
end

function StoreSearch.SendStoreList(player)
    local count = 0
    local StoreList = {}

    for i = OBJECT_START_USER, MAX_OBJECT do
        if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end

        if i == player:getIndex()
        then
            goto continue
        end
		
		local target_player = User.new(i)
		
		if target_player:getConnected() < 3
		then
			goto continue
		end

        if target_player:getShopOpen() == 0
        then
            goto continue
        end

        StoreList[count] = { StoreDescription = target_player:getPShopText(), StoreOwner = target_player:getName(), StoreIdentification = i }
        count = count + 1

        target_player = nil

        ::continue::
    end

    local packetIdentification = string.format("%s_%s",STORE_SEARCH_PACKET_NAME, player:getName())
    CreatePacket(packetIdentification, STORE_SEARCH_PACKET)
    SetWordPacket(packetIdentification, count)

    if count > 0
    then
        for n = 0, #StoreList do
            SetCharPacketLength(packetIdentification, StoreList[n].StoreDescription, 36)
            SetCharPacketLength(packetIdentification, StoreList[n].StoreOwner, 10)
            SetWordPacket(packetIdentification, StoreList[n].StoreIdentification)
        end
    end

    SendPacket(packetIdentification, player:getIndex())

    ClearPacket(packetIdentification)
end

function StoreSearch.SendListItem(player, target_player)
    local ItemList = {}
    local count = 0

    local packetIdentification = string.format("%s_%s",STORE_SEARCH_ITEM_LIST_PACKET_NAME, player:getName())

    CreatePacket(packetIdentification, STORE_SEARCH_PACKET)

    SetWordPacket(packetIdentification, target_player:getIndex())

    local tInv = Inventory.new(target_player:getIndex())

    for i = 0, 31 do
        local slot = 204 + i
        if tInv:isItem(slot) ~= 0
        then
            ItemList[count] = { Slot = slot, Coin1 = tInv:getPersonalShopCoin1(slot), Coin2 = tInv:getPersonalShopCoin2(slot), Coin3 = tInv:getPersonalShopCoin3(slot), Coin4 = tInv:getPersonalShopCoin4(slot)
            , Zen = tInv:getZenValue(slot), ItemIndex = tInv:getIndex(slot), Level = tInv:getLevel(slot), Op1 = tInv:getItemTable(slot, 2), Op2 = tInv:getItemTable(slot, 3), Op3 = tInv:getItemTable(slot, 4), Exc = tInv:getItemTable(slot, 1)
			, Ancient = tInv:getItemTable(slot, 5), JoH = tInv:getItemTable(slot, 6), SockCount = tInv:getItemTable(slot, 8), Sock1 = tInv:getItemTable(slot, 9), Sock2 = tInv:getItemTable(slot, 10), Sock3 = tInv:getItemTable(slot, 11), Sock4 = tInv:getItemTable(slot, 12), Sock5 = tInv:getItemTable(slot, 13) }

            count = count + 1
        end
    end

    SetWordPacket(packetIdentification, count)

    if count > 0
    then
        for n = 0, #ItemList do
            SetBytePacket(packetIdentification, ItemList[n].Slot)
            SetDwordPacket(packetIdentification, ItemList[n].Coin1)
            SetDwordPacket(packetIdentification, ItemList[n].Coin2)
            SetDwordPacket(packetIdentification, ItemList[n].Coin3)
            SetDwordPacket(packetIdentification, ItemList[n].Coin4)
            SetDwordPacket(packetIdentification, ItemList[n].Zen)
            SetWordPacket(packetIdentification, ItemList[n].ItemIndex)
            SetBytePacket(packetIdentification, ItemList[n].Level)
            SetBytePacket(packetIdentification, ItemList[n].Op1)
            SetBytePacket(packetIdentification, ItemList[n].Op2)
            SetBytePacket(packetIdentification, ItemList[n].Op3)
            SetBytePacket(packetIdentification, ItemList[n].Exc)
            SetBytePacket(packetIdentification, ItemList[n].Ancient)
            SetBytePacket(packetIdentification, ItemList[n].JoH)
            SetBytePacket(packetIdentification, ItemList[n].SockCount)
            SetBytePacket(packetIdentification, ItemList[n].Sock1)
            SetBytePacket(packetIdentification, ItemList[n].Sock2)
            SetBytePacket(packetIdentification, ItemList[n].Sock3)
            SetBytePacket(packetIdentification, ItemList[n].Sock4)
            SetBytePacket(packetIdentification, ItemList[n].Sock5)
        end
    end

    SendPacket(packetIdentification, player:getIndex())

    ClearPacket(packetIdentification)
end

function StoreSearch.BuyItemFromPlayer(player, PacketName)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    local TargetIndex = GetWordPacket(PacketName, -1)
    local SlotItem = GetBytePacket(PacketName, -1)

    if TargetIndex < OBJECT_START_USER and TargetIndex > MAX_OBJECT
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][2]), player:getIndex(), 1)
		return
    end

    if (SlotItem < 204 and SlotItem > 236)
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][5]), player:getIndex(), 1)
		return
    end

    local target_player = User.new(TargetIndex)
    local tInv = Inventory.new(TargetIndex)

    if target_player:getConnected() < 3
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][2]), player:getIndex(), 1)
		return
    end

    if target_player:getShopOpen() ~= 1
    then
        SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][4]), player:getIndex(), 1)
        return
    end

    PersonalShopBuyItem(player:getIndex(), TargetIndex, target_player:getName(), SlotItem)

    StoreSearch.SendListItem(player, target_player)

    StoreSearch.SendStoreList(player)

    target_player = nil
    tInv = nil
end

function StoreSearch.ContainsWholeWord(w, s)
    return select(2,s:gsub('^' .. w .. '%W+','')) +
         select(2,s:gsub('%W+' .. w .. '$','')) +
         select(2,s:gsub('^' .. w .. '$','')) +
         select(2,s:gsub('%W+' .. w .. '%W+','')) > 0
end

function StoreSearch.FindItemStore(player, PacketName)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(STORE_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    local TextItemFind = string.lower(GetCharPacketLength(PacketName, -1, 30))

    ClearPacket(PacketName)

    local count = 0
    local ItemList = {}

    for i = OBJECT_START_USER, MAX_OBJECT do
        if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end

        if i == player:getIndex()
        then
            goto continue
        end
		
		local target_player = User.new(i)
		
		if target_player:getConnected() < 3
		then
			goto continue
		end

        if target_player:getShopOpen() == 0
        then
            goto continue
        end

        local tInv = Inventory.new(i)

        for n = 0, 31 do
            local slot = 204 + n
            if tInv:isItem(slot) ~= 0
            then
                local ItemName = string.lower(tInv:getName(slot))

                if (StoreSearch.ContainsWholeWord(TextItemFind, ItemName) ~= nil) == true
                then
                    ItemList[count] = { Name = target_player:getName(), Slot = slot, Coin1 = tInv:getPersonalShopCoin1(slot), Coin2 = tInv:getPersonalShopCoin2(slot), Coin3 = tInv:getPersonalShopCoin3(slot), Coin4 = tInv:getPersonalShopCoin4(slot)
                    , Zen = tInv:getZenValue(slot), ItemIndex = tInv:getIndex(slot), Level = tInv:getLevel(slot), Op1 = tInv:getItemTable(slot, 2), Op2 = tInv:getItemTable(slot, 3), Op3 = tInv:getItemTable(slot, 4), Exc = tInv:getItemTable(slot, 1)
                    , Ancient = tInv:getItemTable(slot, 5), JoH = tInv:getItemTable(slot, 6), SockCount = tInv:getItemTable(slot, 8), Sock1 = tInv:getItemTable(slot, 9), Sock2 = tInv:getItemTable(slot, 10), Sock3 = tInv:getItemTable(slot, 11), Sock4 = tInv:getItemTable(slot, 12), Sock5 = tInv:getItemTable(slot, 13) }
        
                    count = count + 1

                    if count >= 120
                    then
                        break
                    end
                end
            end
        end

        tInv = nil
        target_player = nil

        if count >= 120
        then
            break
        end

        ::continue::
    end

    local packetIdentification = string.format("%s_%s",STORE_SEARCH_PACKET_FIND_ITEM_NAME, player:getName())
    CreatePacket(packetIdentification, STORE_SEARCH_PACKET)

    SetWordPacket(packetIdentification, count)

    if count > 0
    then
        for n = 0, #ItemList do
            SetCharPacketLength(packetIdentification, ItemList[n].Name, 10)
            SetBytePacket(packetIdentification, ItemList[n].Slot)
            SetDwordPacket(packetIdentification, ItemList[n].Coin1)
            SetDwordPacket(packetIdentification, ItemList[n].Coin2)
            SetDwordPacket(packetIdentification, ItemList[n].Coin3)
            SetDwordPacket(packetIdentification, ItemList[n].Coin4)
            SetDwordPacket(packetIdentification, ItemList[n].Zen)
            SetWordPacket(packetIdentification, ItemList[n].ItemIndex)
            SetBytePacket(packetIdentification, ItemList[n].Level)
            SetBytePacket(packetIdentification, ItemList[n].Op1)
            SetBytePacket(packetIdentification, ItemList[n].Op2)
            SetBytePacket(packetIdentification, ItemList[n].Op3)
            SetBytePacket(packetIdentification, ItemList[n].Exc)
            SetBytePacket(packetIdentification, ItemList[n].Ancient)
            SetBytePacket(packetIdentification, ItemList[n].JoH)
            SetBytePacket(packetIdentification, ItemList[n].SockCount)
            SetBytePacket(packetIdentification, ItemList[n].Sock1)
            SetBytePacket(packetIdentification, ItemList[n].Sock2)
            SetBytePacket(packetIdentification, ItemList[n].Sock3)
            SetBytePacket(packetIdentification, ItemList[n].Sock4)
            SetBytePacket(packetIdentification, ItemList[n].Sock5)
        end
    end

    SendPacket(packetIdentification, player:getIndex())

    ClearPacket(packetIdentification)
end

function StoreSearch.BuyItemFind(player, PacketName)

end

function StoreSearch.Protocol(aIndex, Packet, PacketName)
    if Packet == STORE_SEARCH_PACKET
    then
        local player = User.new(aIndex)

        if string.format("%s_%s",STORE_SEARCH_PACKET_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            StoreSearch.OpenList(player)
        elseif string.format("%s_%s",STORE_SEARCH_ITEM_LIST_PACKET_NAME, player:getName()) == PacketName
        then
            StoreSearch.GetItemListFromPlayer(player, PacketName)
            ClearPacket(PacketName)
        elseif string.format("%s_%s",STORE_SEARCH_ITEM_BUY_PACKET_NAME, player:getName()) == PacketName
        then
            StoreSearch.BuyItemFromPlayer(player, PacketName)
            ClearPacket(PacketName)
        elseif string.format("%s_%s",STORE_SEARCH_PACKET_FIND_ITEM_NAME, player:getName()) == PacketName
        then
            StoreSearch.FindItemStore(player, PacketName)
            ClearPacket(PacketName)
        elseif string.format("%s_%s",STORE_SEARCH_PACKET_BUY_FIND_ITEM_NAME, player:getName()) == PacketName
        then
            StoreSearch.BuyItemFind(player, PacketName)
            ClearPacket(PacketName)
        end

        player = nil
    end
end

function StoreSearch.Init()
    if STORE_SEARCH_SWITCH ~= 1
    then
        return
    end

    GameServerFunctions.GameServerProtocol(StoreSearch.Protocol)
end

StoreSearch.Init()

return StoreSearch