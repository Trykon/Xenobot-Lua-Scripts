local container = 'backpack' --write your main bp's name
local InboxFull = true -- don't touch
local BpsCount = 6 -- amount of your stacked bps, these have to be stacked properly and without any items inside
local CurItems = 0  -- don't touch
local BpFull = false -- don't touch
local Logout = false -- I have set distance statue as logout place, change in waypoints last leaver place to set it for yourcelf
--- not all items are listed in there, because I was nat selling all of them and I was wearing boh and rh, so it would mess up some 

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
function onWalkerSelectLabel(labelName)


if (labelName == "SellMagic") then
	Walker.Stop()
		Self.SayToNpc("Hi")
		sleep(math.random(1000, 1500))
		Self.SayToNpc("trade")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Wand of Inferno")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Wand of Cosmic Energy")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Wand of Decay")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Wand of Draconia")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Wand of Starstorm")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Wand of Dragonbreath")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Power Ring")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Magic Light Wand")
		sleep(math.random(1000, 1500))
	Walker.Start()

elseif (labelName == "SellRest") then
	Walker.Stop()
		Self.SayToNpc("Hi")
		sleep(math.random(1000, 1500))
		Self.SayToNpc("trade")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Blue Robe")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Broadsword")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Crown Armor")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Crown Helmet")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Crown Legs")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Crown Shield")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Crusader Helmet")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Dragon Shield")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Fire Axe")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Fire Sword")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Guardian Shield")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Ice Rapier")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Obsidian Lance")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("Spike Sword")
		sleep(math.random(1000, 1500))
		Self.ShopSellAllItems("War Hammer")
		sleep(math.random(1000, 1500))
	Walker.Start()

elseif (labelName == "DepositGold") then
	Walker.Stop()
		Self.SayToNpc("Hi")
		sleep(math.random(2000, 2500))
		Self.SayToNpc("deposit all")
        sleep(math.random(2000, 2500))
        Self.SayToNpc("yes")
		sleep(math.random(2000, 2500))
	Walker.Start()

elseif (labelName == "GetItems") then
		CurItems = 0
		BpFull = false
		Self.OpenLocker()
		withdraw()

elseif (labelName == "Start") then
	Self.CloseContainers()
	Self.OpenMainBackpack(false)
		
elseif (labelName == "WaitForNext") then
	if(InboxFull == false) then
		if(Logout == true) then
			gotoLabel("Logout")
		else
			Walker.Stop()
		end
	else
		gotoLabel("Start")
	end
end
end



function withdraw()
    local cfrom = Container.New('Your Inbox')
    local cto = Container.New(container)
    while not cfrom:isOpen() do
        cfrom = Container.New('Your Inbox')
        local dp = Container.New('Locker')
        for mailspot, touse in dp:iItems() do
            if touse.id == 12902 then
                dp:UseItem(mailspot, true)
                wait(500, 1700)
            end
        end
    end
    if cfrom:isOpen() and cto:isOpen() then
		while (cfrom:ItemCount() >= 0) do
			local slot = 0
			if(cfrom:ItemCount() == 0) then
				InboxFull = false
				break
			else
				InboxFull = true
			end
            local items = cfrom:GetItemData(slot)
			if Self.Cap() - Item.GetWeight(items.id) < 1 then
                error('You need '..math.floor((Item.GetWeight(items.id)+1)-Self.Cap())..' cap to pick this item.') 
                break
			end
            while Self.Cap() - Item.GetWeight(items.id) >= 1 do
                if not cto:isFull() then
					if (CurItems < (BpsCount * 19)) then
						cfrom:MoveItemToContainer(slot, cto:Index(), 19, 100)
						wait(300, 1200)
						CurItems = CurItems + 1
						break
					else
						BpFull = true
						break
					end
                else
                    for spot, item in cto:iItems() do
                        if Item.isContainer(item.id) then
                            cto:UseItem(spot, true)
                            wait(500, 1600)
                        end
                    end
                end
            end
			if (BpFull == true) then
				error('Your bp is full.')
				break
			end
        end
    end
end