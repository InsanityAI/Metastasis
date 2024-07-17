if Debug then Debug.beginFile "Game/Abilities/Android/PrismRocketsEnd" end
OnInit.trig("PrismRocketsEnd", function(require)
    ---@return boolean
    function Trig_PrismRocketsEnd_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05U'))) then
            return false
        end
        return true
    end

    function Trig_PrismRocketsEnd_Actions()
        local t = LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("PrismRocket_Timer")) ---@type timer
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTimer(t)
        PauseTimer(t)
    end

    --===========================================================================
    gg_trg_PrismRocketsEnd = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PrismRocketsEnd, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_PrismRocketsEnd, Condition(Trig_PrismRocketsEnd_Conditions))
    TriggerAddAction(gg_trg_PrismRocketsEnd, Trig_PrismRocketsEnd_Actions)
end)
if Debug then Debug.endFile() end
