if Debug then Debug.beginFile "Game/Abilities/Items/TeleportBomb" end
OnInit.trig("TeleportBomb", function(require)
    ---@return boolean
    function Trig_TeleportBomb_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01A'))) then
            return false
        end
        return true
    end

    function Trig_TeleportBomb_Actions()
        local a       = GetSpellTargetLoc() ---@type location
        udg_TempPoint = GetSpellTargetLoc()
        SetSoundPositionLocBJ(gg_snd_Poweringup, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_Poweringup)
        CreateNUnitsAtLoc(1, FourCC('h015'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING)
        RemoveLocation(udg_TempPoint)
        udg_TempUnit = GetLastCreatedUnit()
        udg_CountUpBarColor = "|cff0000FF"
        BasicAI_IssueDangerArea(a, 800.0, 3.1)
        CountUpBar(udg_TempUnit, 60, 0.05, "TeleportBombExplosion")
        udg_TempPoint = a
        RemoveLocation(a)
    end

    --===========================================================================
    gg_trg_TeleportBomb = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TeleportBomb, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_TeleportBomb, Condition(Trig_TeleportBomb_Conditions))
    TriggerAddAction(gg_trg_TeleportBomb, Trig_TeleportBomb_Actions)
end)
if Debug then Debug.endFile() end
