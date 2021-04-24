--[[
Command Configs
]]--
CHANGE_NICK_COMMAND = '/mudarnick'
CHANGE_NICK_SWITCH = 0
CHANGE_NICK_LEVEL = 6
CHANGE_NICK_ZEN = 0
CHANGE_NICK_VIP = 0
CHANGE_NICK_RESETS = 0
CHANGE_NICK_MRESETS = 0
CHANGE_NICK_MIN_LEN = 4 -- min lenght of caracteres for new name


--[[
Command Message
]]--
CHANGE_NICK_MESSAGE = {}

CHANGE_NICK_MESSAGE["Por"] = {
[1] = "Você precisa estar acima do level %d para usar o comando",
[2] = "Você precisa ter %d zen para usar o comando",
[3] = "Comando para jogadores VIP",
[4] = "Você precisa de %d resets para usar o comando",
[5] = "Você precisa de %d mresets para usar o comando",
[6] = "Você precisa colocar um NICK válido",
[7] = "O mínimo de caracteres para alterar nick é %d",
[8] = "Você está utilizando caracteres impróprios!",
[9] = "Infelizmente o nick que você está tentando trocar já existe!",
[10] = "Seu nick foi alterado com sucesso, relogando personagem",
[11] = "Ocorreu um problema ao efetuar a Troca de nome!",
[12] = "Você precisa sair da guild antes de tentar trocar o nome!",
}

CHANGE_NICK_MESSAGE["Eng"] = {
[1] = "You need to be above level %d to use the command",
[2] = "You must have %d zen to use the command",
[3] = "Command for VIP players",
[4] = "You need %d resets to use the command",
[5] = "You need %d mresets to use the command",
[6] = "You need to enter a valid NICK",
[7] = "The minimum number of characters to change nick is %d",
[8] = "You are using inappropriate characters!",
[9] = "Unfortunately the nickname you are trying to change already exists!",
[10] = "Your nickname has been successfully changed, relogging character",
[11] = "There was a problem making the name change!",
[12] = "You need to leave the guild before trying to change the name!",
}

CHANGE_NICK_MESSAGE["Spn"] = {
[1] = "Debes estar por encima del nivel %d para usar el comando",
[2] = "Debes tener %d zen para usar el comando",
[3] = "Comando para jugadores VIP",
[4] = "Necesitas %d restablecimientos para usar el comando",
[5] = "Necesitas %d mresets para usar el comando",
[6] = "Debes ingresar un NICK válido",
[7] = "El número mínimo de caracteres para cambiar de apodo es %d",
[8] = "¡Estás usando caracteres inapropiados!",
[9] = "¡Desafortunadamente, el apodo que estás intentando cambiar ya existe!",
[10] = "Tu apodo se ha cambiado correctamente, se está volviendo a registrar el personaje",
[11] = "¡Hubo un problema al cambiar el nombre!",
[12] = "¡Debes abandonar el gremio antes de intentar cambiar el nombre!",
}