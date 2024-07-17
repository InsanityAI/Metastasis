if Debug then Debug.beginFile "Game/Abilities/Suits/ForceSuitAttackGround" end
OnInit.trig("ForceSuitAttackGround", function(require)
    ---@return boolean
    function Trig_ForceSuitAttackGround_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08A'))) then
            return false
        end
        return true
    end

    function Trig_ForceSuitAttackGround_Actions()
        local a = GetSpellTargetLoc() ---@type location
        local b = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        local c = PolarProjectionBJ(b, 100.0, AngleBetweenPoints(b, a)) ---@type location
        CreateNUnitsAtLoc(1, FourCC('e030'), GetOwningPlayer(GetSpellAbilityUnit()), c, bj_UNIT_FACING)
        IssueTargetOrderBJ(GetSpellAbilityUnit(), "attack", GetLastCreatedUnit())
        RemoveLocation(a)
        RemoveLocation(b)
        RemoveLocation(c)
    end

    --===========================================================================
    gg_trg_ForceSuitAttackGround = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ForceSuitAttackGround, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ForceSuitAttackGround, Condition(Trig_ForceSuitAttackGround_Conditions))
    TriggerAddAction(gg_trg_ForceSuitAttackGround, Trig_ForceSuitAttackGround_Actions)
end)
if Debug then Debug.endFile() end
