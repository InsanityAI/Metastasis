if Debug then Debug.beginFile "Game/Misc/AntiShareControl" end
OnInit.map("AntiShareControl", function(require)
    ---@return boolean
    function Trig_AntiShareControl_Func002Func001Func001Func003C()
        if ((GetPlayerAlliance(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), ALLIANCE_SHARED_CONTROL) == true)) then
            return true
        end
        if ((GetPlayerAlliance(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL) == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AntiShareControl_Func002Func001Func001Func005C()
        if (not (ConvertedPlayer(GetForLoopIndexA()) == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AntiShareControl_Func002Func001Func001C()
        if (not (ConvertedPlayer(GetForLoopIndexA()) ~= GetEnumPlayer())) then
            return false
        end
        if (not (GetEnumPlayer() ~= Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        if (not Trig_AntiShareControl_Func002Func001Func001Func003C()) then
            return false
        end
        return true
    end

    function Trig_AntiShareControl_Func002A()
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 12
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_AntiShareControl_Func002Func001Func001C()) then
                SetPlayerAllianceStateBJ(ConvertedPlayer(GetForLoopIndexA()), GetEnumPlayer(), bj_ALLIANCE_ALLIED)
                if (Trig_AntiShareControl_Func002Func001Func001Func005C()) then
                    SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), GetEnumPlayer(), bj_ALLIANCE_ALLIED)
                else
                end
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    function Trig_AntiShareControl_Actions()
        ForForce(GetPlayersAll(), Trig_AntiShareControl_Func002A)
    end

    --===========================================================================
    gg_trg_AntiShareControl = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_AntiShareControl, 2)
    TriggerAddAction(gg_trg_AntiShareControl, Trig_AntiShareControl_Actions)
end)
if Debug then Debug.endFile() end
