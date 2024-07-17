if Debug then Debug.beginFile "Commands/Test/Help" end
OnInit.map("Help", function(require)
    ---@return boolean
    function Trig_Help_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_Help_Actions()
        DisplayTextToForce(GetPlayersAll(),
            "TESTING COMMANDS:\n-help\n-EP ### (grants EP to alien/mutant/android)\n-nowin (disables win conditions\n-mine (takes control of selected units)\n-forcerandom ## (forces random event # to occur, type -randomevents for_ a list)\n-spawn #### (spawns unit based on unit code; for_ most units this is custom_####, type -spawnhelp for_ further info)\n-forceapocalypse (forces apocalypse event; 1 for_ USI fleet and 2 for_ black hole)\n-playerhero (makes selected unit playerhero; you lose if it dies)\n-test_abilities (grants ultrablink ability to selected units)\n-hostile (selected unit becomes hostile)\n-vision")
    end

    --===========================================================================
    local i = 0
    gg_trg_Help = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_Help, Player(i), "-help", true)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_Help, Condition(Trig_Help_Conditions))
    TriggerAddAction(gg_trg_Help, Trig_Help_Actions)
end)
if Debug then Debug.endFile() end
