if Debug then Debug.beginFile "Game/Abilities/Suits/RDGLimitHard" end
OnInit.map("RDGLimitHard", function(require)
    ---@return boolean
    function Trig_RDGLimitHard_Conditions()
        if (not (GetUnitTypeId(GetEnteringUnit()) == FourCC('e018'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RDGLimitHard_Func003002002001()
        return (IsUnitAliveBJ(GetFilterUnit()) == true)
    end

    ---@return boolean
    function Trig_RDGLimitHard_Func003002002002()
        return (GetUnitTypeId(GetFilterUnit()) == FourCC('e018'))
    end

    ---@return boolean
    function Trig_RDGLimitHard_Func003002002()
        return GetBooleanAnd(Trig_RDGLimitHard_Func003002002001(), Trig_RDGLimitHard_Func003002002002())
    end

    ---@return boolean
    function Trig_RDGLimitHard_Func004C()
        if (not (CountUnitsInGroup(udg_TempUnitGroup) > 4)) then
            return false
        end
        return true
    end

    function Trig_RDGLimitHard_Actions()
        udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetEnteringUnit()),
            Condition(Trig_RDGLimitHard_Func003002002))
        if (Trig_RDGLimitHard_Func004C()) then
            RemoveUnit(GetEnteringUnit())
        else
        end
        DestroyGroup(udg_TempUnitGroup)
        DestroyGroup(udg_TempUnitGroup2)
    end

    --===========================================================================
    gg_trg_RDGLimitHard = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_RDGLimitHard, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_RDGLimitHard, Condition(Trig_RDGLimitHard_Conditions))
    TriggerAddAction(gg_trg_RDGLimitHard, Trig_RDGLimitHard_Actions)
end)
if Debug then Debug.endFile() end
