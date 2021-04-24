--[[
Command Configs
]]--
DISCONNECT_COMMAND = "/dc"
DISCONNECT_SWITCH = 1
DISCONNECT_GLOBAL = 1

--[[
Message Configs
]]--
DISCONNECT_MESSAGES = { }

DISCONNECT_MESSAGES["Por"] = {
[1] = "[Sistema] %s está offline ou não existe",
[2] = "[Sistema] disconnect", 
[3] = "%s desconectou %s",
}

DISCONNECT_MESSAGES["Eng"] = {
[1] = "[System] %s is offline or does not exist",
[2] = "[System] disconnect",
[3] = "%s disconnected %s",
}

DISCONNECT_MESSAGES["Spn"] = {
[1] = "[Sistema] %s está desconectado o no existe",
[2] = "[Sistema] desconectar",
[3] = "%s desconectado %s",
}