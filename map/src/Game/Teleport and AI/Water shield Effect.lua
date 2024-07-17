if Debug then Debug.beginFile "Game/TeleportAndAI/WaterShieldEffect" end
OnInit.trig("WaterShieldEffect", function(require)
    ---@return boolean
    function Trig_Water_shield_Effect_Func003Func007Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('n00I'))) then
            return false
        end
        return true
    end

    function Trig_Water_shield_Effect_Func003Func007A()
        if (Trig_Water_shield_Effect_Func003Func007Func001C()) then
            UnitDamageTargetBJ(udg_Alodimensional_Being, GetEnumUnit(), 5.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
        else
        end
    end

    ---@return boolean
    function Trig_Water_shield_Effect_Func003C()
        if (not (IsUnitDeadBJ(udg_Alodimensional_Being) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Water_shield_Effect_Func004C()
        if (not (GetUnitStateSwap(UNIT_STATE_MANA, udg_Alodimensional_Being) <= 5.00)) then
            return false
        end
        return true
    end

    function Trig_Water_shield_Effect_Actions()
        udg_TempLoc3 = GetUnitLoc(udg_Alodimensional_Being)
        if (Trig_Water_shield_Effect_Func003C()) then
            AddSpecialEffectLocBJ(PolarProjectionBJ(udg_TempLoc3, 100.00, udg_Water_Shield_Number),
                "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl")
            DestroyEffectBJ(GetLastCreatedEffectBJ())
            udg_Water_Shield_Number = (udg_Water_Shield_Number + 20.00)
            udg_TempUnitGroup2 = GetUnitsInRangeOfLocAll(280.00, udg_TempLoc3)
            ForGroupBJ(udg_TempUnitGroup2, Trig_Water_shield_Effect_Func003Func007A)
            DestroyGroup(udg_TempUnitGroup2)
            RemoveLocation(udg_TempLoc3)
        else
            DisableTrigger(GetTriggeringTrigger())
            return
        end
        if (Trig_Water_shield_Effect_Func004C()) then
            RemoveUnit(udg_Alodimensional_Being)
            DisableTrigger(gg_trg_Alodimensional1)
            DisableTrigger(GetTriggeringTrigger())
        else
        end
    end

    --===========================================================================
    gg_trg_Water_shield_Effect = CreateTrigger()
    DisableTrigger(gg_trg_Water_shield_Effect)
    TriggerRegisterTimerEventPeriodic(gg_trg_Water_shield_Effect, 0.03)
    TriggerAddAction(gg_trg_Water_shield_Effect, Trig_Water_shield_Effect_Actions)
end)
if Debug then Debug.endFile() end
