if Debug then Debug.beginFile "Game/Stations/ST11/OverlordDockBug" end
OnInit.map("OverlordDockBug", function(require)
    ---@return boolean
    function Trig_Overlorddockbug_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A001'))) then
            return false
        end
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h04G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Overlorddockbug_Func006C()
        if (not (DistanceBetweenPoints(udg_Spaceship_Overlordcomparison, udg_Overlord_Spaceshipcomparison) <= 200.00)) then
            return false
        end
        return true
    end

    function Trig_Overlorddockbug_Actions()
        udg_Spaceship_Overlordcomparison = GetUnitLoc(GetTriggerUnit())
        udg_Overlord_Spaceshipcomparison = GetUnitLoc(GetEventTargetUnit())
        if (Trig_Overlorddockbug_Func006C()) then
            PauseUnitBJ(true, GetTriggerUnit())
            TriggerSleepAction(1.00)
            PauseUnitBJ(false, GetTriggerUnit())
        else
        end
    end

    --===========================================================================
    gg_trg_Overlorddockbug = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Overlorddockbug, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Overlorddockbug, Condition(Trig_Overlorddockbug_Conditions))
    TriggerAddAction(gg_trg_Overlorddockbug, Trig_Overlorddockbug_Actions)
end)
if Debug then Debug.endFile() end
