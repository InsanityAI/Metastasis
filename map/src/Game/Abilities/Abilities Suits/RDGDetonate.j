function Trig_RDGDetonate_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A057' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RDGDetonate_Func003002002001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_RDGDetonate_Func003002002002 takes nothing returns boolean
    return ( GetUnitTypeId(GetFilterUnit()) == 'e018' )
endfunction

function Trig_RDGDetonate_Func003002002 takes nothing returns boolean
    return GetBooleanAnd( Trig_RDGDetonate_Func003002002001(), Trig_RDGDetonate_Func003002002002() )
endfunction

function Trig_RDGDetonate_Func004A takes nothing returns nothing
    call KillUnit( GetEnumUnit() )
endfunction

function Trig_RDGDetonate_Actions takes nothing returns nothing
    set udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetSpellAbilityUnit()), Condition(function Trig_RDGDetonate_Func003002002))
    call ForGroupBJ( udg_TempUnitGroup, function Trig_RDGDetonate_Func004A )
        call DestroyGroup( udg_TempUnitGroup )
endfunction

//===========================================================================
function InitTrig_RDGDetonate takes nothing returns nothing
    set gg_trg_RDGDetonate = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RDGDetonate, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_RDGDetonate, Condition( function Trig_RDGDetonate_Conditions ) )
    call TriggerAddAction( gg_trg_RDGDetonate, function Trig_RDGDetonate_Actions )
endfunction

