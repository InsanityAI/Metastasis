function Trig_RepickAlien_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepickAlien_Actions takes nothing returns nothing
    call DialogClearBJ( udg_RepickAlienDialog )
    call DialogSetMessageBJ( udg_RepickAlienDialog, "TRIGSTR_5314" )
    call DialogAddButtonBJ( udg_RepickAlienDialog, "TRIGSTR_5312" )
    set udg_RepickAlienDialogButton[0] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_RepickAlienDialog, "TRIGSTR_5315" )
    set udg_RepickAlienDialogButton[1] = GetLastCreatedButtonBJ()
    call DialogDisplayBJ( true, udg_RepickAlienDialog, udg_Parasite )
endfunction

//===========================================================================
function InitTrig_RepickAlien takes nothing returns nothing
    set gg_trg_RepickAlien = CreateTrigger(  )
    call TriggerAddCondition( gg_trg_RepickAlien, Condition( function Trig_RepickAlien_Conditions ) )
    call TriggerAddAction( gg_trg_RepickAlien, function Trig_RepickAlien_Actions )
endfunction

