if Debug then Debug.beginFile "Game/Abilities/Space/PrismRocketsEndAlbadar" end
OnInit.map("PrismRocketsEndAlbadar", function(require)
    ---@return boolean
    function Trig_PrismRocketsEndAlbadar_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07L'))) then
            return false
        end
        return true
    end

    function Trig_PrismRocketsEndAlbadar_Actions()
        local t = LoadTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("PrismRocket_Timer")) ---@type timer
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTimer(t)
        PauseTimer(t)
    end

    --===========================================================================
    gg_trg_PrismRocketsEndAlbadar = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PrismRocketsEndAlbadar, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_PrismRocketsEndAlbadar, Condition(Trig_PrismRocketsEndAlbadar_Conditions))
    TriggerAddAction(gg_trg_PrismRocketsEndAlbadar, Trig_PrismRocketsEndAlbadar_Actions)
end)
if Debug then Debug.endFile() end
