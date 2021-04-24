--[[Player Logout]]--

PlayerLoggout = {}

function PlayerLoggout.Loggout(aIndex, Name, Account)
	if STAFF_LEFT_SWITCH == 1
	then
		local player = User.new(aIndex)
		local Language = player:getLanguage()
		
		if player:getAuthority() ~= 1
		then
			Message.SendGlobalMultLangeDirect(STAFF_LEFT_STRING, STAFF_LEFT_TYPE, Name)
		end
		
		
	end
end

GameServerFunctions.PlayerLogout(PlayerLoggout.Loggout)

return PlayerLoggout