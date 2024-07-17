if Debug then Debug.beginFile "Game/Allignment/Mutant/CrabMutant" end
OnInit.trig("CrabMutant", function(require)
    ---@return boolean
    function Trig_CrabMutant_Conditions()
        if (not (GetUnitTypeId(GetAttacker()) == FourCC('h01C'))) then
            return false
        end
        return true
    end

    function Trig_CrabMutant_Actions()
        local q = GetUnitLoc(GetAttacker()) ---@type location
        local a = PolarProjectionBJ(q, 90.0, GetUnitFacing(GetAttacker())) ---@type location
        local b = GetAttackedUnitBJ() ---@type unit
        CreateNUnitsAtLoc(1, FourCC('n009'), Player(PLAYER_NEUTRAL_PASSIVE), a, bj_UNIT_FACING)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "attack", b)
        bj_lastCreatedEffect = AddSpecialEffectLoc("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", a)
        SFXThreadClean()
        PolledWait(0.25)
        CreateNUnitsAtLoc(1, FourCC('n009'), Player(PLAYER_NEUTRAL_PASSIVE), a, bj_UNIT_FACING)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "attack", b)
        bj_lastCreatedEffect = AddSpecialEffectLoc("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", a)
        SFXThreadClean()
        if GetUnitAbilityLevel(GetAttacker(), FourCC('A07H')) == 1 then
            PolledWait(0.25)
            CreateNUnitsAtLoc(1, FourCC('n009'), Player(PLAYER_NEUTRAL_PASSIVE), a, bj_UNIT_FACING)
            IssueTargetOrderBJ(GetLastCreatedUnit(), "attack", b)
            bj_lastCreatedEffect = AddSpecialEffectLoc("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", a)
            SFXThreadClean()
        end
        RemoveLocation(a)
        RemoveLocation(q)
    end

    --===========================================================================
    gg_trg_CrabMutant = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CrabMutant, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_CrabMutant, Condition(Trig_CrabMutant_Conditions))
    TriggerAddAction(gg_trg_CrabMutant, Trig_CrabMutant_Actions)
    DisableTrigger(gg_trg_CrabMutant)
end)
if Debug then Debug.endFile() end
