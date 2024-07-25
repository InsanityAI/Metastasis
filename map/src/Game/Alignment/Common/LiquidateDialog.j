function Trig_LiquidateDialog_Actions takes nothing returns nothing 
    local player targettedPlayer 
    if GetClickedButtonBJ() == udg_Liquidate_AreYouSureButton[2] then 
        set targettedPlayer = Anonymity_ShuffledPlayersArray[udg_Liquidate_ToLiquidate - 1] 
        call KillUnit(udg_Playerhero[GetConvertedPlayerId(targettedPlayer)]) 
    endif 
endfunction 

//===========================================================================  
function InitTrig_LiquidateDialog takes nothing returns nothing 
    set gg_trg_LiquidateDialog = CreateTrigger() 
    call TriggerRegisterDialogEventBJ(gg_trg_LiquidateDialog, udg_Liquidate_AreYouSure) 
    call TriggerAddAction(gg_trg_LiquidateDialog, function Trig_LiquidateDialog_Actions) 
endfunction 
