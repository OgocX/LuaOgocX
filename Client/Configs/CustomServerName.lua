CUSTOM_SERVER_NAME = {
{ ServerID = 1, ServerName = "Servidor Dos Lixo" }, 
{ ServerID = 2, ServerName = "Servidor Dos Fodas" }, 
{ ServerID = 20, ServerName = "Servidor Dos Ricos" }, 
}

function StartLoadCustomServerName()
	for i = 1, #CUSTOM_SERVER_NAME do
		SetServerName(CUSTOM_SERVER_NAME[i].ServerID, CUSTOM_SERVER_NAME[i].ServerName)
	end
end