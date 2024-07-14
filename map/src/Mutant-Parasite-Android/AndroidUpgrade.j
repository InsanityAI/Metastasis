function Trig_AndroidUpgrade_Conditions takes nothing returns boolean
    if ( not ( IsUnitIdType(GetUnitTypeId(GetTriggerUnit()), UNIT_TYPE_MECHANICAL) == false ) ) then
        return false
    endif
    if ( not ( udg_Android_DialogOn == false ) ) then
        return false
    endif
    if ( not ( udg_UpgradePointsAndroid >= 2000.00 ) ) then
        return false
    endif
    if ( not ( GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidUpgrade_Func017Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == 'I013' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidUpgrade_Func020Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(UnitItemInSlotBJ(GetTriggerUnit(), GetForLoopIndexA())) == 'I018' ) ) then
        return false
    endif
    if ( not ( udg_HiddenAndroid_TKDamageDone <= 0.50 ) ) then
        return false
    endif
    if ( not ( udg_AndroidRemoteID == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidUpgrade_Actions takes nothing returns nothing
    set udg_Android_DialogOn = true
    call DialogClearBJ( udg_AndroidUpgradeDialog )
    call DialogAddButtonBJ( udg_AndroidUpgradeDialog, "TRIGSTR_3073" )
    set udg_AndroidUpgradeDialogButtons[1] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_AndroidUpgradeDialog, "TRIGSTR_3074" )
    set udg_AndroidUpgradeDialogButtons[2] = GetLastCreatedButtonBJ()
    set udg_Android_UpgradingTo[2] = 'h02F'
    call DialogAddButtonBJ( udg_AndroidUpgradeDialog, "TRIGSTR_3235" )
    set udg_AndroidUpgradeDialogButtons[3] = GetLastCreatedButtonBJ()
    set udg_Android_UpgradingTo[3] = 'h047'
    // Penguin Check Begin
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_AndroidUpgrade_Func017Func001C() ) then
            call DialogAddButtonBJ( udg_AndroidUpgradeDialog, "TRIGSTR_3976" )
            set udg_AndroidUpgradeDialogButtons[4] = GetLastCreatedButtonBJ()
            set udg_Android_UpgradingTo[4] = 'h02U'
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    // Penguin Check End
    // Phoenix Check Begin
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_AndroidUpgrade_Func020Func001C() ) then
            call DialogAddButtonBJ( udg_AndroidUpgradeDialog, "TRIGSTR_5288" )
            set udg_AndroidUpgradeDialogButtons[5] = GetLastCreatedButtonBJ()
            set udg_Android_UpgradingTo[5] = 'h052'
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    // Phoenix Check End
    call DialogDisplayBJ( true, udg_AndroidUpgradeDialog, udg_HiddenAndroid )
    call IssuePointOrderLocBJ( GetTriggerUnit(), "move", GetRectCenter(gg_rct_AndroidUpgrade) )
endfunction

//===========================================================================
function InitTrig_AndroidUpgrade takes nothing returns nothing
    set gg_trg_AndroidUpgrade = CreateTrigger(  )
    call DisableTrigger( gg_trg_AndroidUpgrade )
    call TriggerRegisterEnterRectSimple( gg_trg_AndroidUpgrade, gg_rct_AndroidUpgrade )
    call TriggerAddCondition( gg_trg_AndroidUpgrade, Condition( function Trig_AndroidUpgrade_Conditions ) )
    call TriggerAddAction( gg_trg_AndroidUpgrade, function Trig_AndroidUpgrade_Actions )
endfunction

