Message = { }

function Message.SendMessageGlobalMultLang(messageSource, messageKey, messageType)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end

		SendMessagePlayer(i, messageType, messageSource[GetLanguageObject(i)][messageKey])
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendMessageGlobalMultLangArgs(messageSource, messageKey, messageType, ...)
	local args = ...

	if type(args) ~= 'table'
	then
		args = {...}
	end

	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, messageType, messageSource[GetLanguageObject(i)][messageKey]:format(unpack(args)))
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendGlobalMultLangeDirect(messageSource, messageType, ...)
	local args = ...

	if type(args) ~= 'table'
	then
		args = {...}
	end
	
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, messageType, messageSource[GetLanguageObject(i)]:format(unpack(args)))
		
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
		
		local Language = GetLanguageObject(i)
		
		if #messageSource[Language][messageKey][messageSecondKey] > 0
		then
			SendMessagePlayer(i, messageType, messageSource[Language][messageKey][messageSecondKey])
		end
		
		::continue::
	end
	
	collectgarbage()
end

function Message.SendMessagePlayerGlobal(messageSource, messageTye)
	SendMessagePlayerGlobal(messageSource, messageTye)
end

return Message