function Trig_LiquidateDialog2_Func002C takes nothing returns boolean
    if ( not ( GetClickedButtonBJ() == udg_Liquidate_AreYouSureButton2[2] ) ) then
        return false
    endif
    return true
endfunction

function Trig_LiquidateDialog2_Actions takes nothing returns nothing
    if ( Trig_LiquidateDialog2_Func002C() ) then
        call KillUnit( udg_Playerhero[udg_Liquidate_ToLiquidate2] )
    else
    endif
endfunction

//===========================================================================
function InitTrig_LiquidateDialog2 takes nothing returns nothing
    set gg_trg_LiquidateDialog2 = CreateTrigger(  )
    call TriggerRegisterDialogEventBJ( gg_trg_LiquidateDialog2, udg_Liquidate_AreYouSure2 )
    call TriggerAddAction( gg_trg_LiquidateDialog2, function Trig_LiquidateDialog2_Actions )
endfunction

