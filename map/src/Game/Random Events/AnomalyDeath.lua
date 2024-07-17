if Debug then Debug.beginFile "Game/RandomEvents/AnomalyDeath" end
OnInit.trig("AnomalyDeath", function(require)
    ---@return boolean
    function Trig_AnomalyDeath_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('n00K'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AnomalyDeath_Func001C()
        if (not (udg_AnomalyWarpalHasSpawned == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AnomalyDeath_Func003Func001C()
        if (not (IsUnitGroupDeadBJ(udg_AnomalyUnitGroup) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AnomalyDeath_Func003C()
        if (not (udg_TempInt == 12)) then
            return false
        end
        return true
    end

    function Trig_AnomalyDeath_Actions()
        if (Trig_AnomalyDeath_Func001C()) then
            return
        else
        end
        udg_TempInt = GetRandomInt(1, 12)
        if (Trig_AnomalyDeath_Func003C()) then
            udg_AnomalyWarpalHasSpawned = true
            udg_TempPoint = GetUnitLoc(GetTriggerUnit())
            CreateItemLoc(FourCC('I02X'), udg_TempPoint)
            RemoveLocation(udg_TempPoint)
        else
            if (Trig_AnomalyDeath_Func003Func001C()) then
                udg_AnomalyWarpalHasSpawned = true
                udg_TempPoint = GetUnitLoc(GetTriggerUnit())
                CreateItemLoc(FourCC('I02X'), udg_TempPoint)
                RemoveLocation(udg_TempPoint)
            else
            end
        end
    end

    --===========================================================================
    gg_trg_AnomalyDeath = CreateTrigger()
    DisableTrigger(gg_trg_AnomalyDeath)
    TriggerRegisterPlayerUnitEventSimple(gg_trg_AnomalyDeath, Player(PLAYER_NEUTRAL_PASSIVE), EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_AnomalyDeath, Condition(Trig_AnomalyDeath_Conditions))
    TriggerAddAction(gg_trg_AnomalyDeath, Trig_AnomalyDeath_Actions)
end)
if Debug then Debug.endFile() end
