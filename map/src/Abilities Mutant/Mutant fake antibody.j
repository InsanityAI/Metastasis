function Trig_Mutant_fake_antibody_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mutant_fake_antibody_Func003C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(GetTriggerUnit(), 'B009') == true ) ) then
        return false
    endif
    if ( not ( udg_Infection3_initiated == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mutant_fake_antibody_Actions takes nothing returns nothing
    if ( Trig_Mutant_fake_antibody_Func003C() ) then
        call TriggerSleepAction( 3.00 )
        call UnitRemoveBuffBJ( 'B009', GetTriggerUnit() )
        call TriggerSleepAction( 3.00 )
        set udg_TempLoc3 = GetUnitLoc(GetTriggerUnit())
        call CreateNUnitsAtLoc( 1, 'e03G', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempLoc3, bj_CAMERA_DEFAULT_ROLL )
        call IssueTargetOrderBJ( GetLastCreatedUnit(), "parasite", GetTriggerUnit() )
        call RemoveLocation(udg_TempLoc3)
    else
    endif
endfunction

//===========================================================================
function InitTrig_Mutant_fake_antibody takes nothing returns nothing
    set gg_trg_Mutant_fake_antibody = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mutant_fake_antibody, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_Mutant_fake_antibody, Condition( function Trig_Mutant_fake_antibody_Conditions ) )
    call TriggerAddAction( gg_trg_Mutant_fake_antibody, function Trig_Mutant_fake_antibody_Actions )
endfunction

