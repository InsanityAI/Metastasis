if Debug then Debug.beginFile "Game/Stations/ST4/ExplorerPower" end
OnInit.map("ExplorerPower", function(require)
    ---@return boolean
    function Trig_ExplorerPower_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06D'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ExplorerPower_Func005Func001C()
        if not (IsUnitExplorer(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_ExplorerPower_Func005A()
        if (Trig_ExplorerPower_Func005Func001C()) then
            UnitAddAbilityBJ(FourCC('A06K'), GetEnumUnit())
            UnitAddAbilityBJ(FourCC('A06J'), GetEnumUnit())
            UnitAddAbilityBJ(FourCC('A06I'), GetEnumUnit())
        else
        end
    end

    function Trig_ExplorerPower_Actions()
        TriggerExecute(gg_trg_ResetPowerBonus)
        udg_Power_Bonus = 2
        ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_ExplorerPower_Func005A)
        PlaySoundBJ(gg_snd_LightningShieldTarget)
    end

    --===========================================================================
    gg_trg_ExplorerPower = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ExplorerPower, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ExplorerPower, Condition(Trig_ExplorerPower_Conditions))
    TriggerAddAction(gg_trg_ExplorerPower, Trig_ExplorerPower_Actions)
end)
if Debug then Debug.endFile() end
