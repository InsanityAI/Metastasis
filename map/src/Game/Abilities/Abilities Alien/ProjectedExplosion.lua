if Debug then Debug.beginFile "Game/Abilities/Alien/ProjectedExplosion" end
OnInit.map("ProjectedExplosion", function(require)
    ---@return boolean
    function Trig_ProjectedExplosion_Func001C()
        if ((GetSpellAbilityId() == FourCC('A03V'))) then
            return true
        end
        if ((GetSpellAbilityId() == FourCC('A03X'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ProjectedExplosion_Conditions()
        if (not Trig_ProjectedExplosion_Func001C()) then
            return false
        end
        return true
    end

    function Trig_ProjectedExplosion_Actions()
        local a       = GetSpellTargetLoc() ---@type location
        udg_TempPoint = a
        CreateNUnitsAtLoc(1, FourCC('e00R'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        udg_CountUpBarColor = "|cffFF0000"
        BasicAI_IssueDangerArea(a, 800.0, 3.1)
        CountUpBar(udg_TempUnit, 60, 0.05, "FusionBombExplosion2")
        RemoveLocation(a)
    end

    --===========================================================================
    gg_trg_ProjectedExplosion = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ProjectedExplosion, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ProjectedExplosion, Condition(Trig_ProjectedExplosion_Conditions))
    TriggerAddAction(gg_trg_ProjectedExplosion, Trig_ProjectedExplosion_Actions)
end)
if Debug then Debug.endFile() end
