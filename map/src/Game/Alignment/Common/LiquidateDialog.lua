if Debug then Debug.beginFile "Game/Allignment/Common/LiquidateDialog" end
OnInit.trig("LiquidateDialog", function(require)
    function Trig_LiquidateDialog_Actions()
        local targettedPlayer ---@type player
        if GetClickedButtonBJ() == udg_Liquidate_AreYouSureButton[2] then
            targettedPlayer = Anonymity.shuffledPlayers.orderedKeys[udg_Liquidate_ToLiquidate - 1]
            KillUnit(udg_Playerhero[GetConvertedPlayerId(targettedPlayer)])
        end
    end

    --===========================================================================
    gg_trg_LiquidateDialog = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_LiquidateDialog, udg_Liquidate_AreYouSure)
    TriggerAddAction(gg_trg_LiquidateDialog, Trig_LiquidateDialog_Actions)
end)
if Debug then Debug.endFile() end
