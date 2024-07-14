function Trig_ChargeupStop_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChargeupStop_Actions takes nothing returns nothing
    call KillUnit(LoadUnitHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("Chargeup_Effect")))
endfunction

//===========================================================================
function InitTrig_ChargeupStop takes nothing returns nothing
    set gg_trg_ChargeupStop = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ChargeupStop, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddCondition( gg_trg_ChargeupStop, Condition( function Trig_ChargeupStop_Conditions ) )
    call TriggerAddAction( gg_trg_ChargeupStop, function Trig_ChargeupStop_Actions )
endfunction

