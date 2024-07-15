function Trig_LiquidateDialog2_Actions takes nothing returns nothing
    local player targettedPlayer
    if GetClickedButtonBJ() == udg_Liquidate_AreYouSureButton2[2] then
        set targettedPlayer = Anonymity_ShuffledPlayersArray[udg_Liquidate_ToLiquidate2 - 1]
        call KillUnit( udg_Playerhero[GetConvertedPlayerId(targettedPlayer)] )
    else
    endif
    
endfunction

//===========================================================================
function InitTrig_LiquidateDialog2 takes nothing returns nothing
    set gg_trg_LiquidateDialog2 = CreateTrigger(  )
    call TriggerRegisterDialogEventBJ( gg_trg_LiquidateDialog2, udg_Liquidate_AreYouSure2 )
    call TriggerAddAction( gg_trg_LiquidateDialog2, function Trig_LiquidateDialog2_Actions )
endfunction

