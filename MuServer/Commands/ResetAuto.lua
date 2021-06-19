ResetAuto = {}

function ResetAuto.Command(aIndex, Arguments)
    local player = User.new(aIndex)
	local Language = player:getLanguage()

    if AUTO_RESET_COMMAND_ACTIVE_VIP[player:getVip()] == 0
    then
        SendMessage(string.format(AUTO_RESET_COMMAND_MESSAGES[Language][1]), aIndex, 1)
		return
    end
	
	if player:getReset() < AUTO_RESET_RESETS
	then
		SendMessage(string.format(AUTO_RESET_COMMAND_MESSAGES[Language][2], AUTO_RESET_RESETS), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < AUTO_RESET_MRESETS
	then
		SendMessage(string.format(AUTO_RESET_COMMAND_MESSAGES[Language][3], AUTO_RESET_MRESETS), aIndex, 1)
		return
	end

    if player:getAutoResetEnable() == 0
	then
		player:setAutoResetEnable(1)

		player:setAutoResetStats(0, command:getNumber(Arguments, 1))
		player:setAutoResetStats(1, command:getNumber(Arguments, 2))
		player:setAutoResetStats(2, command:getNumber(Arguments, 3))
		player:setAutoResetStats(3, command:getNumber(Arguments, 4))

        if player:getClass() == CLASS_DL
        then
		    player:setAutoResetStats(4, command:getNumber(Arguments, 5))
        else
            player:setAutoResetStats(4, 0)
        end

		SendMessage(string.format(AUTO_RESET_COMMAND_MESSAGES[Language][4], AUTO_RESET_MRESETS), aIndex, 1)
    else
		player:setAutoResetEnable(0)

		player:setAutoResetStats(0, 0)
		player:setAutoResetStats(1, 0)
		player:setAutoResetStats(2, 0)
		player:setAutoResetStats(3, 0)
		player:setAutoResetStats(4, 0)

		SendMessage(string.format(AUTO_RESET_COMMAND_MESSAGES[Language][5], AUTO_RESET_MRESETS), aIndex, 1)
	end
end

function ResetAuto.ConvertReturn(x, y)
    if x > 0
    then
        return (y + 1)
    end

    return y
end

function ResetAuto.PlayerProc(aIndex)
    local player = User.new(aIndex)

    local vip = player:getVip()
			
    if RESET_TYPE == 0
    then
        local level = RESET_ACUMULATIVE_LEVEL[vip]
            
        if player:getLevel() >= level
        then
            local ret = Reset.Acumulative(player)

            if ret == 1
            then
                player:setAutoAddPointCount(0)
                player:setAutoAddPointStats(0, player:getAutoResetStats(0))
                player:setAutoAddPointStats(1, player:getAutoResetStats(1))
                player:setAutoAddPointStats(2, player:getAutoResetStats(2))
                player:setAutoAddPointStats(3, player:getAutoResetStats(3))
                player:setAutoAddPointStats(4, player:getAutoResetStats(4))

                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(0), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(1), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(2), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(3), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(4), player:getAutoAddPointCount()))

                CommandAddPointAutoProc(aIndex)
            end
        end
    elseif RESET_TYPE == 1
    then
        local level = Reset.Tabulated_GetResetLevel(player:getReset(), player:getVip())

        if player:getLevel() >= level
        then
            local ret = Reset.Tabulated(player)

            if ret == 1
            then
                player:setAutoAddPointCount(0)
                player:setAutoAddPointStats(0, player:getAutoResetStats(0))
                player:setAutoAddPointStats(1, player:getAutoResetStats(1))
                player:setAutoAddPointStats(2, player:getAutoResetStats(2))
                player:setAutoAddPointStats(3, player:getAutoResetStats(3))
                player:setAutoAddPointStats(4, player:getAutoResetStats(4))

                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(0), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(1), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(2), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(3), player:getAutoAddPointCount()))
                player:setAutoAddPointCount(ResetAuto.ConvertReturn(player:getAutoAddPointStats(4), player:getAutoAddPointCount()))

                CommandAddPointAutoProc(aIndex)
            end
        end
    end

    player = nil
end

function ResetAuto.Init()
    if AUTO_RESET_SWITCH ~= 1
    then
        return
    end

    Commands.Register(AUTO_RESET_COMMAND, ResetAuto.Command)
end

ResetAuto.Init()

function AutoResetPlayerProc(aIndex)
    ResetAuto.PlayerProc(aIndex)
end

return ResetAuto