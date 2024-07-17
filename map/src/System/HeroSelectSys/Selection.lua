if Debug then Debug.beginFile "System/HeroSelectSys/Selection" end
OnInit.map("Selection", function(require)
    function Trig_Selection_Actions()
        udg_TempInt = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
        udg_TempPoint = GetUnitLoc(udg_Playerhero[udg_TempInt])
        PanCameraToTimedLocForPlayer(ConvertedPlayer(udg_TempInt), udg_TempPoint, 0)
        SelectUnitForPlayerSingle(udg_Playerhero[udg_TempInt], ConvertedPlayer(udg_TempInt))
    end

    --===========================================================================
    gg_trg_Selection = CreateTrigger()
    TriggerAddAction(gg_trg_Selection, Trig_Selection_Actions)
end)
if Debug then Debug.endFile() end
