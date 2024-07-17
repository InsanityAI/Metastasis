if Debug then Debug.beginFile "Commands/Test/AlienEvoPoints" end
OnInit.map("AlienEvoPoints", function(require)
    ---@return boolean
    function Trig_AlienEvoPoints_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_AlienEvoPoints_Actions()
        udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 9999.00)
        udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 9999.00)
        udg_UpgradePointsAndroid = (udg_UpgradePointsAndroid + 9999.00)
    end

    --===========================================================================
    local i               = 0 ---@type integer
    gg_trg_AlienEvoPoints = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_AlienEvoPoints, Player(i), "-EP", true)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_AlienEvoPoints, Condition(Trig_AlienEvoPoints_Conditions))
    TriggerAddAction(gg_trg_AlienEvoPoints, Trig_AlienEvoPoints_Actions)
end)
if Debug then Debug.endFile() end
