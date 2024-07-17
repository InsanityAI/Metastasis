if Debug then Debug.beginFile "Game/Stations/ST4/LaboratoryPower" end
OnInit.trig("LaboratoryPower", function(require)
    ---@return boolean
    function Trig_LaboratoryPower_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06F'))) then
            return false
        end
        return true
    end

    function Trig_LaboratoryPower_Actions()
        TriggerExecute(gg_trg_ResetPowerBonus)
        udg_Power_Bonus = 4
        EnableTrigger(gg_trg_LaboratorySpawnExperiments)
        PlaySoundBJ(gg_snd_LightningShieldTarget)
        SetUnitAnimation(gg_unit_h049_0139, "work")
        udg_TempUnit = gg_unit_h049_0139
        PauseUnitBJ(false, gg_unit_h049_0139)
        RemoveUnitPeriodPause(udg_TempUnit)
        PacificationBotEnable()
    end

    --===========================================================================
    gg_trg_LaboratoryPower = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_LaboratoryPower, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_LaboratoryPower, Condition(Trig_LaboratoryPower_Conditions))
    TriggerAddAction(gg_trg_LaboratoryPower, Trig_LaboratoryPower_Actions)
end)
if Debug then Debug.endFile() end
