AutoAddPoints = {}

function AutoAddPoints.AutoCommand(player, arg, type)
	local Language = player:getLanguage()

	if AUTO_ADD_POINT_COMMAND_VIP_SWITCH[player:getVip()] == 0
	then
		SendMessage(string.format(AUTO_ADD_POINTS_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

	local amount = command:getNumber(arg, 2)

    CommandAddPointAuto(player:getIndex(), amount, type)

	if amount > 0
	then
        SendMessage(string.format(AUTO_ADD_POINTS_MESSAGES[Language][2], amount), player:getIndex(), 1)
	else
        SendMessage(string.format(AUTO_ADD_POINTS_MESSAGES[Language][3]), player:getIndex(), 1)
	end
end

return AutoAddPoints