if Debug then Debug.beginFile "Game/Allignment/Common/LiquidateDialog2" end
OnInit.trig("LiquidateDialog2", function(require)
    require "Anonymity"
    function Trig_LiquidateDialog2_Actions()
        local targettedPlayer ---@type player
        if GetClickedButtonBJ() == udg_Liquidate_AreYouSureButton2[2] then
            targettedPlayer = Anonymity.shuffledPlayers.orderedKeys[udg_Liquidate_ToLiquidate2 - 1]
            KillUnit(udg_Playerhero[GetConvertedPlayerId(targettedPlayer)])
        else
        end
    end

    --===========================================================================
    gg_trg_LiquidateDialog2 = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_LiquidateDialog2, udg_Liquidate_AreYouSure2)
    TriggerAddAction(gg_trg_LiquidateDialog2, Trig_LiquidateDialog2_Actions)
end)
if Debug then Debug.endFile() end
