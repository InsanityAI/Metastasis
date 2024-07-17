if Debug then Debug.beginFile "Game/Abilities/Suits/GooSpray" end
OnInit.trig("GooSpray", function(require)
    ---@return boolean
    function Trig_GooSpray_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07Y'))) then
            return false
        end
        return true
    end

    function Trig_GooSpray_Actions()
        local a = GetSpellTargetLoc() ---@type location
        TriggerSleepAction(0.40)
        udg_TempPoint = a
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
        SFXThreadClean()
        CreateNUnitsAtLoc(1, FourCC('e036'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_GooSpray = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GooSpray, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_GooSpray, Condition(Trig_GooSpray_Conditions))
    TriggerAddAction(gg_trg_GooSpray, Trig_GooSpray_Actions)
end)
if Debug then Debug.endFile() end
