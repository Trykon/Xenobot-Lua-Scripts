local SSTime = 9
local LogBefore = 2
local timeNow = 0
while (true) do
	if(Self.isInPz()) then
		if(timeNow >= (SSTime-LogBefore) and timeNow < SSTime) then
			Walker.Stop()
		end
	else
		for k, v in pairs(os.date("*t")) do
			if(k == 'hour') then
				timeNow = tonumber(v)
			end
		end
	end
	wait(1000)
end