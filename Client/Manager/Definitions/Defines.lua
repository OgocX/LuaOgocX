ITEM_BASE          = 1171

function CONVERT_RGBA(r, g, b, a)
	return ((a << 24) + (b << 16) + (g << 8) + r)
end

function GET_ITEM(x, y)
	return (x * 512) + y
end

function GET_ITEM_MODEL(x, y)
	return ((x * 512) + y) + ITEM_BASE
end

UIFriendList		= 1
UIMoveList			= 2
UIParty				= 3
UIQuest				= 4
UIGuild				= 6
UITrade				= 7
UIWarehouse			= 8
UIChaosBox			= 9
UICommandWindow		= 10
UIPetInfo			= 11
UIShop				= 12
UIInventory			= 13
UIStore				= 14
UIOtherStore		= 15
UICharacter			= 16
UIChatWindow		= 33
UIFastMenu			= 34
UIOptions			= 35
UIHelp				= 36
UIFastDial			= 39
UISkillTree			= 57
UINPC_Titus			= 63
UICashShop			= 65
UIFullMap			= 72
UINPC_Dialog		= 73
UIGensInfo			= 74
UINPC_Julia			= 75
UIExpandInventory	= 77
UIExpandWarehouse	= 78
UIMuHelper 			= 79

ALIGN_LEFT           = 1
ALIGN_LEFT_CLIP      = 2
ALIGN_CENTER         = 3
ALIGN_RIGHT          = 4
ALIGN_RIGHT_TO_LEFT  = 7
ALIGN_CENTER_TO_RIGHT  = 8

CLASS_DW = 0
CLASS_DK = 1
CLASS_FE = 2
CLASS_MG = 3
CLASS_DL = 4
CLASS_SU = 5
CLASS_RF = 6