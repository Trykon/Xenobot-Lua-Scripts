local ManaMax = 100
local ManaMin = 10
local ManaPot = "mana potion"

local HpMax = 20
local HpMin = 10
local HpPot = "health potion"

local AmmoMax = 100
local AmmoMin = 20
local Ammo = "arrow"

local RuneMax = 0
local RuneMin = 0
local RuneName = "avalanche"

local ItemBP = "brocade backpack"
local GoldBP = "golden backpack"
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
elseif(labelName == "BuyPots")then
	Walker.Stop()
	Self.SayToNpc("hi")
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
	wait(1000)
	Walker.Start()
elseif(labelName == "BuyRunes") then
	Walker.Stop()
	Self.SayToNpc("hi")
	wait(200,1000)
	Self.SayToNpc("trade")
	wait(200, 1000)
	Self.ShopBuyItemsUpTo(RuneName, RuneMax)
	wait(1000)
	Walker.Start()
elseif(labelName == "CheckBefore") then
	if(Self.ItemCount(Ammo, true) < AmmoMax or Self.ItemCount(RuneName, true) < RuneMax or Self.ItemCount(ManaPot, true) < ManaMax or Self.ItemCount(HpPot, true) < HpMax) then
		gotoLabel("RestartBps")
	end
elseif(labelName == "RestartBps") then
	Walker.Stop()
	Self.CloseContainers()
	wait(200)
	Self.OpenMainBackpack(true)
	Container.GetFirst():OpenChildren(ItemBP)
	wait(1000)
	Container.GetFirst():OpenChildren(GoldBP)
	wait(1000)		
	Container.GetByName(ItemBP):Minimize()
	wait(1000)
	Container.GetByName(GoldBP):Minimize()
	wait(200)
	Walker.Start()
elseif(labelName == "Check") then
	if(Self.ItemCount(Ammo, true) > AmmoMin or Self.ItemCount(RuneName, true) > RuneMin or Self.ItemCount(ManaPot, true) > ManaMin or Self.ItemCount(HpPot, true) > HpMin) then
		gotoLabel("StartHunt")
	end
end
end