ReAddMasterSkill = {}

function ReAddMasterSkill.Command(aIndex, Arguments)
	if READD_MASTER_SKILL_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if player:getLevel() < READD_MASTER_SKILL_LEVEL
	then
		SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][1], READD_MASTER_SKILL_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < READD_MASTER_SKILL_ZEN
	then
		SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][2], READD_MASTER_SKILL_ZEN), aIndex, 1)
		return
	end
	
	if player:getVip() < READD_MASTER_SKILL_VIP
	then
		SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][3]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if player:getReset() < READD_MASTER_SKILL_RESETS
	then
		SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][4], READD_MASTER_SKILL_RESETS), aIndex, 1)
		return
	end
	
	if player:getMasterReset() < READD_MASTER_SKILL_MRESETS
	then
		SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][5], READD_MASTER_SKILL_MRESETS), aIndex, 1)
		return
	end
	
	if CheckUserIsMasterSkill(aIndex) == 0
	then
		SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][6]), aIndex, 1)
		return
	end
	
	gObjRebuildMasterSkillTree(aIndex)
	
	SendMessage(string.format(READD_MASTER_SKILL_MESSAGES[Language][7]), aIndex, 1)
end

Commands.Register(READD_MASTER_SKILL_COMMAND, ReAddMasterSkill.Command)

return ReAddMasterSkill