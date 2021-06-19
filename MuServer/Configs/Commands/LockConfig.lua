--[[
Command Config
]]

LOCK_COMMAND_SWITCH = 1
LOCK_COMMAND_SYNTAX = '/lock'
UNLOCK_COMMAND_SYNTAX = '/unlock'

LOCK_COMMAND_TABLE = 'MEMB_INFO'
LOCK_COMMAND_COLUMN = 'LockPassword'
LOCK_COMMAND_WHERE = 'memb___id'

--[[
Messages Config
]]
LOCK_COMMAND_MESSAGES = {}

LOCK_COMMAND_MESSAGES['Por'] = {
[1] = 'Voc� j� registrou uma senha!',
[2] = 'Coloque uma senha v�lida!',
[3] = 'A senha foi registrada com sucesso!',
[4] = 'A senha digitada est� incorreta!',
[5] = 'A senha foi liberada!',
[6] = 'A conta est� trancada, desbloqueie a senha!',
}

LOCK_COMMAND_MESSAGES['Eng'] = {
[1] = 'You have already registered a password!',
[2] = 'Please enter a valid password!',
[3] = 'The password has been successfully registered!',
[4] = 'The password entered is incorrect!',
[5] = 'The password has been released!',
[6] = 'Account is locked, unlock password!',
}

LOCK_COMMAND_MESSAGES['Spn'] = {
[1] = '�Ya ha registrado una contrase�a!',
[2] = '�Ingrese una contrase�a v�lida!',
[3] = '�La contrase�a se ha registrado correctamente!',
[4] = '�La contrase�a ingresada es incorrecta!',
[5] = '�La contrase�a ha sido liberada!',
[6] = '�La cuenta est� bloqueada, desbloquear la contrase�a!',
}