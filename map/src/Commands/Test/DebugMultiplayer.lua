if Debug then Debug.beginFile "Commands/Test/DebugMultiplayer" end
OnInit.trig("DebugMultiplayer", function(require)
    playersToggled = 0 ---@type integer
    playersActive  = 0 ---@type integer


    ---@return boolean
    function Trig_DebugMultiplayer_Conditions()
        return true
    end

    function SetActivePlayers()
        if GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING and udg_Player_Left[GetConvertedPlayerId(GetEnumPlayer())] == false then
            playersActive = playersActive + 1
        end
    end

    function Trig_DebugMultiplayer_Actions()
        --If not toggled before (it toggles only once for obvious reasons)
        if udg_PlayerDebugMultiplayerToggled[GetPlayerId(GetTriggerPlayer())] == false then
            udg_PlayerDebugMultiplayerToggled[GetPlayerId(GetTriggerPlayer())] = true --So it won't enter here again

            --Increase players toggled by one
            playersToggled = playersToggled + 1


            --Enumerate/Count how many players there are ((sets playersActive))
            playersActive = 0
            ForForce(GetPlayersAll(), SetActivePlayers)

            DisplayTextToForce(GetPlayersAll(),
                I2S(playersToggled) .. "/" .. I2S(playersActive) .. " have voted for Debugging mode.")

            --If all players wrote -debug, activate it.
            if (playersToggled == playersActive) then
                udg_TESTING = true

                DisplayTextToForce(GetPlayersAll(), "Debugging Mode A C T I V A T E D")
            end
        end
    end

    --===========================================================================
    local i                 = 0 ---@type integer
    gg_trg_DebugMultiplayer = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_DebugMultiplayer, Player(i), "-debug", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_DebugMultiplayer, Condition(Trig_DebugMultiplayer_Conditions))
    TriggerAddAction(gg_trg_DebugMultiplayer, Trig_DebugMultiplayer_Actions)
end)
if Debug then Debug.endFile() end
