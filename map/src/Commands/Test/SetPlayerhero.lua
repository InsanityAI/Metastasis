if Debug then Debug.beginFile "Commands/Test/SetPlayerhero" end
OnInit.trig("SetPlayerhero", function(require)
    ---@return boolean
    function Trig_SetPlayerhero_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_SetPlayerhero_Func002A()
        udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())] = GetEnumUnit()
    end

    function Trig_SetPlayerhero_Actions()
        ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), Trig_SetPlayerhero_Func002A)
    end

    --===========================================================================

    local i              = 0 ---@type integer
    gg_trg_SetPlayerhero = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_SetPlayerhero, Player(i), "-playerhero", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_SetPlayerhero, Condition(Trig_SetPlayerhero_Conditions))
    TriggerAddAction(gg_trg_SetPlayerhero, Trig_SetPlayerhero_Actions)
end)
if Debug then Debug.endFile() end
