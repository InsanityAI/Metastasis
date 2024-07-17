if Debug then Debug.beginFile "Game/Stations/ST10/ST10ViewLast" end
OnInit.map("ST10ViewLast", function(require)
    ---@return boolean
    function Trig_ST10ViewLast_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A084'))) then
            return false
        end
        return true
    end

    function Trig_ST10ViewLast_Actions()
        udg_TempPoint = LoadLocationHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("PortPlace"))
        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0.25)
    end

    --===========================================================================
    gg_trg_ST10ViewLast = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ST10ViewLast, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ST10ViewLast, Condition(Trig_ST10ViewLast_Conditions))
    TriggerAddAction(gg_trg_ST10ViewLast, Trig_ST10ViewLast_Actions)
end)
if Debug then Debug.endFile() end
