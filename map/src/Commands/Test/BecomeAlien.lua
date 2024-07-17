if Debug then Debug.beginFile "Commands/Test/BecomeAlien" end
OnInit.trig("BecomeAlien", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_BecomeAlien_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_BecomeAlien_Actions()
        udg_Parasite = GetTriggerPlayer()
        StateTable.SetPlayerRole(udg_Parasite, Role.Alien)
        SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), GetTriggerPlayer(), bj_ALLIANCE_ALLIED_ADVUNITS)
        --if playerhero not in suit, give alien form ability
    end

    --===========================================================================
    local i            = 0 ---@type integer

    gg_trg_BecomeAlien = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_BecomeAlien, Player(i), "-alien", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_BecomeAlien, Condition(Trig_BecomeAlien_Conditions))
    TriggerAddAction(gg_trg_BecomeAlien, Trig_BecomeAlien_Actions)
end)
if Debug then Debug.endFile() end
