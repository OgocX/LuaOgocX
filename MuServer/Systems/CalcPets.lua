--[[Configurations of Pets]]--


--Pet Index = Seção * 512 + Index
--Exemplo: Angel: 13, 0: 13 * 512 + 0 = 6656
PETS_DAMAGE_SWITCH = 0

PETS_DAMAGE_DEFENSE = {
{PetIndex = 6656, Damage = 0, Defense = PET_ANGEL_RATE},
{PetIndex = 6657, Damage = PET_SATAN_RATE, Defense = 0},
{PetIndex = 6659, Damage = PET_DINORANT_ATTACK_RATE, Defense = PET_DINORANT_DEFENSE_RATE}
}

--[[Sobre a função:

Isso aqui se torna responsável pelo calculo de dano dos pets, não mais o GameServer!

Fiz desse jeito para quem não sabe mexer apenas configurar acima, mas você pode mudar e fazer um dano diferenciado caso queira...]]

--aIndex = Player Atacante
--TargetIndex = Player Defensor
function CalcAttackPets(aIndex, TargetIndex, Damage)
	if PETS_DAMAGE_SWITCH == 0
	then
		return Damage
	end

	local pInv = Inventory.new(aIndex)
	local tInv = Inventory.new(TargetIndex)
	
	local player = User.new(aIndex)
	local target_player = User.new(TargetIndex)
	
	for i in ipairs(PETS_DAMAGE_DEFENSE) do
		if Damage > 0
		then
			if player:getType() == 1
			then
				if pInv:isItem(8) ~= 0
				then
					if PETS_DAMAGE_DEFENSE[i].PetIndex == pInv:getIndex(8)
					then
						if PETS_DAMAGE_DEFENSE[i].Damage > 0
						then
							Damage = (Damage * (100 + PETS_DAMAGE_DEFENSE[i].Damage)) / 100
						end
					end
				end
			end
		
			if target_player:getType() == 1
			then
				if tInv:isItem(8) ~= 0
				then
					if PETS_DAMAGE_DEFENSE[i].PetIndex == tInv:getIndex(8)
					then
						if PETS_DAMAGE_DEFENSE[i].Defense > 0
						then
							Damage = (Damage * (100-PETS_DAMAGE_DEFENSE[i].Defense)) / 100
						end
					end
				end
			end
		end
	end
	
	player = nil
	target_player = nil
	pInv = nil
	tInv = nil

	return Damage
end