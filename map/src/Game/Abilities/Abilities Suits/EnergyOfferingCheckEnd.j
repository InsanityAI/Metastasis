function Trig_EnergyOfferingCheckEnd_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0A3' ) ) then
        return false
    endif
    return true
endfunction

function Trig_EnergyOfferingCheckEnd_Actions takes nothing returns nothing
    local timer l=LoadTimerHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("EnergyOffering_CheckTimer"))
    call FlushChildHashtable(LS(),GetHandleId(l))
    call PauseTimer(l)
    call DestroyTimer(l)
endfunction

//===========================================================================
function InitTrig_EnergyOfferingCheckEnd takes nothing returns nothing
    set gg_trg_EnergyOfferingCheckEnd = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_EnergyOfferingCheckEnd, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddCondition( gg_trg_EnergyOfferingCheckEnd, Condition( function Trig_EnergyOfferingCheckEnd_Conditions ) )
    call TriggerAddAction( gg_trg_EnergyOfferingCheckEnd, function Trig_EnergyOfferingCheckEnd_Actions )
endfunction

