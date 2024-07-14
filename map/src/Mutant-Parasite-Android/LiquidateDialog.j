function Trig_LiquidateDialog_Func002C takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_Liquidate_AreYouSureButton[2] ) ) then
        return false
    endif
    return true
endfunction

function Trig_LiquidateDialog_Actions takes nothing returns nothing
    if ( Trig_LiquidateDialog_Func002C() ) then
        call KillUnit( udg_Playerhero[udg_Liquidate_ToLiquidate] )
    else
    endif
endfunction

//===========================================================================
function InitTrig_LiquidateDialog takes nothing returns nothing
    set gg_trg_LiquidateDialog = CreateTrigger(  )
    call TriggerRegisterDialogEventBJ( gg_trg_LiquidateDialog, udg_Liquidate_AreYouSure )
    call TriggerAddAction( gg_trg_LiquidateDialog, function Trig_LiquidateDialog_Actions )
endfunction

