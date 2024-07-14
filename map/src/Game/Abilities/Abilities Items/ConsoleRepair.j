function Trig_ConsoleRepair_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ConsoleRepair_Func003Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A06R', GetEnumUnit()) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ConsoleRepair_Func003A takes nothing returns nothing
    if ( Trig_ConsoleRepair_Func003Func001C() ) then
        call RemoveItem( GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01R') )
        call SetUnitVertexColorBJ( GetEnumUnit(), 100, 100, 100, 0 )
        call SetUnitLifePercentBJ( GetEnumUnit(), 100 )
        call EnableTrigger(LoadTriggerHandle(LS(),GetHandleId(GetEnumUnit()),StringHash("console_k")))
        call EnableTrigger(LoadTriggerHandle(LS(),GetHandleId(GetEnumUnit()),StringHash("console_m")))
        call UnitRemoveAbilityBJ( 'Avul', GetEnumUnit() )
        call UnitRemoveAbilityBJ( 'A06R', GetEnumUnit() )
    else
    endif
endfunction

function Trig_ConsoleRepair_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsInRangeOfLocAll(200.00, GetSpellTargetLoc()), function Trig_ConsoleRepair_Func003A )
endfunction

//===========================================================================
function InitTrig_ConsoleRepair takes nothing returns nothing
    set gg_trg_ConsoleRepair = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ConsoleRepair, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ConsoleRepair, Condition( function Trig_ConsoleRepair_Conditions ) )
    call TriggerAddAction( gg_trg_ConsoleRepair, function Trig_ConsoleRepair_Actions )
endfunction

