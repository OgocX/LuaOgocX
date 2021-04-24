--[[ Event Drop ]]--

EventDrop = {}

EVENT_DROP_SWITCH = 1

--Index: Sempre que adicionar um novo evento, aumente + 1 no index, exemplo: tenho index 1 2 3, vou adicionar um novo então é index 4!
EVENT_DROP_CRON = {{Index = 1, Day = -1, DayOfWeek = -1, Hour = 16, Minute = 43},}

--Index: Segue o index da EVENT_DROP_CRON
--Name: Nome do evento
--Map: Numero do mapa
--CoordX: Coord X do mapa onde vai funcionar o evento
--CoordY: Coord Y do mapa onde vai funcionar o evento
--Range: Distancia máxima que vai dropar o item da coord inicial
--ALARM: Tempo em minutos que vai avisar que o evento vai começar
--EVENT: Tempo total do evento
--RunningTimer: Mantenha 0
--Timer: Mantenha 0
--Handle: Mantenha nil
EVENT_DROP_CONFIG = {{Index = 1, Name = "Drop Crazy", Map = 0, CoordX = 125, CoordY = 125, Range = 5, Alarm = 5, Finish = 2, RunningTimer = 0, Timer = 0, Handle = nil},}

--Index: Segue o index da EVENT_DROP_CONFIG
--ItemIndex: Seção do item * 512 + Index do item
--DropCount: Quantia que vai dropar
--Delay: Tempo que o item vai começar a cair: Só cai uma vez, se seu evento tem 5 minutos de duração utilize o delay até 290 segundos, mais que isso o item pode não dropar.
--State: Mantenha 0, o sistema detecta isso para dropar apenas uma vez o item.
EVENT_DROP_ITEM = {{Index = 1, ItemIndex = 6159, Level = 0, Option = 0, Skill = 0, Luck = 0, Exc_1 = 0, Exc_2 = 0, Exc_3 = 0, Exc_4 = 0, Exc_5 = 0, Exc_6 = 0, DropCount = 5, Delay = 20, State = 0},
{Index = 1, ItemIndex = 6159, Level = 0, Option = 0, Skill = 0, Luck = 0, Exc_1 = 0, Exc_2 = 0, Exc_3 = 0, Exc_4 = 0, Exc_5 = 0, Exc_6 = 0, DropCount = 3, Delay = 40, State = 0},
{Index = 1, ItemIndex = 6159, Level = 0, Option = 0, Skill = 0, Luck = 0, Exc_1 = 0, Exc_2 = 0, Exc_3 = 0, Exc_4 = 0, Exc_5 = 0, Exc_6 = 0, DropCount = 2, Delay = 60, State = 0},
{Index = 1, ItemIndex = 6159, Level = 0, Option = 0, Skill = 0, Luck = 0, Exc_1 = 0, Exc_2 = 0, Exc_3 = 0, Exc_4 = 0, Exc_5 = 0, Exc_6 = 0, DropCount = 1, Delay = 110, State = 0},}

local EVENT_DROP_MESSAGES = { }

EVENT_DROP_MESSAGES["Por"] = {
[1] = "%s começou!",
[2] = "%s começa em %d minuto(s)",
}

EVENT_DROP_MESSAGES["Eng"] = {
[1] = "%s started!",
[2] = "%s starts at %d minute (s)",
}

EVENT_DROP_MESSAGES["Spn"] = {
[1] = "¡%s comenzó!",
[2] = "%s comienza en %d minuto (s)",
}

function EventDrop.Init()
	if EVENT_DROP_SWITCH == 0
	then
		return
	end
	
	timer = EVENT_DROP_TIMER_ALARM
	
	for i in ipairs(EVENT_DROP_CRON) do
		if EVENT_DROP_CRON[i].DayOfWeek ~= -1
		then
			Schedule.SetDayOfWeek(EVENT_DROP_CRON[i].DayOfWeek, EVENT_DROP_CRON[i].Hour, EVENT_DROP_CRON[i].Minute, EventDrop.StartEvent, EVENT_DROP_CRON[i].Index)
		elseif EVENT_DROP_CRON[i].Day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(EVENT_DROP_CRON[i].Day, EVENT_DROP_CRON[i].Hour, EVENT_DROP_CRON[i].Minute, EventDrop.StartEvent, EVENT_DROP_CRON[i].Index)
		else
			Schedule.SetHourAndMinute(EVENT_DROP_CRON[i].Hour, EVENT_DROP_CRON[i].Minute, EventDrop.StartEvent, EVENT_DROP_CRON[i].Index)
		end
	end
end

function EventDrop.StartEvent(index)
	local key = EventDrop.GetKey(index)

	if key == -1
	then
		return
	end
	
	EVENT_DROP_CONFIG[key].Timer = EVENT_DROP_CONFIG[key].Alarm
	
	Timer.Repeater(60, EVENT_DROP_CONFIG[key].Alarm, EventDrop.AlarmStartEvent, key)
end

function EventDrop.AlarmStartEvent(key)
	if EVENT_DROP_CONFIG[key].Timer == 0
	then
		Message.SendMessageGlobalMultLangArgs(EVENT_DROP_MESSAGES, 1, 0, EVENT_DROP_CONFIG[key].Name)
		SendMessageGlobal(string.format("%s %d %d", EventDrop.GetMapName(EVENT_DROP_CONFIG[key].Map), EVENT_DROP_CONFIG[key].CoordX, EVENT_DROP_CONFIG[key].CoordY), 0)
		
		EVENT_DROP_CONFIG[key].RunningTimer = 0
		EVENT_DROP_CONFIG[key].Handle = Timer.Interval(1, EventDrop.RunningEvent, key)
		Timer.TimeOut(EVENT_DROP_CONFIG[key].Finish * 60, EventDrop.FinishEvent, key)
	else
		Message.SendMessageGlobalMultLangArgs(EVENT_DROP_MESSAGES, 2, 0, EVENT_DROP_CONFIG[key].Name, EVENT_DROP_CONFIG[key].Timer)
		EVENT_DROP_CONFIG[key].Timer = EVENT_DROP_CONFIG[key].Timer - 1
	end
end

function EventDrop.RunningEvent(key)
	EVENT_DROP_CONFIG[key].RunningTimer = EVENT_DROP_CONFIG[key].RunningTimer + 1
	
	for i in ipairs(EVENT_DROP_ITEM) do
		if EVENT_DROP_ITEM[i].Index == EVENT_DROP_CONFIG[key].Index
		then
			if EVENT_DROP_ITEM[i].State == 0 and EVENT_DROP_CONFIG[key].RunningTimer >= EVENT_DROP_ITEM[i].Delay
			then
				for n = 1, EVENT_DROP_ITEM[i].DropCount do
					EVENT_DROP_ITEM[i].State = 1
					
					local tab = {}
					
					local map = EVENT_DROP_CONFIG[key].Map
					local x = EVENT_DROP_CONFIG[key].CoordX
					local y = EVENT_DROP_CONFIG[key].CoordY
					local range = EVENT_DROP_CONFIG[key].Range
					
					if EventDrop.GetCoordRandomDrop(tab, map, x, y, range, range, 50) == 1
					then
						x = tab[0]
						y = tab[1]
					end
					
					FireWorks(-1, map, x, y)
					
					local exc = 0
				
					if EVENT_DROP_ITEM[i].Exc_1 ~= 0
					then
						exc = exc + 1
					end
					if EVENT_DROP_ITEM[i].Exc_2 ~= 0
					then
						exc = exc + 2
					end
					if EVENT_DROP_ITEM[i].Exc_3 ~= 0
					then
						exc = exc + 4
					end
					if EVENT_DROP_ITEM[i].Exc_4 ~= 0
					then
						exc = exc + 8
					end
					if EVENT_DROP_ITEM[i].Exc_5 ~= 0
					then
						exc = exc + 16
					end
					if EVENT_DROP_ITEM[i].Exc_6 ~= 0
					then
						exc = exc + 32
					end
					
					ItemSerialCreate(EventDrop.GetIndex(),map, x, y, EVENT_DROP_ITEM[i].ItemIndex, EVENT_DROP_ITEM[i].Level, 200, EVENT_DROP_ITEM[i].Luck, EVENT_DROP_ITEM[i].Skill, EVENT_DROP_ITEM[i].Option, exc)
				end
			end
		end
	end
end

function EventDrop.GetIndex()
	for i = OBJECT_START_USER, MAX_OBJECT do
		local player = User.new(i)
		
		if player:getConnected() == 3
		then
			return i
		end
	end
	
	return 6400
end

function EventDrop.GetCoordRandomDrop(tab, map, ox, oy, tx, ty, count)
	local x = ox
	local y = oy

	local tx = tx
	
	if tx < 1
	then
		tx = 1
	end
	
	local ty = ty
	
	if ty < 1
	then
		ty = 1
	end
	
	local nx = 0
	local ny = 0

	for i = 0, count do
		nx = math.random(0, tx+1)
		
		local rand1 = math.random(0, 1)
		
		if rand1 == 0
		then
			rand1 = -1
		end
		
		nx = nx * rand1 + x
		
		ny = math.random(0, tx+1)
		
		local rand2 = math.random(0, 1)
		
		if rand2 == 0
		then
			rand2 = -1
		end
		
		ny = ny * rand1 + y
		
		if GetMapAttr(map, nx, ny, 4) == 0 and GetMapAttr(map, nx, ny, 8) == 0
		then
			tab[0] = nx
			tab[1] = ny
			return 1
		end
	end

	return 0
end

function EventDrop.FinishEvent(key)
	Timer.Cancel(EVENT_DROP_CONFIG[key].Handle)
	
	EVENT_DROP_CONFIG[key].Handle = nil
	
	EventDrop.RestartItem(EVENT_DROP_CONFIG[key].Index)

	SendMessageGlobal(string.format("%s acabou!", EVENT_DROP_CONFIG[key].Name), 0)
end

function EventDrop.RestartItem(index)
	for i in ipairs(EVENT_DROP_ITEM) do
		if EVENT_DROP_ITEM[i].Index == index
		then
			EVENT_DROP_ITEM[i].State = 0
		end
	end
end

function EventDrop.GetKey(index)
	for i in ipairs(EVENT_DROP_CONFIG) do
		if EVENT_DROP_CONFIG[i].Index == index
		then
			return i
		end
	end
	
	return -1
end

function EventDrop.GetMapName(map)
	if map == 0
	then
		return "Lorencia"
	end
	
	if map == 1
	then
		return "Dungeon"
	end
	
	if map == 2
	then
		return "Devias"
	end
	
	if map == 3
	then
		return "Noria"
	end
	
	if map == 4
	then
		return "Losttower"
	end
	
	if map == 5
	then
		return "Unknow"
	end
	
	if map == 6
	then
		return "Arena"
	end
	
	if map == 7
	then
		return "Atlans"
	end
	
	if map == 8
	then
		return "Tarkan"
	end
	
	if map == 10
	then
		return "Icarus"
	end
end

EventDrop.Init()

return EventDrop