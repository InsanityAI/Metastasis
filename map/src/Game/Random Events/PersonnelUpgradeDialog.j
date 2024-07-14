function Trig_PersonnelUpgradeDialog_Func002Func001C takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_PersonnelUpgradeDialog_Button[GetForLoopIndexA()] ) ) then
        return false
    endif
    return true
endfunction

function Trig_PersonnelUpgradeDialog_Actions takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 5
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_PersonnelUpgradeDialog_Func002Func001C() ) then
            call SetPlayerTechResearchedSwap( udg_PersonnelUpgrade_Research[GetForLoopIndexA()], 1, GetTriggerPlayer() )
            return
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call DialogDisplayBJ( true, udg_PersonnelUpgradeDialog, GetTriggerPlayer() )
endfunction

//===========================================================================
function InitTrig_PersonnelUpgradeDialog takes nothing returns nothing
    set gg_trg_PersonnelUpgradeDialog = CreateTrigger(  )
    call DisableTrigger( gg_trg_PersonnelUpgradeDialog )
    call TriggerRegisterDialogEventBJ( gg_trg_PersonnelUpgradeDialog, udg_PersonnelUpgradeDialog )
    call TriggerAddAction( gg_trg_PersonnelUpgradeDialog, function Trig_PersonnelUpgradeDialog_Actions )
endfunction

