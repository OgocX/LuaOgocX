--Configurations character login
LOGIN_CHAR_SWITCH = 1
LOGIN_CHAR_STRING_TYPE = 0
LOGIN_CHAR_STAFF_SWITCH = 1
LOGIN_CHAR_STAFF_STRING_TYPE = 0
--Configura��es resets server
SERVER_RESETS_MIN = -1 -- -1 (Qualquer quantia) min�ma de resets pode entrar se voc� colocar 5 o minimo de resets ser� 5
SERVER_RESETS_MAX = -1 -- -1 (Qualquer quantia) m�xima pode entrar se voc� colocar 5 o maximo de resets ser� 5
--Configura��es server vip
SERVER_VIP = 0 -- 0 Servidor normal 1 Servidor vip
SERVER_VIP_MIN = 0 -- Level minimo do vip para entrar

LOGIN_PLAYER_MESSAGES = { }

LOGIN_PLAYER_MESSAGES["Por"] = {
[1] = "[Sistema] Voc� precisa ter %d Resets para entrar nesse servidor.",
[2] = "[Sistema] Voc� precisa passou do limite de %d Resets para ficar nesse servidor.",
[3] = "[Sistema] Servidor apenas para VIPs!",
}

LOGIN_PLAYER_MESSAGES["Eng"] = {
[1] = "[System] You must have %d Resets to join this server.",
[2] = "[System] You need to pass the %d Resets limit to stay on that server.",
[3] = "[System] Server for VIPs only!",
}

LOGIN_PLAYER_MESSAGES["Spn"] = {
[1] = "[Sistema] Debes tener %d reinicios para unirte a este servidor.",
[2] = "[Sistema] Debes pasar el l�mite de %d Resets para permanecer en ese servidor.",
[3] = "�Servidor [Sistema] solo para VIP!",
}

LOGIN_CHAR_STAFF_STRING = { }

LOGIN_CHAR_STAFF_STRING["Por"] = "STAFF %s acabou de logar!"
LOGIN_CHAR_STAFF_STRING["Eng"] = "STAFF %s just logged in!"
LOGIN_CHAR_STAFF_STRING["Spn"] = "�EL PERSONAL %s acaba de iniciar sesi�n!"

LOGIN_CHAR_STRING = {}

LOGIN_CHAR_STRING["Por"] = {
[0] = "Seja Bem-vindo %s ao Servidor! Voc� � FREE",
[1] = "Seja Bem-vindo %s ao Servidor! Voc� � VIP1",
[2] = "Seja Bem-vindo %s ao Servidor! Voc� � VIP2",
[3] = "Seja Bem-vindo %s ao Servidor! Voc� � VIP3",
[4] = "Seja Bem-vindo %s ao Servidor! Voc� � VIP4",
}

LOGIN_CHAR_STRING["Eng"] = {
[0] = "Welcome%s to the Server! You are FREE",
[1] = "Welcome%s to the Server! You are VIP1",
[2] = "Welcome%s to the Server! You are VIP2",
[3] = "Welcome%s to the Server! You are VIP3",
[4] = "Welcome%s to the Server! You are VIP4",
}

LOGIN_CHAR_STRING["Spn"] = {
[0] = "�Bienvenido%s al servidor! Eres GRATIS",
[1] = "�Bienvenido%s al servidor! Eres VIP1",
[2] = "�Bienvenido%s al servidor! Eres VIP2",
[3] = "�Bienvenido%s al servidor! Eres VIP3",
[4] = "�Bienvenido%s al servidor! Eres VIP4",
}