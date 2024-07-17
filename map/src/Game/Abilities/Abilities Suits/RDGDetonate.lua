if Debug then Debug.beginFile "Game/Abilities/Suits/RDGDetonate" end
OnInit.trig("RDGDetonate", function(require)
    ---@return boolean
    function Trig_RDGDetonate_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A057'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RDGDetonate_Func003002002001()
        return (IsUnitAliveBJ(GetFilterUnit()) == true)
    end

    ---@return boolean
    function Trig_RDGDetonate_Func003002002002()
        return (GetUnitTypeId(GetFilterUnit()) == FourCC('e018'))
    end

    ---@return boolean
    function Trig_RDGDetonate_Func003002002()
        return GetBooleanAnd(Trig_RDGDetonate_Func003002002001(), Trig_RDGDetonate_Func003002002002())
    end

    function Trig_RDGDetonate_Func004A()
        KillUnit(GetEnumUnit())
    end

    function Trig_RDGDetonate_Actions()
        udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetSpellAbilityUnit()),
            Condition(Trig_RDGDetonate_Func003002002))
        ForGroupBJ(udg_TempUnitGroup, Trig_RDGDetonate_Func004A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_RDGDetonate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RDGDetonate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RDGDetonate, Condition(Trig_RDGDetonate_Conditions))
    TriggerAddAction(gg_trg_RDGDetonate, Trig_RDGDetonate_Actions)
end)
if Debug then Debug.endFile() end
