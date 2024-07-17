if Debug then Debug.beginFile "Game/PureBugfixes/AlienDeathShipControl" end
OnInit.map("AlienDeathShipControl", function(require)
    ---@return boolean
    function Trig_AlienDeathShipControl_Conditions()
        if (not (GetOwningPlayer(GetTriggerUnit()) == udg_Parasite)) then
            return false
        end
        if (not (GetOwningPlayer(GetTriggerUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienDeathShipControl_Func004Func001C()
        if (not (GetOwningPlayer(GetEnumUnit()) == udg_Parasite)) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        if not (IsUnitExplorer(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_AlienDeathShipControl_Func004A()
        if (Trig_AlienDeathShipControl_Func004Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false)
        else
        end
    end

    function Trig_AlienDeathShipControl_Actions()
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Space), Trig_AlienDeathShipControl_Func004A)
    end

    --===========================================================================
    gg_trg_AlienDeathShipControl = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AlienDeathShipControl, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_AlienDeathShipControl, Condition(Trig_AlienDeathShipControl_Conditions))
    TriggerAddAction(gg_trg_AlienDeathShipControl, Trig_AlienDeathShipControl_Actions)
end)
if Debug then Debug.endFile() end
