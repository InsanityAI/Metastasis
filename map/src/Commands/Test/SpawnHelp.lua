if Debug then Debug.beginFile "Commands/Test/SpawnHelp" end
OnInit.trig("SpawnHelp", function(require)
    ---@return boolean
    function Trig_SpawnHelp_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_SpawnHelp_Actions()
        DisplayTextToForce(GetPlayersAll(),
            "For standard wc3 units, you can simply use the unit's name. '-spawn peasant' for example will spawn a peasant. To get the code for any unit ingame, select it and enter '-spawncode'. Most codes will be of the form custom_h0XY, where X and Y are either numbers or letters. The defiler mutant for example is custom_h01V")
    end

    --===========================================================================
    local i          = 0 ---@type integer
    gg_trg_SpawnHelp = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_SpawnHelp, Player(i), "-spawnhelp", true)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_SpawnHelp, Condition(Trig_SpawnHelp_Conditions))
    TriggerAddAction(gg_trg_SpawnHelp, Trig_SpawnHelp_Actions)
end)
if Debug then Debug.endFile() end
