if Debug then Debug.beginFile "System/StateTable" end
OnInit.final("System/StateTable", function(require)
    require "PlayerColours"
    require "SetUtils"
    require "TimerQueue"

    --TODO: use .wts to provide these strings
    local GRID_TITLE        = "State table        |r"
    local TITLE_NAME        = "Name:"
    local TITLE_STATUS      = "Status:"
    local TITLE_ROLE        = "Role:"
    local ROLE_UNKNOWN_TEXT = "|cFFFFFFFFUnknown|r"

    ---@enum State
    State                   = {
        Dead = "|cFFFF3333Dead|r",
        Alive = "|cFF33FF33Alive|r",
        Left = "|cFF999999Left|r",
    }

    ---@enum Role
    Role                    = {
        Human = "|cFF00FF00Human|r",
        Alien = "|cFF3399FFAlien|r",
        AlienSpawn = "|cFF3399CCAlien Spawn|r",
        Mutant = "|cFF33FF99Mutant|r",
        MutantSpawn = "|cFF33CC99Mutant Spawn|r",
        Android = "|cFFFFFFFFAndroid|r"
    }

    local NAME_WIDTH        = 0.13
    local STATUS_WIDTH      = 0.07
    local ROLE_WIDTH        = 0.08

    local playerData        = {} ---@type table<player, {row: number, state: string, role: string}>
    local multiboard        = CreateMultiboard()
    local multiboardItems   = table.createMD(2) ---@type table<integer,table<integer, multiboarditem>>

    ---@class StateTable
    StateTable              = {}

    ---@param player player
    ---@return string
    local function formatPlayerName(player)
        return "|c" .. PlayerColours[player].colour .. GetPlayerName(player)
    end

    ---@param player player
    ---@param role Role
    function StateTable.SetPlayerRole(player, role)
        local data = playerData[player]
        data.role = role
        if player == GetLocalPlayer() then
            MultiboardSetItemValue(multiboardItems[data.row][3], data.role)
        end
    end

    ---@param player player
    ---@param state State
    function StateTable.SetPlayerState(player, state)
        local data = playerData[player]
        data.state = state
        MultiboardSetItemValue(multiboardItems[data.row][2], data.state)
    end

    ---@param player player
    function StateTable.UpdatePlayerName(player)
        local data = playerData[player]
        MultiboardSetItemValue(multiboardItems[data.row][1], formatPlayerName(player))
    end

    ---@param player player
    ---@param toPlayer player? if nil it reveals to all
    function StateTable.RevealPlayerRole(player, toPlayer)
        if toPlayer == nil or toPlayer == GetLocalPlayer() then
            local data = playerData[player]
            MultiboardSetItemValue(multiboardItems[data.row][3], data.role)
        end
    end

    local function clearMultiboard()
        MultiboardDisplay(multiboard, false)
        MultiboardClear(multiboard)
        for row, rowData in pairs(multiboardItems) do
            for col, item in pairs(rowData) do
                MultiboardReleaseItem(item)
                multiboardItems[row][col] = nil
            end
        end
    end

    ---@param players force
    function StateTable.InitializeForPlayers(players)
        local playerSet = Set.fromForce(players)
        clearMultiboard()
        MultiboardSetRowCount(multiboard, playerSet:size() + 2)
        MultiboardSetColumnCount(multiboard, 3)
        MultiboardSetItemsStyle(multiboard, true, false) --no icons

        local mbItem = MultiboardGetItem(multiboard, 0, 0)
        MultiboardSetItemWidth(mbItem, NAME_WIDTH)
        MultiboardSetItemValue(mbItem, TITLE_NAME)
        multiboardItems[1][1] = mbItem
        mbItem = MultiboardGetItem(multiboard, 0, 1)
        MultiboardSetItemWidth(mbItem, STATUS_WIDTH)
        MultiboardSetItemValue(mbItem, TITLE_STATUS)
        multiboardItems[1][2] = mbItem
        mbItem = MultiboardGetItem(multiboard, 0, 2)
        MultiboardSetItemWidth(mbItem, ROLE_WIDTH)
        MultiboardSetItemValue(mbItem, TITLE_ROLE)
        multiboardItems[1][3] = mbItem

        multiboardItems[2][1] = mbItem
        multiboardItems[2][2] = mbItem
        multiboardItems[2][3] = mbItem

        local row = 3
        for player in playerSet:elements() do
            playerData[player] = { row = row, state = State.Alive, role = Role.Human }
            mbItem = MultiboardGetItem(multiboard, row - 1, 0)
            MultiboardSetItemValue(mbItem, formatPlayerName(player))
            MultiboardSetItemWidth(mbItem, NAME_WIDTH)
            multiboardItems[row][1] = mbItem

            mbItem = MultiboardGetItem(multiboard, row - 1, 1)
            MultiboardSetItemValue(mbItem, State.Alive)
            MultiboardSetItemWidth(mbItem, STATUS_WIDTH)
            multiboardItems[row][2] = mbItem

            mbItem = MultiboardGetItem(multiboard, row - 1, 2)
            MultiboardSetItemValue(mbItem, ROLE_UNKNOWN_TEXT)
            MultiboardSetItemWidth(mbItem, ROLE_WIDTH)
            multiboardItems[row][3] = mbItem

            StateTable.RevealPlayerRole(player, player)
        end

        MultiboardSetTitleText(multiboard, GRID_TITLE)
        MultiboardDisplay(multiboard, true)
        MultiboardMinimize(multiboard, true)
    end

    local time = 0
    TimerQueue:callPeriodically(1.00, nil, function()
        time = time + 1
        local hours = math.modf(time / 3600)
        local minutes = math.modf(time / 60) - hours * 60
        local seconds = math.fmod(time, 60)
        MultiboardSetTitleText(multiboard, GRID_TITLE .. string.format("\x252d:\x252d:\x252d", hours, minutes, seconds))
    end)
end)
if Debug then Debug.endFile() end
