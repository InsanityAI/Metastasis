if Debug and Debug.beginFile then Debug.beginFile("MDTable") end
--[[-----------------------------------------------------------------------------------------------------------------------------------------------
*   ----------------------------------------
*   | Multidimensional Table (X-Lite) v1.1 |
*   ----------------------------------------
*
*    Creator: Eikonium
*    Contributors: Bribe
*        --> https://www.hiveworkshop.com/threads/multidimensional-table.353717/
*
*        - Multidimensional tables are tables that allow for direct access of multiple table dimensions without the need of manual subtable creation.
*        - This X-Lite-version only offers the ability to create multi-dimensional tables, without any additional API perks of the standard MDTable or even MDTable Lite.
*
*    table.createMD(numDimensions: integer) --> table
*          Creates an MDTable with the specified number of dimensions. E.g. "T = table.createMD(3)" will allow you to read from and write to T[key1][key2][key3] for any arbitrary set of 3 keys.
*          You can think of it like a tree with constant depth that only allows you to write into the "leaf level" (using exactly the number of keys as dimensions specified).
*        - In the example with 3 dimensions, you should only write to T[key1][key2][key3], never to T[key1] or T[key1][key2].
*          Reading is fine on every level, but you are probably not interested in the subtable stored in T[key1].
*          You can however manually save further tables in T[key1][key2][key3] (at leaf level).
*        - MDTables will automatically create subtables on demand, i.e. upon reading from or writing to a combination of keys.
-------------------------------------------------------------------------------------------------------------------------------------------------]]

-- disable sumneko extension warnings for imported resource
---@diagnostic disable

do
    local dimensionStorage = setmetatable({}, { __mode = 'k' })

    local repeater = {
        __index = function(self, key)
            local new = dimensionStorage[self] > 2 and table.createMD(dimensionStorage[self] - 1) or {}
            rawset(self, key, new)
            return new
        end
    }

    ---Create a new Multidimensional Table.
    ---@param numDimensions integer
    function table.createMD(numDimensions)
        local newTable = {}
        dimensionStorage[newTable] = numDimensions
        return setmetatable(newTable, repeater)
    end
end
if Debug and Debug.endFile then Debug.endFile() end
