PartySearch = {}

--Cache of party
PartySearchList = {}

function PartySearch.GetCountList()
    local count = 0

    for key in pairs(PartySearchList) do
        count = count + 1
    end

    return count
end

function PartySearch.OpenPartyList(player)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    local packetIdentification = string.format("%s_%s",PARTY_SEARCH_PACKET_NAME, player:getName())

    CreatePacket(packetIdentification, PARTY_SEARCH_PACKET)

    SetWordPacket(packetIdentification, PartySearch.GetCountList())

    for key in pairs(PartySearchList) do
        local info = PartySearchList[key]

        SetCharPacketLength(packetIdentification, info.Name, 10)
        SetBytePacket(packetIdentification, info.Map)
        SetBytePacket(packetIdentification, info.X)
        SetBytePacket(packetIdentification, info.Y)
        SetBytePacket(packetIdentification, info.Count)
        SetWordPacket(packetIdentification, info.Level)
        SetBytePacket(packetIdentification, info.OnlyClass)
        SetBytePacket(packetIdentification, info.OnlyGuild)
        SetBytePacket(packetIdentification, info.OnlyAlliance)
        SetBytePacket(packetIdentification, info.ClassSM)
        SetBytePacket(packetIdentification, info.ClassBK)
        SetBytePacket(packetIdentification, info.ClassELF)
        SetBytePacket(packetIdentification, info.ClassMG)
        SetBytePacket(packetIdentification, info.ClassDL)
        SetBytePacket(packetIdentification, info.ClassSUM)
        SetBytePacket(packetIdentification, info.ClassRF)
        local pass = 0
        if #info.Password > 0
        then
            pass = 1
        end
        SetBytePacket(packetIdentification, pass)
    end

    SendPacket(packetIdentification, player:getIndex())

    ClearPacket(packetIdentification)
end

function PartySearch.CreatePartySettings(player, PacketName)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    if player:getPartyNumber() > 0
    then  
        SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][2]), player:getIndex(), 1)
		return
    end

    local PartySearchSwitch = GetBytePacket(PacketName, -1)

    if PartySearchSwitch == 0
    then
        if PartySearchList[player:getName()] ~= nil
        then
            PartySearchList[player:getName()] = nil
        end
        return
    end

    if PartySearchList[player:getName()] ~= nil
    then
        PartySearchList[player:getName()] = nil
    end

    PartySearchList[player:getName()] = { 
        Name = player:getName(),
        Map = player:getMapNumber(),
        X = player:getX(),
        Y = player:getY(),
        Count = 1,
        Level = GetWordPacket(PacketName, -1),
        OnlyClass = GetBytePacket(PacketName, -1),
        OnlyGuild = GetBytePacket(PacketName, -1),
        OnlyAlliance = GetBytePacket(PacketName, -1),
        ClassSM = GetBytePacket(PacketName, -1),
        ClassBK = GetBytePacket(PacketName, -1),
        ClassELF = GetBytePacket(PacketName, -1),
        ClassMG = GetBytePacket(PacketName, -1),
        ClassDL = GetBytePacket(PacketName, -1),
        ClassSUM = GetBytePacket(PacketName, -1),
        ClassRF = GetBytePacket(PacketName, -1),
        Password = GetCharPacketLength(PacketName, -1, 10)
    }

    PartySearch.CreateFile(PartySearchList[player:getName()])
end

function PartySearch.JoinParty(player, PacketName)
    local Language = player:getLanguage()
	
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

    if player:getPartyNumber() > 0
    then  
        SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][2]), player:getIndex(), 1)
		return
    end

    local PartyName = GetCharPacketLength(PacketName, -1, 10)
    local Password = GetCharPacketLength(PacketName, -1, 10)

    if PartyName == player:getName()
    then
        SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][3]), player:getIndex(), 1)
		return
    end

    if PartySearchList[PartyName] == nil
    then
        SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][4]), player:getIndex(), 1)
		return
    end

    local PartyInfo = PartySearchList[PartyName]

    if PartyInfo.Password ~= Password
    then
        SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][7]), player:getIndex(), 1)
		return
    end

    local TargetIndex = GetIndex(PartyName)

    if TargetIndex == -1
	then
		SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][5]), player:getIndex(), 1)
		return
	end

    local target = User.new(TargetIndex)

    if target:getPartyNumber() > 0
    then  
        if player:getPartyNumber() == target:getPartyNumber()
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][6]), player:getIndex(), 1)
            return
        end
    end

    if target:getLevel() > PartyInfo.Level
    then
        SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][12]), player:getIndex(), 1)
            return
    end

    if PartyInfo.OnlyClass == 1
    then
        if player:getClass() ~= target:getClass()
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][8]), player:getIndex(), 1)
            return
        end
        return
    else
        if PartyInfo.ClassSM == 0 and target:getClass() == CLASS_DW
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end

        if PartyInfo.ClassDK == 0 and target:getClass() == CLASS_DK
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end

        if PartyInfo.ClassELF == 0 and target:getClass() == CLASS_FE
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end

        if PartyInfo.ClassMG == 0 and target:getClass() == CLASS_MG
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end

        if PartyInfo.ClassDL == 0 and target:getClass() == CLASS_DL
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end

        if PartyInfo.ClassSUM == 0 and target:getClass() == CLASS_SU
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end

        if PartyInfo.ClassRF == 0 and target:getClass() == CLASS_RF
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][11]), player:getIndex(), 1)
            return
        end
    end

    if PartyInfo.OnlyGuild == 1
    then
        if player:getGuildNumber() ~= target:getGuildNumber()
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][9]), player:getIndex(), 1)
            return
        end
    end

    if PartyInfo.OnlyAlliance == 1
    then
        if GetGuildRelationShip(player:getIndex(), TargetIndex) ~= 1 and player:getGuildNumber() ~= target:getGuildNumber()
        then
            SendMessage(string.format(PARTY_SEARCH_MESSAGES[Language][10]), player:getIndex(), 1)
            return
        end
    end

    if target:getPartyNumber() > 0
    then
        if GetMemberCountParty(target:getPartyNumber()) >= 5
        then
            return
        end
    end

    if (CreateParty(TargetIndex) == 0)
    then
        if AddMemberParty(target:getPartyNumber(), player:getIndex()) == 0
        then
            GCPartyResultSend(player:getIndex(), 2)
            GCPartyResultSend(target:getIndex(), 2)
        else
            PartySearchList[PartyName].Count = GetMemberCountParty(target:getPartyNumber())

            PartySearch.CreateFile(partyInfo)

            if PartySearchList[player:getName()] ~= nil
            then
                PartySearch.DeleteFile(player:getName())
                PartySearchList[player:getName()] = nil
            end
        end
    else
        if AddMemberParty(target:getPartyNumber(), player:getIndex()) == 0
        then
            GCPartyResultSend(player:getIndex(), 2)
            GCPartyResultSend(target:getIndex(), 2)
            DestroyParty(target:getPartyNumber())
        else
            PartySearchList[PartyName].Count = GetMemberCountParty(target:getPartyNumber())

            PartySearch.CreateFile(partyInfo)

            if PartySearchList[player:getName()] ~= nil
            then
                PartySearch.DeleteFile(player:getName())
                PartySearchList[player:getName()] = nil
            end
        end
    end
end

function PartySearch.Protocol(aIndex, Packet, PacketName)
    if Packet == PARTY_SEARCH_PACKET
    then

        local player = User.new(aIndex)

        if string.format("%s_%s",PARTY_SEARCH_PACKET_NAME, player:getName()) == PacketName
        then
            ClearPacket(PacketName)
            PartySearch.OpenPartyList(player)
        elseif string.format("%s_%s",PARTY_SEARCH_PACKET_SETTINGS_NAME, player:getName()) == PacketName
        then
            PartySearch.CreatePartySettings(player, PacketName)
            ClearPacket(PacketName)
        elseif string.format("%s_%s",PARTY_SEARCH_PACKET_JOIN_NAME, player:getName()) == PacketName
        then
            PartySearch.JoinParty(player, PacketName)
            ClearPacket(PacketName)
        end
    end
end

function PartySearch.PlayerLogout(aIndex)
    local player = User.new(aIndex)

    if (PartySearchList[player:getName()] ~= nil)
    then
        PartySearch.DeleteFile(player:getName())
        PartySearchList[player:getName()] = nil
    end

    player = nil
end

function PartySearch.NpcTalk(Npc, Player)
    local npc = User.new(Npc)
    local player = User.new(Player)

    for i = 1, #PARTY_SEARCH_NPC do
        local npcInfo = PARTY_SEARCH_NPC[i]

        if npc:getClass() == npcInfo.Class
        then
            if npc:getMapNumber() == npcInfo.Map and npc:getX() == npcInfo.CoordX and npc:getY() == npcInfo.CoordY
            then
                PartySearch.OpenPartyList(player)
                break
            end
        end
    end

    npc = nil
    player = nil
end

function PartySearch.CreateDiretory()
    os.execute("mkdir ..\\Data\\Scripts\\Cache\\PartySearch")
end

function PartySearch.CreateFile(partyInfo)
    path = "..\\Data\\Scripts\\Cache\\PartySearch\\" .. partyInfo.Name .. ".txt"

    LogAdd(string.format("Here creating file %s", path))

    file = io.open(path, "a")

    writeString = string.format("%s, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %s", 
    partyInfo.Name,partyInfo.Map,partyInfo.X,partyInfo.Y,
    partyInfo.Count,partyInfo.Level,partyInfo.OnlyClass,partyInfo.OnlyGuild,
    partyInfo.OnlyAlliance,partyInfo.ClassSM,partyInfo.ClassBK,partyInfo.ClassELF,partyInfo.ClassMG,partyInfo.ClassDL,
    partyInfo.ClassSUM,partyInfo.ClassRF,partyInfo.Password)

    file:write(writeString, "\n")

    file:close()
end

function PartySearch.DeleteFile(partyName)
    path = "..\\Data\\Scripts\\Cache\\PartySearch\\" .. partyName .. ".txt"

    os.remove(path) 
end

function PartySearch.ProcessCacheFile(path)
    local file = io.open(path, "rb")

    if not file 
    then 
        return 
    end

    local content = file:read "*a"

    file:close()

    --insert in list
    fileArray = {}

    count = 1

    for word in string.gmatch(content, '([^,]+)') do
        fileArray[count] = word
        count = count + 1
    end

    local partyName = tostring(fileArray[1])

    LogAdd(partyName)

    if #partyName > 0
    then
        PartySearchList[partyName] = { 
            Name = partyName,
            Map = tonumber(fileArray[2]),
            X = tonumber(fileArray[3]),
            Y = tonumber(fileArray[4]),
            Count = tonumber(fileArray[5]),
            Level = tonumber(fileArray[6]),
            OnlyClass = tonumber(fileArray[7]),
            OnlyGuild = tonumber(fileArray[8]),
            OnlyAlliance = tonumber(fileArray[9]),
            ClassSM = tonumber(fileArray[10]),
            ClassBK = tonumber(fileArray[11]),
            ClassELF = tonumber(fileArray[12]),
            ClassMG = tonumber(fileArray[13]),
            ClassDL = tonumber(fileArray[14]),
            ClassSUM = tonumber(fileArray[15]),
            ClassRF = tonumber(fileArray[16]),
            Password = tostring(fileArray[17])
        }
    end
end

function PartySearch.LoadCachedInfos()
    local directory = '..\\Data\\Scripts\\Cache\\PartySearch'
    local i, t, popen = 0, {}, io.popen

    for filename in popen('dir "'..directory..'" /b'):lines() do
        PartySearch.ProcessCacheFile(string.format('%s\\%s',directory, filename))
    end
end

function PartySearch.Init()
    if PARTY_SEARCH_SWITCH ~= 1
    then
        return
    end

    PartySearchList = {}

    PartySearch.CreateDiretory()
    PartySearch.LoadCachedInfos()

    GameServerFunctions.GameServerProtocol(PartySearch.Protocol)
    GameServerFunctions.PlayerLogout(PartySearch.PlayerLogout)

    if PARTY_SEARCH_NPC_SWITCH == 1
    then
        GameServerFunctions.NpcTalk(PartySearch.NpcTalk)
    end
end

PartySearch.Init()

return PartySearch