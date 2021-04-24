ITEM_VALUE_AMOUNT = {}

ITEM_VALUE_AMOUNT[1] = { Table = 'CashShopData', Column = 'WCoinC', Where = 'AccountID' }
ITEM_VALUE_AMOUNT[2] = { Table = 'CashShopData', Column = 'WCoinP', Where = 'AccountID' }
ITEM_VALUE_AMOUNT[3] = { Table = 'CashShopData', Column = 'GoblinPoint', Where = 'AccountID' }


ITEM_VALUE_MESSAGES = {}

ITEM_VALUE_MESSAGES['Por'] = {
[1] = "você não possui %d WCoinC suficientes!",
[2] = "você não possui %d WCoinP suficientes!",
[3] = "você não possui %d GoblinPoint suficientes!",
[4] = "você recebeu por sua venda %d WCoinC",
[5] = "você recebeu por sua venda %d WCoinP",
[6] = "você recebeu por sua venda %d GoblinPoint",
[7] = "foi debitado %d WCoinC da sua conta",
[8] = "foi debitado %d WCoinP da sua conta",
[9] = "foi debitado %d GoblinPoint da sua conta",
}

ITEM_VALUE_MESSAGES['Eng'] = {
[1] = "You don't have enough %d WCoinC!",
[2] = "you don't have enough %d WCoinP!",
[3] = "You don't have enough %d GoblinPoint!",
[4] = "you received for your sale %d WCoinC",
[5] = "you received for your sale %d WCoinP",
[6] = "you received for your sale %d GoblinPoint",
[7] = "%d WCoinC has been debited from your account",
[8] = "%d WCoinP has been debited from your account",
[9] = "%d GoblinPoint has been debited from your account",
}

ITEM_VALUE_MESSAGES['Spn'] = {
[1] = "¡No tienes suficiente %d WCoinC!",
[2] = "¡no tienes suficiente %d WCoinP!",
[3] = "¡No tienes suficiente %d GoblinPoint!",
[4] = "recibió por su venta %d WCoinC",
[5] = "recibió por su venta %d WCoinP",
[6] = "recibiste por tu venta %d GoblinPoint",
[7] = "Se debitó %d WCoinC de su cuenta",
[8] = "Se debitó %d WCoinP de su cuenta",
[9] = "Se debitó %d GoblinPoint de su cuenta",
}

ItemValue = { }

function ItemBuyCheckCoins(aIndex, Coin1, Coin2, Coin3)
	local player = User.new(aIndex)
	
	local Coin1Check = 0
	local Coin2Check = 0
	local Coin3Check = 0
	
	if Coin1 > 0
	then
		Coin1Check = DataBase.GetValue(ITEM_VALUE_AMOUNT[1].Table, ITEM_VALUE_AMOUNT[1].Column, ITEM_VALUE_AMOUNT[1].Where, player:getAccountID())
	end
	
	if Coin2 > 0
	then
		Coin2Check = DataBase.GetValue(ITEM_VALUE_AMOUNT[2].Table, ITEM_VALUE_AMOUNT[2].Column, ITEM_VALUE_AMOUNT[2].Where, player:getAccountID())
	end
	
	if Coin3 > 0
	then
		Coin3Check = DataBase.GetValue(ITEM_VALUE_AMOUNT[3].Table, ITEM_VALUE_AMOUNT[3].Column, ITEM_VALUE_AMOUNT[3].Where, player:getAccountID())
	end
	
	player = nil
	
	return Coin1Check, Coin2Check, Coin3Check
end

function ItemBuyDecreaseCoins(aIndex, Coin1, Coin2, Coin3)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if Coin1 > 0
	then
		DataBase.SetDecreaseValue(ITEM_VALUE_AMOUNT[1].Table, ITEM_VALUE_AMOUNT[1].Column, Coin1, ITEM_VALUE_AMOUNT[1].Where, player:getAccountID())
		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][7], Coin1), aIndex, 1)
	end
	
	if Coin2 > 0
	then
		DataBase.SetDecreaseValue(ITEM_VALUE_AMOUNT[2].Table, ITEM_VALUE_AMOUNT[2].Column, Coin2, ITEM_VALUE_AMOUNT[2].Where, player:getAccountID())
		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][8], Coin2), aIndex, 1)
	end
	
	if Coin3 > 0
	then
		DataBase.SetDecreaseValue(ITEM_VALUE_AMOUNT[3].Table, ITEM_VALUE_AMOUNT[3].Column, Coin3, ITEM_VALUE_AMOUNT[3].Where, player:getAccountID())
		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][9], Coin3), aIndex, 1)
	end
	
	player = nil
end

function ItemSellAddCoins(aIndex, Coin1, Coin2, Coin3)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if Coin1 > 0
	then
		DataBase.SetAddValue(ITEM_VALUE_AMOUNT[1].Table, ITEM_VALUE_AMOUNT[1].Column, Coin1, ITEM_VALUE_AMOUNT[1].Where, player:getAccountID())
		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][4], Coin1), aIndex, 1)
	end
	
	if Coin2 > 0
	then
		DataBase.SetAddValue(ITEM_VALUE_AMOUNT[2].Table, ITEM_VALUE_AMOUNT[2].Column, Coin2, ITEM_VALUE_AMOUNT[2].Where, player:getAccountID())
		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][5], Coin2), aIndex, 1)
	end
	
	if Coin3 > 0
	then
		DataBase.SetAddValue(ITEM_VALUE_AMOUNT[3].Table, ITEM_VALUE_AMOUNT[3].Column, Coin3, ITEM_VALUE_AMOUNT[3].Where, player:getAccountID())
		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][6], Coin3), aIndex, 1)
	end
	
	player = nil
end

function ItemBuyBuyError(aIndex, CoinsNeed, Coin)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][Coin], CoinsNeed), aIndex, 1)
	
	player = nil
end

return ItemValue