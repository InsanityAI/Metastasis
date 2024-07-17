if Debug then Debug.beginFile "Game/Abilities/Mutant/Fleshies" end
OnInit.map("Fleshies", function(require)
    ---@return boolean
    function Trig_Fleshies_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h01F'))) then
            return false
        end
        return true
    end

    function FleshyFilter()
        if IsPlayerMutant(GetOwningPlayer(GetEnumUnit())) == true or GetOwningPlayer(GetEnumUnit()) == Player(PLAYER_NEUTRAL_PASSIVE) or GetUnitPointValue(GetEnumUnit()) == 37 or IsUnitDeadBJ(GetEnumUnit()) or GetUnitAbilityLevel(GetEnumUnit(), FourCC('Avul')) == 1 or GetUnitTypeId(GetEnumUnit()) == FourCC('h01E') then
            GroupRemoveUnit(udg_TempUnitGroup, GetEnumUnit())
        end
    end

    function Trig_Fleshies_Actions()
        local a = GetSummonedUnit() ---@type unit
        local b ---@type location
        local g ---@type group
        SetUnitOwner(a, Player(PLAYER_NEUTRAL_PASSIVE), false)
        while not (IsUnitDeadBJ(a)) do
            b = GetUnitLoc(a)
            g = GetUnitsInRangeOfLocAll(650.0, b)
            udg_TempUnitGroup = g
            ForGroup(g, FleshyFilter)
            if CountUnitsInGroup(g) == 0 then
                UnitAddAbility(a, FourCC('Atwa'))
            else
                UnitRemoveAbility(a, FourCC('Atwa'))
                IssueTargetOrder(a, "attack", FirstOfGroup(g))
            end
            RemoveLocation(b)
            DestroyGroup(g)
            PolledWait(2.0)
        end
        a = nil
    end

    --===========================================================================
    gg_trg_Fleshies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Fleshies, EVENT_PLAYER_UNIT_SUMMON)
    TriggerAddCondition(gg_trg_Fleshies, Condition(Trig_Fleshies_Conditions))
    TriggerAddAction(gg_trg_Fleshies, Trig_Fleshies_Actions)
end)
if Debug then Debug.endFile() end
