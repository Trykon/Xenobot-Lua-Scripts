local ManaMax = 300
local ManaMin = 100
local ManaPot = "strong mana potion"

local HpMax = 30
local HpMin = 10
local HpPot = "great spirit potion"

local AmmoMax = 900
local AmmoMin = 300
local Ammo = "crystalline arrow"

local RuneMax = 0
local RuneMin = 0
local RuneName = "avalanche"

local ItemBP = "deepling backpack"
local StackBP = "camouflage backpack"
local GoldBP = "golden backpack"

local MinCap = 100
local hardcore = true
----------------------------------------------------------------
--- Walker and labels to set:
--- start at depo
--- 1. RestartBps
--- way to bank
--- 2. DepositGold
--- way to potion shop
--- 3. BuyPots
--- way to ammo
--- 4. BuyAmmo - if you need ammo
--- way to rune shop
--- 5. BuyRunes - if you need runes
--- way to depo
--- 6. CheckBefore
--- way to hunt place
--- 7. StartHunt
--- route around spawn
--- 8. Check
--- way to depo
--- built in reach depo function in client
--- built in deposit items function in client
----------------------------------------------------------------
registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
print("Full afk script by Trykon")
print("Happy Hunting!")
function onWalkerSelectLabel(labelName)
if(labelName == "DepositGold") then
	Walker.Stop()
	Self.SayToNpc("hi")
	wait(200,1000)
	Self.SayToNpc("deposit all")
	wait(200, 1000)
	Self.SayToNpc("yes")
	wait(1000)
	Walker.Start()
elseif(labelName == "Hardcore") then
	if(hardcore == false) then
		gotoLabel("SkipHardcore")
	end
elseif(labelName == "BuyPots")then
	Walker.Stop()
	Self.SayToNpc("hi")
	wait(200,1000)
	Self.SayToNpc("vial")
	wait(200,1000)
	Self.SayToNpc("yes")
	wait(200,1000)
	Self.SayToNpc("yes")
	wait(200,1000)
	Self.SayToNpc("yes")
	wait(200,1000)
	Self.SayToNpc("trade")
	wait(200, 1000)
	Self.ShopBuyItemsUpTo(HpPot, HpMax)
	wait(200, 1000)
	Self.ShopBuyItemsUpTo(ManaPot, ManaMax)
	wait(1000)
	Walker.Start()
elseif(labelName == "BuyAmmo") then
	Walker.Stop()
	Self.SayToNpc("hi")
	wait(200,1000)
	Self.SayToNpc("trade")
	wait(200, 1000)
	Self.ShopBuyItemsUpTo(Ammo, AmmoMax)
	wait(200, 1000)
	wait(1000)
	Walker.Start()
elseif(labelName == "BuyRunes") then
	Walker.Stop()
	Self.SayToNpc("hi")
	wait(200,1000)
	Self.SayToNpc("trade")
	wait(200, 1000)
	Self.ShopBuyItemsUpTo(RuneName, RuneMax)
	wait(200, 1000)
	wait(1000)
	Walker.Start()
elseif(labelName == "CheckBefore") then
	if(Self.Cap() < MinCap or Self.ItemCount(HpPot) < HpMax or Self.ItemCount(Ammo) < AmmoMax or Self.ItemCount(RuneName) < RuneMax or Self.ItemCount(ManaPot) < ManaMax) then
		gotoLabel("RestartBps")
	else
		print("Check passed")
	end
elseif(labelName == "RestartBps") then
	Walker.Stop()
	Self.CloseContainers()
	wait(200)
	Self.OpenMainBackpack(true)
	Container.GetFirst():OpenChildren(ItemBP)
	wait(1000)
	Container.GetFirst():OpenChildren(StackBP)
	wait(1000)		
	Container.GetFirst():OpenChildren(GoldBP)
	wait(1000)		
	Container.GetByName(ItemBP):Minimize()
	wait(1000)
	Container.GetByName(StackBP):Minimize()
	wait(1000)
	Container.GetByName(GoldBP):Minimize()
	wait(200)
	Walker.Start()
elseif(labelName == "Check") then
	if(Self.Cap() >= MinCap and Self.ItemCount(Ammo) >= AmmoMin and Self.ItemCount(HpPot) >= HpMin and Self.ItemCount(RuneName) >= RuneMin and Self.ItemCount(ManaPot) >= ManaMin) then
		gotoLabel("StartHunt")
	else
		print("No supplies")
	end
end
end
