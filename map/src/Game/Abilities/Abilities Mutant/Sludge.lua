if Debug then Debug.beginFile "Game/Abilities/Mutant/Sludge" end
OnInit.trig("Sludge", function(require)
    ---@return boolean
    function Trig_Sludge_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A012'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Sludge_Func006C()
        if (not (IsPlayerEnemy(GetOwningPlayer(GetSpellAbilityUnit()), Player(PLAYER_NEUTRAL_AGGRESSIVE)) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Sludge_Func009C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_Sludge_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        udg_TempBool = false
        if (Trig_Sludge_Func006C()) then
            udg_TempBool = true
            SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), GetOwningPlayer(GetSpellAbilityUnit()),
                bj_ALLIANCE_ALLIED)
        else
        end
        CreateNUnitsAtLoc(1, FourCC('e000'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        IssuePointOrderLocBJ(GetLastCreatedUnit(), "carrionswarm", udg_TempPoint2)
        if (Trig_Sludge_Func009C()) then
            SetPlayerAllianceStateBJ(Player(PLAYER_NEUTRAL_AGGRESSIVE), GetOwningPlayer(GetSpellAbilityUnit()),
                bj_ALLIANCE_UNALLIED)
        else
        end
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_Sludge = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Sludge, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Sludge, Condition(Trig_Sludge_Conditions))
    TriggerAddAction(gg_trg_Sludge, Trig_Sludge_Actions)
end)
if Debug then Debug.endFile() end
