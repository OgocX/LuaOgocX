--[[ Configurations Generals ]]--

--Configurations Sql Server

-- SQL Configurations Reset
TABLE_RESET = "Character"
COLUMN_RESET = {}
COLUMN_RESET[0] = "Resets"
COLUMN_RESET[1] = "ResetsDay"
COLUMN_RESET[2] = "ResetsWeek"
COLUMN_RESET[3] = "ResetsMonth"
WHERE_RESET = "Name"
MAX_RESET = -1 -- -1 sem limites

-- SQL Configurations MReset
TABLE_MRESET = "Character"
COLUMN_MRESET = {}
COLUMN_MRESET[0] = "MResets"
COLUMN_MRESET[1] = "MResetsDay"
COLUMN_MRESET[2] = "MResetsWeek"
COLUMN_MRESET[3] = "MResetsMonth"
WHERE_MRESET = "Name"

-- SQL Configurations PK
TABLE_PK = "Character"
COLUMN_PK = {}
COLUMN_PK[0] = "PKTotal"
COLUMN_PK[1] = "PKDay"
COLUMN_PK[2] = "PKWeek"
COLUMN_PK[3] = "PKMonth"
WHERE_PK = "Name"

-- SQL Configurations Hero
TABLE_HERO = "Character"
COLUMN_HERO = {}
COLUMN_HERO[0] = "HeroTotal"
COLUMN_HERO[1] = "HeroDay"
COLUMN_HERO[2] = "HeroWeek"
COLUMN_HERO[3] = "HeroMonth"
WHERE_HERO = "Name"

-- SQL Configurations Vip
TABLE_VIP = "MEMB_INFO"
COLUMN_VIP = "vip"
WHERE_VIP = "memb___id"

-- SQL Configurations Mult Vaults
TABLE_MULT_WAREHOUSE = "warehouse"
COLUMN_MULT_WAREHOUSE = "VaultCounts"
WHERE_MULT_WAREHOUSE = "AccountID"

-- SQL Configurations Mult Vaults - Save Last Number Vault (Recommended warehouse)
TABLE_LAST_VAULT_ID_WAREHOUSE = "warehouse"
COLUMN_LAST_VAULT_ID_WAREHOUSE = "LastVaultID"
WHERE_LAST_VAULT_ID_WAREHOUSE = "AccountID"

-- SQL Configurations Reward Player
TABLE_REWARD_PLAYER = "MEMB_INFO"
COLUMN_REWARD_PLAYER = "RewardPlayer"
WHERE_REWARD_PLAYER = "memb___id"

--Configurações Set Defense
SET_DEFENSE_SWITCH = 1
SET_DEFENSE_CONFIG = {
{Helm = 50, Armor = 50, Pants = 50, Gloves = 50, Boots = 50, Defense = 1.20, SucessBlock = 1.05},
}