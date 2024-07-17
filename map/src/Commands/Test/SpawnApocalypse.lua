if Debug then Debug.beginFile "Commands/Test/SpawnApocalpyse" end
OnInit.trig("SpawnApocalpyse", function(require)
    ---@return boolean
    function Trig_SpawnApocalypse_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_SpawnApocalypse_Actions()
        TriggerExecute(udg_Apocalypse_Trigger[S2I(SubStringBJ(GetEventPlayerChatString(), 17, 999))])
    end

    --===========================================================================
    local i                = 0 ---@type integer
    gg_trg_SpawnApocalypse = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_SpawnApocalypse, Player(i), "-forceapocalypse", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_SpawnApocalypse, Condition(Trig_SpawnApocalypse_Conditions))
    TriggerAddAction(gg_trg_SpawnApocalypse, Trig_SpawnApocalypse_Actions)
end)
if Debug then Debug.endFile() end
