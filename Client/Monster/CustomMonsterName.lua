CUSTOM_MONSTER_NAME_INFO = {

    { Class = 579, Map = 0, CoordX = 125, CoordY = 125, Name = "Npc Quest - 1" },
    { Class = 579, Map = 0, CoordX = 135, CoordY = 135, Name = "Npc Quest - 2" },
}


function StartLoadCustomMonsterName()
    for i = 1, #CUSTOM_MONSTER_NAME_INFO do
        monsterInfo = CUSTOM_MONSTER_NAME_INFO[i]

        SetCustomMonsterName(monsterInfo.Class, monsterInfo.Map, monsterInfo.CoordX, monsterInfo.CoordY, monsterInfo.Name)
    end
end

StartLoadCustomMonsterName()