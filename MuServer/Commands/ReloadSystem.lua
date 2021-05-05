ReloadSystem = {}

function ReloadSystem.Command(aIndex, Arguments)
	local player = User.new(aIndex)
	
	if player:getAuthority() == 1
	then
		return
	end
	
	local arg = command:getString(Arguments, 1, 0)
	
	if arg == RELOAD_COMMAND_MONSTER
	then
		ReloadMonster()
	elseif arg == RELOAD_COMMAND_ITEM
	then
		ReloadItem()
	elseif arg == RELOAD_COMMAND_CUSTOM
	then
		ReloadCustom()
	elseif arg == RELOAD_COMMAND_CHARACTER
	then
		ReloadCharacter()
	elseif arg == RELOAD_COMMAND_UTIL
	then
		ReloadUtil()
	elseif arg == RELOAD_COMMAND_MOVE
	then
		ReloadMove()
	elseif arg == RELOAD_COMMAND_EVENT
	then
		ReloadEvent()
	elseif arg == RELOAD_COMMAND_EVENTITEMBAG
	then
		ReloadEventItemBag()
	elseif arg == RELOAD_COMMAND_SKILL
	then
		ReloadSkill()
	elseif arg == RELOAD_COMMAND_HACK
	then
		ReloadHack()
	elseif arg == RELOAD_COMMAND_QUEST
	then
		ReloadQuest()
	elseif arg == RELOAD_COMMAND_COMMON
	then
		ReloadCommon()
	elseif arg == RELOAD_COMMAND_MIX
	then
		ReloadChaosMix()
	elseif arg == RELOAD_COMMAND_SHOP
	then
		ReloadShop()
	elseif arg == RELOAD_COMMAND_CASHSHOP
	then
		ReloadCashShop()
	elseif arg == RELOAD_COMMAND_LUA
	then
		ReloadLua()
	elseif arg == RELOAD_COMMAND_LUA2
	then
		ReloadLua2()
	end
	
	SendMessage(string.format('System %s reload', arg), aIndex, 1)
end

function ReloadSystem.Init()
	if RELOAD_SWITCH == 0
	then
		return
	end
	
	Commands.Register(RELOAD_COMMAND_SYNTAX, ReloadSystem.Command)
end

ReloadSystem.Init()

return ReloadSystem