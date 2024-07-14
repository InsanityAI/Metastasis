function Trig_RepickMutant_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickMutant_Actions takes nothing returns nothing
    call DialogClearBJ( udg_RepickMutantDialog )
    call DialogSetMessageBJ( udg_RepickMutantDialog, "TRIGSTR_5319" )
    call DialogAddButtonBJ( udg_RepickMutantDialog, "TRIGSTR_5320" )
    set udg_RepickMutantDialogButton[0] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_RepickMutantDialog, "TRIGSTR_5321" )
    set udg_RepickMutantDialogButton[1] = GetLastCreatedButtonBJ()
    call DialogDisplayBJ( true, udg_RepickMutantDialog, udg_Mutant )
endfunction

//===========================================================================
function InitTrig_RepickMutant takes nothing returns nothing
    set gg_trg_RepickMutant = CreateTrigger(  )
    call TriggerAddCondition( gg_trg_RepickMutant, Condition( function Trig_RepickMutant_Conditions ) )
    call TriggerAddAction( gg_trg_RepickMutant, function Trig_RepickMutant_Actions )
endfunction

