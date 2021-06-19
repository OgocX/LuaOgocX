--[[
Game Master Level
]]

GAME_MASTER_LEVEL = {}

GAME_MASTER_LEVEL['ogocx'] = { characterName = 'OgocX', level = 1 }
GAME_MASTER_LEVEL['violent'] = { characterName = 'viOLent', level = 1 }

function CheckGameMasterLevel(account, name, level)
    local gamemaster = GAME_MASTER_LEVEL[account]

    if gamemaster ~= nil
    then
        if name == gamemaster.characterName
        then
            if gamemaster.level >= level
            then
                return 1
            end
        end
    end

    return 0
end