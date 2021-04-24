--[[
reset objects

don't touch in this lua!
--]]

function ResetCollect()
	collectgarbage ()
end

Timer.Interval(15, ResetCollect)