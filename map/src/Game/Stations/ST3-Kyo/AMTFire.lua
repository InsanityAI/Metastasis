if Debug then Debug.beginFile "Game/Stations/ST3/AMTFire" end
OnInit.trig("AMTFire", function(require)
    ---@return boolean
    function Trig_AMTFire_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06U'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AMTFire_Func004Func004C()
        if ((RectContainsUnit(gg_rct_Space, GetSpellTargetUnit()) ~= true)) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h002'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02H'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02L'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02Q'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02T'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02P'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h031'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h032'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h03J'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AMTFire_Func004C()
        if (not Trig_AMTFire_Func004Func004C()) then
            return false
        end
        return true
    end

    function Trig_AMTFire_Actions()
        local b = GetSpellTargetUnit() ---@type unit
        if (Trig_AMTFire_Func004C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "TRIGSTR_5335")
            IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
            return
        else
        end
        DisplayTextToForce(GetPlayersAll(),
            ("|cffFF0000Antimatter Teleportation Matrix now has a targetting lock on " .. (GetUnitName(GetSpellTargetUnit()) .. "!|r")))
        UnitRemoveAbilityBJ(FourCC('A06U'), gg_unit_h007_0027)
        PlaySoundBJ(gg_snd_Warning)
        udg_TempUnit = gg_unit_h007_0027
        TintUnitOverTime(udg_TempUnit, 45.0, 120, 255, 120)
        StartTimerBJ(udg_Kyo_ATM_WarningTimer, false, 60.00)
        CreateTimerDialogBJ(GetLastCreatedTimerBJ(), ("|cffFF0000ATM- " .. GetUnitName(GetSpellTargetUnit())))
        udg_Kyo_ATM_CountdownWindow = GetLastCreatedTimerDialogBJ()
        PolledWait(59.50)
        PlaySoundBJ(gg_snd_FlashBack1Second)
        PolledWait(0.50)
        DestroyTimerDialogBJ(udg_Kyo_ATM_CountdownWindow)
        DestroyLightningRing(udg_Kyo_ATM_LightningRing)
        udg_TempUnit2 = b
        PlaySoundBJ(gg_snd_BlueFireBurst01)
        PlaySoundBJ(gg_snd_MarkOfChaos01)
        PlaySoundBJ(gg_snd_HumanDissipate1)
        udg_TempUnit = gg_unit_h007_0027
        AddLightningStormEx("DRAL", GetUnitX(udg_TempUnit), GetUnitY(udg_TempUnit), 650.0, GetUnitX(udg_TempUnit2),
            GetUnitY(udg_TempUnit2), 125.0, 26, 90.0)
        UnitDamageTargetBJ(gg_unit_h007_0027, udg_TempUnit2, 900000.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
        PolledWait(0.50)
        SetUnitVertexColorBJ(gg_unit_h007_0027, 100, 100, 100, 0)
        udg_Kyo_ATM_Armed = false
    end

    --===========================================================================
    gg_trg_AMTFire = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_AMTFire, gg_unit_h007_0027, EVENT_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_AMTFire, Condition(Trig_AMTFire_Conditions))
    TriggerAddAction(gg_trg_AMTFire, Trig_AMTFire_Actions)
end)
if Debug then Debug.endFile() end
