function Trig_ChargeupBegin_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChargeupBegin_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call CreateNUnitsAtLoc( 1, 'e01O', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call ResetUnitAnimation( GetLastCreatedUnit() )
    call SizeUnitOverTime(GetLastCreatedUnit(),5.0,1.0,3.0,false)
    call SaveUnitHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("Chargeup_Effect"),GetLastCreatedUnit())
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_ChargeupBegin takes nothing returns nothing
    set gg_trg_ChargeupBegin = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ChargeupBegin, EVENT_PLAYER_UNIT_SPELL_CHANNEL )
    call TriggerAddCondition( gg_trg_ChargeupBegin, Condition( function Trig_ChargeupBegin_Conditions ) )
    call TriggerAddAction( gg_trg_ChargeupBegin, function Trig_ChargeupBegin_Actions )
endfunction

