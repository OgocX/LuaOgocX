function CheckPersonalShopValue(aIndex, ItemIndex, Coin1, Coin2, Coin3, Coin4)
	local player = User.new(aIndex)
	local Account = player:getAccountID()
	local Language = player:getLanguage()
	
	if Coin1Switch == 1
	then
		if (Coin1 > 0)
		then
			local CoinAccount = DataBase.GetValue(PERSONAL_SHOP_CUSTOM_CONFIG[0].Table, PERSONAL_SHOP_CUSTOM_CONFIG[0].Column, PERSONAL_SHOP_CUSTOM_CONFIG[0].Where, Account)
			
			if(CoinAccount < Coin1)
			then
				SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][9], Coin1), aIndex, 1)
				return 25
			end
		end
	end
	
	if Coin2Switch == 1
	then
		if (Coin2 > 0)
		then
			local CoinAccount = DataBase.GetValue(PERSONAL_SHOP_CUSTOM_CONFIG[1].Table, PERSONAL_SHOP_CUSTOM_CONFIG[1].Column, PERSONAL_SHOP_CUSTOM_CONFIG[1].Where, Account)
			
			if(CoinAccount < Coin2)
			then
				SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][10], Coin2), aIndex, 1)
				return 26
			end
		end
	end
	
	if Coin3Switch == 1
	then
		if (Coin3 > 0)
		then
			local CoinAccount = DataBase.GetValue(PERSONAL_SHOP_CUSTOM_CONFIG[2].Table, PERSONAL_SHOP_CUSTOM_CONFIG[2].Column, PERSONAL_SHOP_CUSTOM_CONFIG[2].Where, Account)
			
			if(CoinAccount < Coin3)
			then
				SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][11], Coin3), aIndex, 1)
				return 27
			end
		end
	end
	
	if Coin4Switch == 1
	then
		if (Coin4 > 0)
		then
			local CoinAccount = DataBase.GetValue(PERSONAL_SHOP_CUSTOM_CONFIG[3].Table, PERSONAL_SHOP_CUSTOM_CONFIG[3].Column, PERSONAL_SHOP_CUSTOM_CONFIG[3].Where, Account)
			
			if(CoinAccount < Coin4)
			then
				SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][12], Coin4), aIndex, 1)
				return 28
			end
		end
	end
	
	return 1
end

function PersonalShopAddValue(aIndex, Coin1, Coin2, Coin3, Coin4)
	local player = User.new(aIndex)
	local Account = player:getAccountID()
	local Language = player:getLanguage()

	if Coin1Switch == 1
	then
		if(Coin1 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_CUSTOM_CONFIG[0].Table, PERSONAL_SHOP_CUSTOM_CONFIG[0].Column, Coin1, PERSONAL_SHOP_CUSTOM_CONFIG[0].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][1], Coin1), aIndex, 1)
		end
	end
	
	if Coin2Switch == 1
	then
		if(Coin2 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_CUSTOM_CONFIG[1].Table, PERSONAL_SHOP_CUSTOM_CONFIG[1].Column, Coin2, PERSONAL_SHOP_CUSTOM_CONFIG[1].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][2], Coin2), aIndex, 1)
		end
	end
	
	if Coin3Switch == 1
	then
		if(Coin3 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_CUSTOM_CONFIG[2].Table, PERSONAL_SHOP_CUSTOM_CONFIG[2].Column, Coin3, PERSONAL_SHOP_CUSTOM_CONFIG[2].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][3], Coin3), aIndex, 1)
		end
	end

	if Coin4Switch == 1
	then
		if(Coin4 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_CUSTOM_CONFIG[3].Table, PERSONAL_SHOP_CUSTOM_CONFIG[3].Column, Coin4, PERSONAL_SHOP_CUSTOM_CONFIG[3].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][4], Coin4), aIndex, 1)
		end
	end
end

function PersonalShopDecreaseValue(aIndex, Coin1, Coin2, Coin3, Coin4)
	local player = User.new(aIndex)
	local Account = player:getAccountID()
	local Language = player:getLanguage()

	if Coin1Switch == 1
	then
		if(Coin1 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_CUSTOM_CONFIG[0].Table, PERSONAL_SHOP_CUSTOM_CONFIG[0].Column, Coin1, PERSONAL_SHOP_CUSTOM_CONFIG[0].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][5], Coin1), aIndex, 1)
		end
	end
	
	if Coin2Switch == 1
	then
		if(Coin2 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_CUSTOM_CONFIG[1].Table, PERSONAL_SHOP_CUSTOM_CONFIG[1].Column, Coin2, PERSONAL_SHOP_CUSTOM_CONFIG[1].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][6], Coin2), aIndex, 1)
		end
	end
	
	if Coin3Switch == 1
	then
		if(Coin3 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_CUSTOM_CONFIG[2].Table, PERSONAL_SHOP_CUSTOM_CONFIG[2].Column, Coin3, PERSONAL_SHOP_CUSTOM_CONFIG[2].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][7], Coin3), aIndex, 1)
		end
	end

	if Coin4Switch == 1
	then
		if(Coin4 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_CUSTOM_CONFIG[3].Table, PERSONAL_SHOP_CUSTOM_CONFIG[3].Column, Coin4, PERSONAL_SHOP_CUSTOM_CONFIG[3].Where, Account)
			SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][8], Coin4), aIndex, 1)
		end
	end
end