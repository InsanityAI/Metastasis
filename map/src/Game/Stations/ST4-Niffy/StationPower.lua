if Debug then Debug.beginFile "Game/Stations/ST4/StationPower" end
OnInit.map("StationPower", function(require)
    ---@return boolean
    function Trig_StationPower_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_StationPower_Func005Func001C()
        if not (IsUnitStation(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_StationPower_Func005A()
        if (Trig_StationPower_Func005Func001C()) then
            UnitAddAbilityBJ(FourCC('A06M'), GetEnumUnit())
            UnitAddAbilityBJ(FourCC('A06L'), GetEnumUnit())
        else
        end
    end

    function Trig_StationPower_Actions()
        TriggerExecute(gg_trg_ResetPowerBonus)
        udg_Power_Bonus = 3
        ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_StationPower_Func005A)
        IncUnitAbilityLevelSwapped(FourCC('A005'), gg_unit_h007_0027)
        PlaySoundBJ(gg_snd_LightningShieldTarget)
    end

    --===========================================================================
    gg_trg_StationPower = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_StationPower, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_StationPower, Condition(Trig_StationPower_Conditions))
    TriggerAddAction(gg_trg_StationPower, Trig_StationPower_Actions)
end)
if Debug then Debug.endFile() end
