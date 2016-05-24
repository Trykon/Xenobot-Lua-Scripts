

local checkItems = true
local itemsToCheck = 15793
local itemsAmount = 900



registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
function onWalkerSelectLabel(labelName)


if (labelName == "CheckCap") then
	Walker.Stop()
	sleep(math.random(500, 1000))
	if (Self.Cap()<110) then
		gotoLabel ("DropVials")
		Walker.Start()
	else
		gotoLabel ("CheckItems")
		Walker.Start()
	end
	
elseif(labelName == "DropVials") then
	Walker.Stop()
	sleep(math.random(500, 1000))
	Self.DropFlasks(Self.Position().x, Self.Position().y, Self.Position().z)
	sleep(math.random(500, 1000))
	if(Self.Cap()<100) then
		gotoLabel ("DropGold")
		Walker.Start()
	else
		gotoLabel ("CheckItems")
		Walker.Start()
	end
	
elseif(labelName == "DropGold") then
	Walker.Stop()
	sleep(math.random(500, 1000))
	if(Self.ItemCount("gold coin")>((100 - Self.Cap())*10)) then
		Self.DropItem(Self.Position().x, Self.Position().y, Self.Position().z, "gold coin", (100 - Self.Cap())*10)
		sleep(math.random(5000, 10000))
	end
	gotoLabel ("CheckItems")
	Walker.Start()
	
elseif(labelName == "CheckItems") then
	Walker.Stop()
	sleep(math.random(500, 1000))
	if(checkItems) then
		if(Self.ItemCount(itemsToCheck)<(itemsAmount*30/100)) then
			print("Using one of " ..Self.ItemCount(itemsToCheck).. " crystalline arrows...")
		end
		
	end
	sleep(math.random(50000, 100000))
	gotoLabel("CheckCap")
	Walker.Start()
end
end
