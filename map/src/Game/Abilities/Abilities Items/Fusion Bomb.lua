if Debug then Debug.beginFile "Game/Abilities/Items/FusionBomb" end
OnInit.trig("FusionBomb", function(require)
    ---@return boolean
    function Trig_Fusion_Bomb_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A019'))) then
            return false
        end
        return true
    end

    function Trig_Fusion_Bomb_Actions()
        local a       = GetSpellTargetLoc() ---@type location
        udg_TempPoint = a
        CreateNUnitsAtLoc(1, FourCC('h013'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING)
        SetUnitTimeScalePercent(GetLastCreatedUnit(), 200.00)
        udg_TempUnit = GetLastCreatedUnit()
        udg_CountUpBarColor = "|cffFF0000"
        BasicAI_IssueDangerArea(a, 800.0, 3.1)
        CountUpBar(udg_TempUnit, 60, 0.05, "FusionBombExplosion")
        RemoveLocation(a)
    end

    --===========================================================================
    gg_trg_Fusion_Bomb = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Fusion_Bomb, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Fusion_Bomb, Condition(Trig_Fusion_Bomb_Conditions))
    TriggerAddAction(gg_trg_Fusion_Bomb, Trig_Fusion_Bomb_Actions)
end)
if Debug then Debug.endFile() end
