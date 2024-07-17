if Debug then Debug.beginFile "Commands/Unstuck" end
OnInit.trig("Unstuck", function(require)
    --Credits to Tal0n for RunCinematicUnstuck functions
    ---@param p player
    ---@param enable boolean
    function RunCinematicUnstuck(p, enable)
        if (GetLocalPlayer() == p) then    -- the player who typed -unstuck
            ClearTextMessages()            -- this can probably be disabled but it clears messages sent from triggers usually
            ShowInterface(enable, 1.5)     -- disables/enables player interface
            EnableUserControl(enable)      -- disables/enables player cursor and control
            EnableOcclusion(enable)
            EnableWorldFogBoundary(enable) -- likely fixes filter bugs
        end
    end

    ---@return boolean
    function CinematicUnstuckConditionsKappa()
        local p = GetTriggerPlayer() ---@type player
        RunCinematicUnstuck(p, false) -- calls for a set of interface toggles offward
        RunCinematicUnstuck(p, true)  -- calls for a set of interface toggles onward

        return true
    end

    local t = CreateTrigger() ---@type trigger
    local i = 0 ---@type integer

    while i ~= 13 do                                                       -- this stops at brown ( player 12 )
        TriggerRegisterPlayerChatEvent(t, Player(i), "-unstuck", true)     -- add the command for each player
        TriggerAddCondition(t, Condition(CinematicUnstuckConditionsKappa)) -- the code for the command to work
        i = i + 1                                                          -- go from red/player to next player
    end
end)
if Debug then Debug.endFile() end
