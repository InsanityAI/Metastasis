if Debug then Debug.beginFile "Game/TeleportAndAI/WarpArtificialIntelligence" end
OnInit.map("WarpArtificialIntelligence", function(require)
    function Trig_Warp_Artificial_Intelligence_Func005A()
        IssueTargetOrderBJ(GetEnumUnit(), "attack", GroupPickRandomUnit(udg_TempUnitGroup))
    end

    function Trig_Warp_Artificial_Intelligence_Actions()
        udg_TempUnitGroup2 = GetUnitsInRectOfPlayer(gg_rct_Warp, Player(PLAYER_NEUTRAL_AGGRESSIVE))
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Warp)
        GroupRemoveGroup(udg_TempUnitGroup2, udg_TempUnitGroup)
        ForGroupBJ(udg_TempUnitGroup2, Trig_Warp_Artificial_Intelligence_Func005A)
        DestroyGroup(udg_TempUnitGroup2)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_Warp_Artificial_Intelligence = CreateTrigger()
    DisableTrigger(gg_trg_Warp_Artificial_Intelligence)
    TriggerRegisterTimerEventPeriodic(gg_trg_Warp_Artificial_Intelligence, 1.20)
    TriggerAddAction(gg_trg_Warp_Artificial_Intelligence, Trig_Warp_Artificial_Intelligence_Actions)
end)
if Debug then Debug.endFile() end
