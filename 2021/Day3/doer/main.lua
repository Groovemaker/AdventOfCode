--- Submarine Diagnostic Decoder
--- (c) 2021 - Runic
--- Purpose: Getting readings from the Binary Diagnostic Report | https://adventofcode.com/

--- Main
local xTime = os.clock()

--- Basic Structure
local Reader = {...}
local string = {...}
local number = {...}

-- Helper functions
function string.toTable(str)
	local Table = {}
	str:gsub(".",function(c) table.insert(Table,c) end)
	return Table
end

function number.frombin(x)
	local ret = ""
	while x ~= 1 and x ~= 0 do
		ret = tostring (x % 2) .. ret
		x = math.modf (x / 2)
	end
	ret = tostring(x) .. ret
	return ret
end

function tally(t)
	local freq = {}
	for _, v in ipairs(t) do
	  freq[v] = (freq[v] or 0) + 1
	end
	return freq
end

Reader.BoolNum = {[true] = 1, [false] = 0}

-- Datatable
Reader.Data = {}

-- These will hold Gamma and Epsilon rates

-- Most Common bit
Reader.Data.GammaOn = {}
Reader.Data.GammaOff = {}
Reader.Data.Gamma = {}

-- Least Common bit
Reader.Data.EpsilonOn = {}
Reader.Data.EpsilonOff = {}
Reader.Data.Epsilon = {}

-- The Sigma value will be declared with the decoded readings
Reader.Data.Sigma = 0


-- These will hold Life Support Values

Reader.Data.CO2on = {}
Reader.Data.CO2off = {}
Reader.Data.CO2 = {}


Reader.Data.EpsilonOn = {}
Reader.Data.EpsilonOff = {}
Reader.Data.Epsilon = {}




-- Reader.PowerReadings() | Purpose: Decode the Binary Report's power readings
function Reader.PowerReadings(FName)

	-- -- -- [Diagnostic Decoder] -- -- --
	Reader.File = io.open(FName, "r");

	for line in Reader.File:lines() do

		-- Split both lines of binary into arrays
		local GammaRateX = string.toTable(line)
		local EpsilonRateX = string.toTable(line)

		--local EpsilonRateX = string.toTable(line)

		-- Loop through Gamma!
		for  xG = 1, #line do

			-- If its nil, create it
			if Reader.Data.GammaOn[xG] == nil then
				Reader.Data.GammaOn[xG] = 0
			end
			if Reader.Data.GammaOff[xG] == nil then
				Reader.Data.GammaOff[xG] = 0
			end

			-- Current bit is either 1 or 0, feed the corresponding table
			local CurBit = tonumber(GammaRateX[xG])
			if CurBit == 1 then
				Reader.Data.GammaOn[xG] = Reader.Data.GammaOn[xG] + 1
			elseif CurBit == 0 then
				Reader.Data.GammaOff[xG] = Reader.Data.GammaOff[xG] + 1
			end

		end

		-- Loop through Epsilon!
		for  xR = 1, #line do
			-- If its nil, create it
			if Reader.Data.EpsilonOn[xR] == nil then
				Reader.Data.EpsilonOn[xR] = 0
			end
			if Reader.Data.EpsilonOff[xR] == nil then
				Reader.Data.EpsilonOff[xR] = 0
			end

			-- Current bit is either 1 or 0, feed the corresponding table
			local CurBit = tonumber(EpsilonRateX[xR])
			if CurBit == 1 then
				Reader.Data.EpsilonOn[xR] = Reader.Data.EpsilonOn[xR] + 1
			elseif CurBit == 0 then
				Reader.Data.EpsilonOff[xR] = Reader.Data.EpsilonOff[xR] + 1
			end

		end

	end
	-- -- -- [End Diagnostic Decoder] -- -- --

	-- Compile the Values
	for I = 1, #Reader.Data.GammaOn do
		if Reader.Data.GammaOn[I] > Reader.Data.GammaOff[I] then
			table.insert(Reader.Data.Gamma,1)
		else
			table.insert(Reader.Data.Gamma,0)
		end
	end

	for I = 1, #Reader.Data.EpsilonOn do
		if Reader.Data.EpsilonOff[I] > Reader.Data.EpsilonOn[I] then
			table.insert(Reader.Data.Epsilon,1)
		else
			table.insert(Reader.Data.Epsilon,0)
		end
	end

	-- Print Gamma and Epsilon Rates
	local GammaValue = tonumber(table.concat(Reader.Data.Gamma,""),2)
	local EpsilonValue = tonumber(table.concat(Reader.Data.Epsilon,""),2)
	Reader.Data.Sigma = GammaValue * EpsilonValue

	-- DEBUG: Print Gamma and Epsilon
	--print("\nGamma: " .. GammaValue .. "\n")
	--print("Epsilon: " .. EpsilonValue .. "\n")

end

-- Init
function Reader.ReadReport(FName)
	Reader.PowerReadings(FName)
	print("Submarine Diagnostics Reader v0.01 (c) 2021 - Runic\n")
	print("\n-[" .. FName .. "]-\n")
	print("[Values]: \n")
	print("[>\tPower\t---\t" .. Reader.Data.Sigma .. "\t\t<]\n")
	print("Time needed to read report:\n" .. os.clock() - xTime)
end

Reader.ReadReport("./input.txt")