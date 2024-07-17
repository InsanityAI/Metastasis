if Debug and Debug.beginFile then Debug.beginFile("SyncedTable") end
--[[

---------------------------
-- | SyncedTable v1.1a | --
---------------------------

 by Eikonium

 --> https://www.hiveworkshop.com/threads/syncedtable.353715/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| A Lua table with a multiplayer-safe pairs()-iteration.
| Syncedtables achieve this safe pairs() by looping in the same order that elements got inserted into it (can change upon element removal), which is deterministic and identical across clients.
| You can do everything with a SyncedTable that you could do with a normal Lua table, with the few restrictions listed below.
| SyncedTables are pretty quick on adding and removing elements as well as looping over them, but they add some overhead to table creation. Thus, only create a SyncedTable instead of a normal one, if you intend to loop over it via pairs() in multiplayer.
|
| -------
| | API |
| -------
|    SyncedTable.create([existingTable]) --> SyncedTable
|        - Creates a new SyncedTable, i.e. a Lua-table with a multiplayer-synchronized pairs()-iteration.
|        - Specifying an existing table will add all of its (key,value)-pairs to the new SyncedTable. In this case, SyncedTable will derive its initial loop order from it by sorting all keys by datatype (primarily) and by normal <-relation (secondarily).
|          Hence, creation will throw an error, if existingTable contains keys of the same type that can not be <-sorted.
|        - Example:
|           local PlayerColors = SyncedTable.create()
|           PlayerColors[Player(0)] = "FF0303"
|           PlayerColors[Player(1)] = "0042FF"
|           PlayerColors[Player(2)] = "1CE6B9"
|           for player, color in pairs(PlayerColors) do -- loop order will be the same for all clients in a multiplayer game (not that it matters in this particular example)
|               print("|cff" .. color .. GetPlayerName(player) .. "|r")
|           end
|    SyncedTable.isSyncedTable(table) --> boolean
|        - Returns true, if the specified table is a SyncedTable, and false otherwise.
| ----------------
| | Restrictions |
| ----------------
|        - Detaching a SyncedTable's metatable or overwriting it's __index, __newindex or __pairs metamethods will stop it from working. You can however add any other metamethod to it's existing metatable.
|        - You can't use next(S)==nil on a SyncedTable S to check, whether it is empty or not. You can however use pairs(S)(S)==nil to check the same (although this isn't super performant).
--]] -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- disable sumneko extension warnings for imported resource
---@diagnostic disable

do
    --comparison function that allows sorting a set of objects that already have a natural order.
    local function comparisonFunc(a, b)
        local t1, t2 = type(a), type(b)
        if t1 == t2 then
            return a < b
        end
        return t1 < t2
    end

    --Help data structures for SyncedTable loops that memorize the current table key (and it's array position) that is looped over.
    local loopKeys = {} ---@type table<integer,any> memorizes the current loop key for a given loopId.
    local loopCounters = {} ---@type table<integer,integer> memorizes the array position of the current loop key for a given loopId.
    local loopId = 0 -- an Id unique per loop currently running on any SyncedTable. Recycled after a loop has finished running. Counts upwards.

    ---@class SyncedTable : table
    SyncedTable = {}

    ---Creates a table with a multiplayer-synchronized pairs-function, i.e. you can iterate over it via pairs(table) without fearing desyncs.
    ---After creation, you can use it like any other table.
    ---The implementation adds overhead to creating the table, adding and removing elements, but keeps the loop itself very performant. So you should only used syncedTables, if you plan to iterate over it.
    ---You are both allowed to add and remove elements during a pairs()-loop.
    ---Specifying an existing table as input parameter will add its elements to the new SyncedTable. This only works for input tables, where all keys are sortable via the "<"-relation, i.e. numbers, strings and objects listening to some __lt-metamethod.
    ---@param existingTable? table any lua table, whose elements you want to add to the new SyncedTable. The table is required to only contain keys that can be sorted via the '<'-relation. E.g. you might write SyncedTable.create{x = 10, y = 3}.
    ---@return SyncedTable
    function SyncedTable.create(existingTable)
        local new = {}
        local metatable = { class = SyncedTable }
        local data = {}
        --orderedKeys and keyToIndex don't need to be weak tables. They reference keys if and only if those keys are used in data.
        local orderedKeys = {} --array of all keys, defining loop order.
        local keyToIndex = {}  --mirrored orderedKeys, i.e. keyToIndex[key] = int <=> orderedKeys[int] = key. This is used to speed up the process of removing (key, value)-pairs from the syncedTable (to prevent array search in orderendKeys).
        local numKeys = 0

        --If existingTable was provided, register all keys from the existing table to the keyToIndex and orderedKeys help tables.
        if existingTable then
            --prepare orderedKeys array by sorting all existing keys
            for k, v in pairs(existingTable) do
                numKeys = numKeys + 1
                orderedKeys[numKeys] = k --> the resulting orderedKeys is asynchronous at this point
                data[k] = v
            end
            table.sort(orderedKeys, comparisonFunc) --result is synchronous for all players
            --fill keyToIndex accordingly
            for i = 1, numKeys do
                keyToIndex[orderedKeys[i]] = i
            end
        end

        --Catch read action
        metatable.__index = function(t, key)
            return data[key]
        end

        --Catch write action
        metatable.__newindex = function(t, key, value)
            --Case 1: User tries to remove an existing (key,value) pair by writing table[key] = nil.
            if data[key] ~= nil and value == nil then
                --swap last element to the slot being removed (in the iteration order array)
                local i = keyToIndex[key]             --slot of the key, which is getting removed
                keyToIndex[orderedKeys[numKeys]] = i  --first set last slot to i
                keyToIndex[key] = nil                 --afterwards nil current key (has to be afterwards, when i == numKeys)
                orderedKeys[i] = orderedKeys[numKeys] --i refers to the old keyToIndex[key]
                orderedKeys[numKeys] = nil
                numKeys = numKeys - 1
                --Case 2: User tries to add a new key to the table (i.e. table[key] doesn't yet exist and both key and value are not nil)
            elseif data[key] == nil and key ~= nil and value ~= nil then
                numKeys = numKeys + 1
                keyToIndex[key] = numKeys
                orderedKeys[numKeys] = key
            end
            --Case 3: User tries to change an existing key to a different non-nil value (i.e. table[existingKey] = value ~= nil)
            -- -> no action necessary apart from the all cases line
            --Case 4: User tries to set table[nil]=value or table[key]=nil for a non-existent key (would be case 1 for an existent key)
            -- -> don't do anything.
            --In all cases, do the following:
            data[key] = value --doesn't have any effect for case 4.
        end

        --- Iterator function that is used the retreive the next loop element within a SyncedTable loop.
        --- This iterator is identical for every loop on the same SyncedTable. Different loops are distinguished by different loopIds.
        --- The iteration loops through orderedKeys[] in ascending order, saving the current position and key externally.
        ---@param state integer loopId to identify the loop to fetch the next element for.
        ---@return any key, any value
        local function iterator(state)
            if loopKeys[state] == orderedKeys[loopCounters[state]] then --check, if the last iterated key is still in place. If not, it has been removed in the last part of the iteration.
                loopCounters[state] = loopCounters[state] +
                1                                                       --only increase i, when the last iterated key is still part of the table. Otherwise use the same i again. This allows the removal of (key,value)-pairs inside the pairs()-iteration.
            end
            local i = loopCounters[state]
            loopKeys[state] = orderedKeys[i]
            return orderedKeys[i], data[orderedKeys[i]] -- (key,value)
        end

        --- Metamethod to define the pairs-loop for a SyncedTable. Runs every time a new loop is initiated.
        --- Fetches a unique loopId and returns the above iterator together with this id.
        ---@param t SyncedTable
        ---@return function iterator
        ---@return integer state loopId of the new loop
        metatable.__pairs = function(t)
            --if the current maximum loopId is still in use (the loopKey of that loop not being nil implies that the loop is still running), increase that loopId by one.
            while loopKeys[loopId] ~= nil do --it's near to impossible that this while-loop runs more than once, because the next higher loopId is entirely new, if not reached again after arithmetic overflow, which requires around 4 billion loops to run. Theoretically achievable, if current loop is set on hold via coroutine.
                loopId = loopId +
                1                            -- resistent against arithmetic overflow, because math.maxinteger + 1 yields math.mininteger, from where loopId would simply continue to count upwards.
            end
            local state = loopId
            loopCounters[state] = 1
            return iterator, state, nil
        end

        setmetatable(new, metatable)
        return new
    end

    ---Returns true, if the input argument is a SyncedTable, and false otherwise.
    ---@param anyObject any
    ---@return boolean isSyncedTable
    SyncedTable.isSyncedTable = function(anyObject)
        local metatable = getmetatable(anyObject)
        return metatable and metatable['class'] == SyncedTable
    end

    --Allows writing SyncedTable() instead of SyncedTable.create().
    setmetatable(SyncedTable, {
        __call = function(func, t)
            return SyncedTable.create(t)
        end
    })
end

if Debug and Debug.endFile then Debug.endFile() end
