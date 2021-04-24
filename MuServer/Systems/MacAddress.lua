RegisterHWID = {}

function RegisterHWID.MacAddressPlayer(aIndex, Mac)
	local player = User.new(aIndex)
	
	DataBase.SetString('MEMB_STAT', 'HWID', Mac, 'memb___id', player:getAccountID())
end

GameServerFunctions.MacAddressPlayer(RegisterHWID.MacAddressPlayer)

return RegisterHWID