

local checkItems = true
local itemsToCheck = 15793
local itemsAmount = 900
local checkItemsOften = 60
local curCheck = 0

Module.New("DropVialsGoldv2", function(module)
    if (Self.Cap()<110) then
		Self.DropFlasks(Self.Position().x, Self.Position().y, Self.Position().z)
		if(Self.Cap()<100) then
			if(Self.ItemCount("gold coin")>((100 - Self.Cap())*10)) then
				Self.DropItem(Self.Position().x, Self.Position().y, Self.Position().z, "gold coin", (100 - Self.Cap())*10)
			end
		end
	end
	if(checkItems == false) then
		curCheck = curCheck + 1
		if(curCheck > checkItemsOften) then
			checkItems = true
			curCheck = 0
		end
	end
	if(checkItems) then
		if(Self.ItemCount(itemsToCheck)<(itemsAmount*30/100)) then
			print("Using one of " ..Self.ItemCount(itemsToCheck).. " "..Item.GetName(itemsToCheck).."s...")
			checkItems = false
		end
	end
	module:Delay(1000)
end)