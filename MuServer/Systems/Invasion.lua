--[[Invasão system By OgocX]]--

--Configurações Invasão
--Invasion Switch 0 = desativado 1 = ativado
local CONFIG_INVASION_SWITCH = 1

--Index é usado para identificar qual invasão está funcionando (Não utilize 0)
--Day of Week, Day, Hour, Minute
--Day of Week: 0 a 6: Domingo, segunda, terça, quarta, quinta, sexta, sabado
--Day of Week: -1 = Day
--Day = -1 = Horas e minutos.
--Exemplo: rodará todos os dias as 20h15min
--Exemplo 02: rodará todo dia 05 ás 15h00min
--Exemplo 03: rodará todo sábado as 15h00min
--Exemplo 03: rodará todos os dias as 15h00min
local CONFIG_INVASION_DATE = {{_index = 1, _dayofweek = -1, _day = -1, _hour = 20, _minute = 15},
{_index = 1, _dayofweek = -1, _day = 5, _hour = 15, _minute = 00},
{_index = 1, _dayofweek = 6, _day = -1, _hour = 15, _minute = 00},
{_index = 1, _dayofweek = -1, _day = -1, _hour = 15, _minute = 00},
{_index = 2, _dayofweek = -1, _day = -1, _hour = 20, _minute = 15},
{_index = 2, _dayofweek = -1, _day = 5, _hour = 15, _minute = 00},
{_index = 2, _dayofweek = 6, _day = -1, _hour = 15, _minute = 00},
{_index = 2, _dayofweek = -1, _day = -1, _hour = 15, _minute = 00}}

--Index (Invasion) (Não utilize 0)
--Nome da Invasão
--Duração (min)
--Anunciar no global os monstros vivos 1 = sim 0 = não
--Anunciar no global quem matou 1 = sim 0 = não
local CONFIG_INVASION_SYSTEM = {{_index = 1, _name = "Testes System", _duration = 15, _announce_global = 1, _announce_death = 1},
{_index = 2, _name = "Testes System", _duration = 15, _announce_global = 1, _announce_death = 1}}

--Index (Invasion) (Não utilize 0)
--Class Monster
--Map
--Quantia
local INVASION_MONSTER_CREATE = {{ _index = 1, _class = 16, _map = 0, _count = 20},
{ _index = 2, _class = 20, _map = 2, _count = 20}}

--Index (Invasion) (Não utilize 0)
--Class Monster
--Item Section
--Item Index
--Level
--Luck
--Skill
--Opt
--Exc
--Count
local MONSTER_DROP_CLASS = {{ _index = 1, _class = 16, _section = 0, _item_index = 0, _level = 15, _luck = 1, _skill = 1, _opt = 7, _exc = 63, _count = 1},
{ _index = 1, _class = 16, _section = 0, _item_index = 0, _level = 15, _luck = 1, _skill = 1, _opt = 7, _exc = 63, _count = 2},
{ _index = 2, _class = 20, _section = 0, _item_index = 15, _level = 15, _luck = 1, _skill = 1, _opt = 7, _exc = 63, _count = 1},
{ _index = 2, _class = 20, _section = 0, _item_index = 15, _level = 15, _luck = 1, _skill = 1, _opt = 7, _exc = 63, _count = 2},}

local INVASION_MESSAGES = { }

INVASION_MESSAGES["Por"] = {
[1] = "A Invasão: %s, começou!!!",
[2] = "A Invasão: %s acabou!!!",
[3] = "%s matou um %s",
[4] = "Restam %d monstros vivos!",
}

INVASION_MESSAGES["Eng"] = {
[1] = "The Invasion: %s has started !!!",
[2] = "The Invasion: %s is over !!!",
[3] = "%s killed a %s",
[4] = "%d monsters left alive!",
}

INVASION_MESSAGES["Spn"] = {
[1] = "¡¡¡La invasión: %s ha comenzado !!!",
[2] = "La invasión: ¡¡¡ %s terminó !!!",
[3] = "%s mató a %s",
[4] = "¡%d monstruos quedan vivos!",
}


--Não mexer aqui configurações do sistema
InvasionSystem = {}
INVASION_MONSTERS = {}
INVASION_SYSTEM = {}
INVASION_ITEMS_RAND = {}

function InvasionSystem.Init()
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	GameServerFunctions.MonsterDie(InvasionSystem.MonsterDie)
	GameServerFunctions.MonsterDieGiveItem(InvasionSystem.MonsterDieGiveItem)

	Timer.Interval(1, InvasionSystem.Running)
	
	for i in ipairs(CONFIG_INVASION_DATE) do
		if CONFIG_INVASION_DATE[i]._dayofweek ~= -1
		then
			Schedule.SetDayOfWeek(CONFIG_INVASION_DATE[i]._dayofweek, CONFIG_INVASION_DATE[i]._hour, CONFIG_INVASION_DATE[i]._minute, InvasionSystem.Start, CONFIG_INVASION_DATE[i]._index)
		elseif CONFIG_INVASION_DATE[i]._day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(CONFIG_INVASION_DATE[i]._day, CONFIG_INVASION_DATE[i]._hour, CONFIG_INVASION_DATE[i]._minute, InvasionSystem.Start, CONFIG_INVASION_DATE[i]._index)
		else
			Schedule.SetHourAndMinute(CONFIG_INVASION_DATE[i]._hour, CONFIG_INVASION_DATE[i]._minute, InvasionSystem.Start, CONFIG_INVASION_DATE[i]._index)
		end
	end
end

function InvasionSystem.Start(index)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for i in ipairs(CONFIG_INVASION_SYSTEM) do
		if CONFIG_INVASION_SYSTEM[i]._index == index
		then
			Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 1, 0, CONFIG_INVASION_SYSTEM[i]._name)
			
			for n in ipairs(INVASION_MONSTER_CREATE) do
				if INVASION_MONSTER_CREATE[n]._index == index
				then
					InvasionSystem.CreateMonster(index, INVASION_MONSTER_CREATE[n]._class, INVASION_MONSTER_CREATE[n]._map, INVASION_MONSTER_CREATE[n]._count)
				end
			end
			
			INVASION_SYSTEM[index] = { _index = index, 
										_end = CONFIG_INVASION_SYSTEM[i]._duration * 60,
										_state = true,
										_running = true, 
										_Name = CONFIG_INVASION_SYSTEM[i]._name,
										_Announce_Death = CONFIG_INVASION_SYSTEM[i]._announce_death,
										_Announce_Global = CONFIG_INVASION_SYSTEM[i]._announce_global}
		end
	end
end

function InvasionSystem.Running()
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for key in pairs(INVASION_SYSTEM) do
		if INVASION_SYSTEM[key]._running == true
		then
			if INVASION_SYSTEM[key]._end <= 0
			then
				InvasionSystem.InvasionEnd(key)
			else
				INVASION_SYSTEM[key]._end = INVASION_SYSTEM[key]._end - 1
			end
		end
	end
end

function InvasionSystem.CreateMonster(invasion, class, map, count)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for i = 1, count do
		local index = AddMonster(map)
		
		if index == -1
		then
			LogAdd(string.format("[Invasion] Problema ao criar o monstro :%d", class))
			return
		end
		
		local monster = User.new(index)
		
		SetPositionMonster(index, map)
		SetMonster(index, class)
		
		monster:setRegenTime(0)
		
		LogAdd(string.format("[Invasion] Class:%d Map:%d CoordX:%d CoordY:%d",class, monster:getMapNumber(), monster:getX(), monster:getY()))
		
		INVASION_MONSTERS[index] = {_index = index, _Invasion = invasion, _Class = class}
	end
end

function InvasionSystem.InvasionEnd(key)
	--Anunciar no global o fim da invasão
	Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 2, 0, INVASION_SYSTEM[key]._Name)
	
	--Remove os monstros
	InvasionSystem.ClearInvasionBy(key)
	
	--Limpar o sistema
	InvasionSystem.ClearSystemByInvasion(key)
end

function InvasionSystem.ClearInvasionBy(index)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for key in pairs(INVASION_SYSTEM) do
		if INVASION_SYSTEM[key]._index == index
		then
			--Remover monstros caso exista algum vivo
			InvasionSystem.ClearByMonster(INVASION_SYSTEM[key]._index)
		end
	end
end

function InvasionSystem.ClearByMonster(index)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for key in pairs(INVASION_MONSTERS) do
		if INVASION_MONSTERS[key]._Invasion == index
		then
			if INVASION_MONSTERS[key]._index ~= -1
			then
				gObjDel(INVASION_MONSTERS[key]._index)
				INVASION_MONSTERS[key] = nil
			end
		end
	end
end

function InvasionSystem.ClearSystemByInvasion(index)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for key in pairs(INVASION_SYSTEM) do
		if INVASION_SYSTEM[key]._index == index
		then
			INVASION_SYSTEM[key] = nil
		end
	end
end

function InvasionSystem.DelByMonster(invasion, index)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for key in pairs(INVASION_MONSTERS) do
		if INVASION_MONSTERS[key]._Invasion == invasion
		then
			if INVASION_MONSTERS[key]._index == index
			then
				if INVASION_MONSTERS[key]._index ~= -1
				then
					gObjDel(INVASION_MONSTERS[key]._index)
					
					INVASION_MONSTERS[key]._index = -1
				end
			end
		end
	end
end

function InvasionSystem.GetByMonster(invasion, index)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	if INVASION_MONSTERS[index] == nil
	then
		return -1
	end
	
	if INVASION_MONSTERS[index]._index == -1
	then
		return -1
	end
	
	if INVASION_MONSTERS[index]._Invasion == invasion
	then
		return INVASION_MONSTERS[index]._index
	end
	
	return -1
end

function InvasionSystem.GetCountMonsterByInvasion(invasion)
	local count = 0

	for key in pairs(INVASION_MONSTERS) do
		if INVASION_MONSTERS[key]._Invasion == invasion
		then
			if INVASION_MONSTERS[key]._index ~= -1
			then
				local monster = User.new(INVASION_MONSTERS[key]._index)
				
				if monster:getConnected() >= 2
				then
					count = count + 1
				end
			end
		end
	end
	
	return count
end

function InvasionSystem.InsertItens(item)
	InsertKey(INVASION_ITEMS_RAND, item)
end

function InvasionSystem.GetItemRand()
	if #INVASION_ITEMS_RAND > 0
	then
		return GetRand(1, #INVASION_ITEMS_RAND)
	end
	
	return -1
end

function InvasionSystem.DropItemByMonster(index, Player, Monster)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	INVASION_ITEMS_RAND = {}
	
	local player = User.new(Player)
	local monster = User.new(Monster)
	
	for i in ipairs(MONSTER_DROP_CLASS) do
		if MONSTER_DROP_CLASS[i]._index == index and MONSTER_DROP_CLASS[i]._class == monster:getClass()
		then
			InvasionSystem.InsertItens(MONSTER_DROP_CLASS[i])
		end
	end
	
	local key_rand = InvasionSystem.GetItemRand()
	
	if key_rand == -1
	then
		LogAdd("[Invasion] Existe uma má configuração no sistema de dropar item")
		return
	end
	
	local ItemDrop = INVASION_ITEMS_RAND[key_rand]
	
	for i = 1, ItemDrop._count do
		ItemSerialCreate(Player, player:getMapNumber(), player:getX(), player:getY(), GET_ITEM(ItemDrop._section, ItemDrop._item_index), ItemDrop._level, 255, ItemDrop._luck, ItemDrop._skill, ItemDrop._opt, ItemDrop._exc)
	end
end

function InvasionSystem.MonsterDie(Player, Monster)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	local player = User.new(Player)
	local monster = User.new(Monster)
	
	for key in pairs(INVASION_SYSTEM) do
		if INVASION_SYSTEM[key]._running == true
		then
			if InvasionSystem.GetByMonster(INVASION_SYSTEM[key]._index, Monster) == Monster
			then
				--Monstrar no global que o player X matou o monstro X
				if INVASION_SYSTEM[key]._Announce_Death == 1
				then
					Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 3, 0, player:getName(), monster:getName())
				end
				
				--Dizer quantos monstros restam
				if INVASION_SYSTEM[key]._Announce_Global == 1
				then
					local MonsterCount = math.floor(InvasionSystem.GetCountMonsterByInvasion(INVASION_SYSTEM[key]._index) - 1)
					if MonsterCount > 0
					then
						Message.SendMessageGlobalMultLangArgs(INVASION_MESSAGES, 4, 0, MonsterCount)
					else
						--Finalizar a invasão mataram todos monstros
						Timer.TimeOut(5, InvasionSystem.InvasionEnd, key)
					end
				end
			end
		end
	end
end

function InvasionSystem.MonsterDieGiveItem(Player, Monster)
	if CONFIG_INVASION_SWITCH == 0
	then
		return
	end
	
	for key in pairs(INVASION_SYSTEM) do
		if INVASION_SYSTEM[key]._running == true
		then
			if InvasionSystem.GetByMonster(INVASION_SYSTEM[key]._index, Monster) == Monster
			then
				--Sistema onde vai gerar 1 item aleatório
				InvasionSystem.DropItemByMonster(INVASION_SYSTEM[key]._index, Player, Monster)
				
				--Remover o monstro do sistema
				InvasionSystem.DelByMonster(INVASION_SYSTEM[key]._index, Monster)
				return 1
			end
		end
	end
	
	return
end

InvasionSystem.Init()

return InvasionSystem