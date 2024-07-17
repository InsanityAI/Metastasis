if Debug then Debug.beginFile "Game/Stations/ST3/AmbientPower" end
OnInit.map("AmbientPower", function(require)
    ---@return boolean
    function Trig_AmbientPower_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06G'))) then
            return false
        end
        return true
    end

    function Trig_AmbientPower_Func005A()
        CreateNUnitsAtLoc(1, FourCC('e01U'), GetEnumPlayer(), udg_HoldZone, bj_UNIT_FACING)
    end

    function Trig_AmbientPower_Actions()
        TriggerExecute(gg_trg_ResetPowerBonus)
        udg_Power_Bonus = 1
        ForForce(GetPlayersAll(), Trig_AmbientPower_Func005A)
        CreateNUnitsAtLoc(1, FourCC('e01U'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
        PlaySoundBJ(gg_snd_LightningShieldTarget)
    end

    --===========================================================================
    gg_trg_AmbientPower = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AmbientPower, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_AmbientPower, Condition(Trig_AmbientPower_Conditions))
    TriggerAddAction(gg_trg_AmbientPower, Trig_AmbientPower_Actions)
end)
if Debug then Debug.endFile() end
