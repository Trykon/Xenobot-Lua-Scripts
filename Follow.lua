local target = "Trykon The Great"
local ValidMonsters = {"Wyvern", "Bonebeast", "Necromancer", "Vicious Squire", "Blood Priest", "Lich", "Hero", "Renegade Knight", "Vile Grandmaster", "Undead Gladiator"}
local MonsterCheck = {}
local MonsterAmount = 0


function setMonsters()
	for _, mname in pairs(ValidMonsters) do
		MonsterCheck[mname] = true
	end
end
do
setMonsters()
Module.New("follow", function(module)
	MonsterAmount = 0
	for name, c in Creature.iMonsters() do
		if(MonsterCheck[name]==true) then
			Targeting.Start()
			MonsterAmount = 1
			break
		end
	end
	if(MonsterAmount == 0) then
		Targeting.Stop()
		local player = Creature(target)
		if player:isOnScreen(true) then
			Creature.Follow(target)
		end
	end
	module:Delay(1000)
end)
end