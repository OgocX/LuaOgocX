Message = { }

function Message.SendMessageGlobalMultLang(messageSource, messageKey, messageType)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		local player = User.new(i)
		
		if player:getConnected() < 3
		then
			goto continue
		end
		
		local Language = player:getLanguage()
		
		if #Language <= 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, messageType, messageSource[Language][messageKey])
		
		player = nil
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendMessageGlobalMultLangArgs(messageSource, messageKey, messageType, ...)
	local arg = {...}
	
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		local player = User.new(i)
		
		if player:getConnected() < 3
		then
			goto continue
		end
		
		local Language = player:getLanguage()
		
		if #Language <= 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, messageType, string.format(messageSource[Language][messageKey], unpack(arg)))
		
		player = nil
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendGlobalMultLangeDirect(messageSource, messageType, ...)
	local arg = {...}
	
	local unpack_arg = unpack(arg)
	
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		local player = User.new(i)
		
		if player:getConnected() < 3
		then
			goto continue
		end
		
		local Language = player:getLanguage()
		
		if #Language <= 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, messageType, string.format(messageSource[Language], unpack_arg))
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendGlobalMultLangTips(messageSource, messageKey, messageSecondKey, messageType)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		local player = User.new(i)
		
		if player:getConnected() < 3
		then
			goto continue
		end
		
		local Language = player:getLanguage()
		
		if #Language <= 0
		then
			goto continue
		end
		
		if #messageSource[Language][messageKey][messageSecondKey] > 0
		then
			SendMessagePlayer(i, messageType, string.format(messageSource[Language][messageKey][messageSecondKey]))
		end
		
		player = nil
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendMessagePlayerGlobal(messageSource, messageTye)
	SendMessagePlayerGlobal(messageSource, messageTye)
end

return Message