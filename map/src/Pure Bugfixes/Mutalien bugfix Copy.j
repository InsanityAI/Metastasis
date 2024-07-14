function Trig_Mutalien_bugfix_Copy_Func002C takes nothing returns boolean
    if ( ( GetOwningPlayer(GetTriggerUnit()) == udg_Mutant ) ) then
        return true
    endif
    if ( ( GetOwningPlayer(GetTriggerUnit()) == udg_Parasite ) ) then
        return true
    endif
    return false
endfunction

function Trig_Mutalien_bugfix_Copy_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h02P' ) ) then
        return false
    endif
    if ( not Trig_Mutalien_bugfix_Copy_Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_Mutalien_bugfix_Copy_Func004C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == udg_Mutant ) ) then
        return false
    endif
    return true
endfunction

function Trig_Mutalien_bugfix_Copy_Actions takes nothing returns nothing
    if ( Trig_Mutalien_bugfix_Copy_Func004C() ) then
        call RemoveUnit( udg_Mutant_EvoSelector )
    else
        call RemoveUnit( udg_Parasite_EvoSelector )
    endif
endfunction

//===========================================================================
function InitTrig_Mutalien_bugfix_Copy takes nothing returns nothing
    set gg_trg_Mutalien_bugfix_Copy = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Mutalien_bugfix_Copy, gg_rct_SpaceSound )
    call TriggerAddCondition( gg_trg_Mutalien_bugfix_Copy, Condition( function Trig_Mutalien_bugfix_Copy_Conditions ) )
    call TriggerAddAction( gg_trg_Mutalien_bugfix_Copy, function Trig_Mutalien_bugfix_Copy_Actions )
endfunction

