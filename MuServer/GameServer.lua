--[[
declare global var
--]]

command = Command.new()

--[[
Initial System
]]--
OpenExtension('LuaSystem')
OpenExtension('Configs\\Commands')
OpenExtension('Configs')
OpenExtension('Utils')
OpenExtension('Character')
OpenExtension('Systems')
OpenExtension('Commands')

function GameServer()
	LogAddC(1,"Lua Carregado com sucesso!")
	
	DataBase.Connect(3, "MuOnline", "sa", "123")
end