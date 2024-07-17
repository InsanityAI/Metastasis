if Debug then Debug.beginFile "Commands/Test/GlobalVision" end
OnInit.trigg("GlobalVision", function(require)
    ---@return boolean
    function Trig_GlobalVision_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_GlobalVision_Actions()
        FogEnableOff()
        FogMaskEnableOff()
        CreateFogModifierRectBJ(true, GetTriggerPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect())
    end

    --===========================================================================
    local i             = 0 ---@type integer
    gg_trg_GlobalVision = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_GlobalVision, Player(i), "-vision", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_GlobalVision, Condition(Trig_GlobalVision_Conditions))
    TriggerAddAction(gg_trg_GlobalVision, Trig_GlobalVision_Actions)
end)
if Debug then Debug.endFile() end
