local DataStoreHandler = {}
local DataStoreService = game:GetService("DataStoreService")

-- Collects the full Table from the DataStore.
local function getAllData(DataStore, DKey)
	-- Using a protected call to avoid errors.
	local success, Table = pcall(function() 
		-- "GetAsync" retrieves Table from the DataStore. Susceptible to fail.
		return DataStore:GetAsync(DKey)
	end)
	
	-- If the operation was successful, return the collected data. If not, return false.
	if success then 
		-- If the Table is empty, initialize the DKey.
		if Table == nil then 
			Table = {}
		end
		
		return Table
	else 
		return false 
	end
end

-- Sets the full Table in the DataStore.
local function setAllData(DataStore, DKey, Table)
	-- Using a protected call to avoid errors.
	local success = pcall(function() 
		-- "SetAsync" saves Table in the DataStore. Susceptible to fail.
		DataStore:SetAsync(DKey, Table)
	end)
	
	-- If the operation was successful, return true. If not, return false.
	if success then 
		return true 
	else 
		return false 
	end
end

-- Gets the value of a specific Key in the DataStore of choice.
function DataStoreHandler.GetData(DataStore, DKey, TKey)
	-- Collect the Data Store object from the given "DataStore" parameter.
	local DataStoreCollected = DataStoreService:GetDataStore(DataStore)
	-- Collects the full Table from the DataStore.
	local collectedData = getAllData(DataStoreCollected, DKey)
	
	-- If the operation was successful, return the value of the Key. If not, return nil and result code 0.
	if collectedData then
		--[[ If the key is empty or the key is not found, return nil and result code 2. 
		If not, return the Key's value alongside with result code 1. ]]
		if collectedData[TKey] ~= nil then
			-- Note: Never assign nil as a value for a Key. It will be treated as a Non-Existent Key.
			return collectedData[TKey], 1
		else
			warn("Key not found.")
			return nil, 2
		end
	else
		warn("Operation Failed.")
		return nil, 0
	end
end

-- Sets the value of a specific Key in the DataStore of choice.
function DataStoreHandler.SetData(DataStore, DKey, TKey, Value)
	-- Collect the Data Store object from the given "DataStore" parameter.
	local DataStoreCollected = DataStoreService:GetDataStore(DataStore)
	-- Collects the full Table from the DataStore.
	local collectedData = getAllData(DataStoreCollected, DKey)
	
	-- This will be changed based on the key existing or not.
	local resultCode = 0
	
	-- If the operation was successful, update the key and return code 1 or 2. If not, return result code 0.
	if collectedData then
		--[[ If the key is empty or the key is not found, change result code to 2. 
		If not, change result code to 1. ]]
		if collectedData[TKey] ~= nil then
			resultCode = 1
		else
			warn("Key not Found. Creating a new Key...")
			resultCode = 2
		end
		
		-- Assign the Key's value and save the Table.
		collectedData[TKey] = Value
		
		-- Sets the full Table in the DataStore.
		local success = setAllData(DataStoreCollected, DKey, collectedData)
		
		-- If the operation was successful, return assigned result code. If not, return result code 0.
		if success then
			return resultCode
		else
			warn("Operation Failed.")
			return 0
		end
	else
		warn("Operation Failed.")
		return 0
	end
end

return DataStoreHandler
