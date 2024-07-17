if Debug then Debug.beginFile "Game/PureBugfixes/HarbringerDeathShipControl" end
OnInit.trig("HarbringerDeathShipControl", function(require)
    ---@return boolean
    function Trig_HarbringerDeathShipControl_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h01T'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_HarbringerDeathShipControl_Func003Func001Func004C()
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == true)) then
            return true
        end
        if ((GetOwningPlayer(GetEnumUnit()) == udg_Mutant)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_HarbringerDeathShipControl_Func003Func001C()
        if not (IsUnitExplorer(GetEnumUnit())) then
            return false
        end
        if (not Trig_HarbringerDeathShipControl_Func003Func001Func004C()) then
            return false
        end
        return true
    end

    function Trig_HarbringerDeathShipControl_Func003A()
        if (Trig_HarbringerDeathShipControl_Func003Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false)
        else
        end
    end

    function Trig_HarbringerDeathShipControl_Actions()
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Space), Trig_HarbringerDeathShipControl_Func003A)
    end

    --===========================================================================
    gg_trg_HarbringerDeathShipControl = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HarbringerDeathShipControl, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_HarbringerDeathShipControl, Condition(Trig_HarbringerDeathShipControl_Conditions))
    TriggerAddAction(gg_trg_HarbringerDeathShipControl, Trig_HarbringerDeathShipControl_Actions)
end)
if Debug then Debug.endFile() end
