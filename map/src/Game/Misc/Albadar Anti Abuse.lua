if Debug then Debug.beginFile "Game/Misc/AlbadarAntiAbuse" end
OnInit.trig("AlbadarAntiAbuse", function(require)
    ---@return boolean
    function Trig_Albadar_Anti_Abuse_Conditions()
        if (not (udg_ace_Existence == true)) then
            return false
        end
        return true
    end

    function Trig_Albadar_Anti_Abuse_Actions()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_TransportationPlatform))
    end

    --===========================================================================
    gg_trg_Albadar_Anti_Abuse = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Albadar_Anti_Abuse, gg_rct_SS12)
    TriggerAddCondition(gg_trg_Albadar_Anti_Abuse, Condition(Trig_Albadar_Anti_Abuse_Conditions))
    TriggerAddAction(gg_trg_Albadar_Anti_Abuse, Trig_Albadar_Anti_Abuse_Actions)
end)
if Debug then Debug.endFile() end
