--[[ Copyright (c) 2016 OgocX based in Enrique García Cota ]]--

Timer = {}

local Handles = {}
local id = 0

unpack = unpack and unpack or table.unpack

function Timer.RunRepeat(timer)
	timer.running = timer.running + 1

	if timer.running < timer.time
	then 
		return false
	end
	
	timer.count = timer.count - 1
	
	if timer.count == 0
	then
		return true
	end
	
	timer.running = 0
	timer.callback(unpack(timer.args))
	return false
end

function Timer.RunInterval(timer)
	timer.running = timer.running + 1

	if timer.running < timer.time
	then 
		return false
	end
	
	timer.running = 0
	timer.callback(unpack(timer.args))
	return false
end

function Timer.RunTimerOut(timer)
	if timer.running >= timer.time 
	then 
		return false
	end

	timer.running = timer.running + 1

	if timer.running >= timer.time 
	then
		timer.callback(unpack(timer.args))
		return true
	end
		return false
end

function Timer.Repeater(time, counts, call, ...)
	id = id + 1
	table.insert(Handles, {time = time, callback = call, args = {...}, running = 0, count = counts + 2, update = Timer.RunRepeat, number = id})
	return id
end

function Timer.Interval(time, call, ...)
	id = id + 1
	table.insert(Handles, {time = time, callback = call, args = {...}, running = 0, count = 0, update = Timer.RunInterval, number = id})
	return id
end

function Timer.TimeOut(time, call, ...)
	id = id + 1
	table.insert(Handles, {time = time, callback = call, args = {...}, running = 0, count = 0, update = Timer.RunTimerOut, number = id})
	return id
end

function Timer.Cancel(id)
	if id == -1 or id == nil
	then
		return
	end

	if #Handles == 0
	then
		return
	end
	
	for i in ipairs(Handles) do
		if Handles[i].number == id
		then
			table.remove(Handles, i)
		end
	end
end

function Timer.Update()
	for i in ipairs(Handles) do
		if Handles[i].update ~= nil
		then
			if Handles[i].update(Handles[i]) == true
			then
				if Handles[i].number ~= nil
				then
					Timer.Cancel(Handles[i].number)
				end
			end
		end
	end
end

function TimerSystem()
	Timer.Update()
end

return Timer