if Debug then Debug.beginFile "Game/Abilities/Suits/CryoShock" end
OnInit.trig("CryoShock", function(require)
    ---@return boolean
    function Trig_CryoShock_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A00I'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CryoShock_Func007Func001C()
        if (not (GetEnumUnit() ~= udg_TempUnit3)) then
            return false
        end
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('H03I'))) then
            return false
        end
        return true
    end

    function Trig_CryoShock_Func007A()
        if (Trig_CryoShock_Func007Func001C()) then
            udg_TempPoint = GetUnitLoc(GetEnumUnit())
            CreateNUnitsAtLoc(1, FourCC('e01L'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
            IssuePointOrderLocBJ(GetLastCreatedUnit(), "silence", udg_TempPoint)
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    function Trig_CryoShock_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(450.00, udg_TempPoint)
        udg_TempUnit3 = GetSpellAbilityUnit()
        RemoveLocation(udg_TempPoint)
        ForGroupBJ(udg_TempUnitGroup, Trig_CryoShock_Func007A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_CryoShock = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CryoShock, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_CryoShock, Condition(Trig_CryoShock_Conditions))
    TriggerAddAction(gg_trg_CryoShock, Trig_CryoShock_Actions)
end)
if Debug then Debug.endFile() end
